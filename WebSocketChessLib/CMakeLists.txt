cmake_minimum_required(VERSION 3.13)
project(WebSocketChessLib)

file(GLOB SOURCES *.hpp *.cpp)

set(CMAKE_CXX_STANDARD 17)

find_program(CONAN conan)
if(NOT ${CONAN})
    message("Downloading conan")
    execute_process(COMMAND pip install conan==1.54.0)
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

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)

find_package(Boost REQUIRED COMPONENTS beast fiber)

# target_link_libraries(${PROJECT_NAME} PUBLIC 
#     Boost::beast,
#     Boost::fiber
# )

add_library(WebSockeChesstLib ${SOURCES})
