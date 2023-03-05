cmake_minimum_required(VERSION 3.13)

project(Chess_bot)

set(CMAKE_CXX_STANDARD 17)


include_directories(
        include)


set(SOURCE
        src/main.cpp)

set(INCLUDE
		include/main.h)

add_executable(${PROJECT_NAME} ${SOURCE} ${INCLUDE})

include(setup_boost.cmake)

add_subdirectory("WebSocketChessLib")
add_subdirectory("WebSocketChessLib/test/server")
