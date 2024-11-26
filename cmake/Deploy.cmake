include(CMakePackageConfigHelpers)
include(GNUInstallDirs)
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/install" CACHE PATH "Install prefix" FORCE)
endif()

set(INSTALL_AWESOME_HOME "${CMAKE_INSTALL_INCLUDEDIR}")
set(CONFIG_FILE "${CMAKE_CURRENT_BINARY_DIR}/AwesomeConfig.cmake")
set(CONFIG_VERSION_FILE "${CMAKE_CURRENT_BINARY_DIR}/AwesomeConfigVersion.cmake")
set(CONFIG_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/Awesome")

configure_package_config_file(
    "${AWESOME_HOME}/AwesomeConfig.cmake.in"
    "${CONFIG_FILE}"
    INSTALL_DESTINATION "${CONFIG_DESTINATION}")

write_basic_package_version_file("${CONFIG_VERSION_FILE}"
    COMPATIBILITY AnyNewerVersion)

install(TARGETS ${LIB}
    EXPORT AwesomeTargets
    INCLUDES DESTINATION "${INSTALL_AWESOME_HOME}")

install(EXPORT AwesomeTargets
    NAMESPACE Awesome::
    DESTINATION "${CONFIG_DESTINATION}")

install(FILES "${CONFIG_FILE}" "${CONFIG_VERSION_FILE}"
    DESTINATION "${CONFIG_DESTINATION}")

install(FILES "${VERSION_FILE}"
    DESTINATION "${INSTALL_AWESOME_HOME}/awesome")

# setting the PUBLIC_HEADER property does not preserve the folder structure
# so instead we don't use it, iterate through public headers and install them manually
foreach(HEADER ${HEADERS})
    file(RELATIVE_PATH HEADER_FILE_PATH "${AWESOME_HOME}" "${HEADER}")
    get_filename_component(HEADER_DIRECTORY_PATH "${HEADER_FILE_PATH}" DIRECTORY)
    install(FILES ${HEADER}
        DESTINATION "${INSTALL_AWESOME_HOME}/${HEADER_DIRECTORY_PATH}")
endforeach()
