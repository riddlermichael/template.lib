set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
if(NOT DEFINED CMAKE_CXX_VISIBILITY_PRESET AND NOT DEFINED CMAKE_VISIBILITY_INLINES_HIDDEN)
    set(CMAKE_CXX_VISIBILITY_PRESET hidden)
    set(CMAKE_VISIBILITY_INLINES_HIDDEN YES)
endif()

set(ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR})
add_subdirectory(awesome)

if(IS_TOP_LEVEL_PROJECT)
    # build app
    set(APP awesome-main)
    add_executable(${APP} main.cpp)
    target_link_libraries(${APP} PUBLIC Awesome::Awesome)
endif()
