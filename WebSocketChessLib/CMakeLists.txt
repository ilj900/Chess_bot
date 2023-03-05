cmake_minimum_required(VERSION 3.13)
project(WebSocketChessLib)

file(GLOB_RECURSE SOURCES src/*.cpp)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})

if(WIN32)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
endif()

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

# conan_cmake_run(
#     REQUIRES
#         boost/1.79.0

#     BASIC_SETUP
#     CMAKE_TARGETS
#     BUILD_TYPE ${CMAKE_BUILD_TYPE}

#     BUILD missing
#     GENERATORS cmake_find_package)

conan_cmake_configure(
    REQUIRES
        boost/1.79.0
    GENERATORS
        cmake_find_package
)

conan_cmake_install(
    PATH_OR_REFERENCE .
    BUILD missing
    REMOTE conancenter
)

find_package(Boost REQUIRED COMPONENTS fiber)

add_library(${PROJECT_NAME} SHARED ${SOURCES})

target_include_directories(${PROJECT_NAME} PUBLIC ${Boost_INCLUDE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/include)

target_link_libraries(${PROJECT_NAME} PUBLIC 
    Boost::fiber
)
