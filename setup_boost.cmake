execute_process(COMMAND conan --version RESULT_VARIABLE CONAN_NOT_FIND)
if(CONAN_NOT_FIND)
    message(STATUS "Downloading conan")
    execute_process(COMMAND "pip install conan==1.54.0" "--use-pep517")
endif()

if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
    message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
    file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/0.18.1/conan.cmake"
        "${CMAKE_BINARY_DIR}/conan.cmake"
        TLS_VERIFY ON)
endif()

include(${CMAKE_BINARY_DIR}/conan.cmake)

conan_cmake_run(
    REQUIRES
        boost/1.79.0

    BASIC_SETUP
    CMAKE_TARGETS
    BUILD_TYPE ${CMAKE_BUILD_TYPE}

    BUILD missing
    GENERATORS cmake_find_package)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${CMAKE_BINARY_DIR}")