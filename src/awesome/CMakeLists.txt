set(AWESOME_HOME ${ROOT_DIR} CACHE PATH "Awesome home" FORCE)
set(AWESOME_ROOT_DIR "${AWESOME_HOME}/awesome" CACHE PATH "Awesome root" FORCE)
set(PRODUCT_NAME awesome)

option(BUILD_SHARED_LIBS "Build shared libraries")
# in rare cases an user may want to build some libs in other way than BUILD_SHARED_LIBS determines
# (for example all used libs are shared, but Awesome should be built as static)
if(DEFINED AWESOME_USE_SHARED_LIBS)
    set(BUILD_SHARED_LIBS "${AWESOME_USE_SHARED_LIBS}")
endif()

# generate version file
set(GENERATED_INCLUDE_DIR "${CMAKE_BINARY_DIR}/include")
set(VERSION_FILE "${GENERATED_INCLUDE_DIR}/${PRODUCT_NAME}/version.hpp")
configure_file(version.hpp.in "${VERSION_FILE}")

# collect sources
set(MODULES
    core)
set(HEADERS)
set(SOURCES)
foreach(X ${MODULES})
    add_cxx_module(${X} ${AWESOME_ROOT_DIR})
endforeach()

source_group(TREE "${ROOT_DIR}" FILES ${HEADERS} ${SOURCES})

# create lib
set(INCLUDE_DIRS
    $<BUILD_INTERFACE:${AWESOME_HOME}>
    $<BUILD_INTERFACE:${GENERATED_INCLUDE_DIR}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

if(${BUILD_SHARED_LIBS})
    set(LIB ${PRODUCT_NAME}-shared)
else()
    set(LIB ${PRODUCT_NAME})
endif()

add_library(${LIB} ${HEADERS} ${SOURCES})
add_library(Awesome::Awesome ALIAS ${LIB})
target_compile_definitions(${LIB}
    PUBLIC $<$<NOT:$<BOOL:${BUILD_SHARED_LIBS}>>:AW_STATIC> # see export.hpp
    PRIVATE AW_EXPORTS)
target_include_directories(${LIB}
    PUBLIC $<BUILD_INTERFACE:${INCLUDE_DIRS}>
    PUBLIC $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
set(OUTPUT_DIR "${CMAKE_BINARY_DIR}")
set_target_properties(${LIB} PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY ${OUTPUT_DIR} # .lib/.a for static, .lib for shared on Windows
    DEBUG_POSTFIX d
    EXPORT_NAME Awesome
    LIBRARY_OUTPUT_DIRECTORY ${OUTPUT_DIR} # .so
    RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR} # .dll
    SOVERSION ${PROJECT_VERSION_MAJOR}
    VERSION ${PROJECT_VERSION})

if(IS_TOP_LEVEL_PROJECT AND NOT CMAKE_SKIP_INSTALL_RULES)
    include(Deploy)
endif()
