cmake_minimum_required(VERSION 3.13)

project(Chess_bot)

set(CMAKE_CXX_STANDARD 17)


include_directories(
        include)


set(SOURCE
        src/main.cpp
		src/chess_board.cpp
		src/uci.cpp)

set(INCLUDE
		include/main.h
		include/chess_board.h
		include/uci.h)

add_executable(${PROJECT_NAME} ${SOURCE} ${INCLUDE})
