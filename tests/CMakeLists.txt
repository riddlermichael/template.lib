# test project
project(awesome-tests LANGUAGES CXX)

# collect tests
set(MODULES_WITH_TESTS)
set(SOURCES)
foreach(X ${MODULES_WITH_TESTS})
    add_cxx_module(${X}/test ${AWESOME_ROOT_DIR})
endforeach()

# build test app
set(TEST_APP ${PROJECT_NAME})
add_executable(${TEST_APP} main.cpp ${SOURCES})
target_link_libraries(${TEST_APP} PRIVATE Awesome::Awesome)
