file(GLOB_RECURSE SOURCES src/*.cpp include/*.hpp)

if(WIN32)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
endif()

find_package(Boost REQUIRED COMPONENTS fiber)

add_library(WebSocketChessLib SHARED ${SOURCES})

target_include_directories(WebSocketChessLib PUBLIC ${Boost_INCLUDE_DIR} include)

target_link_libraries(WebSocketChessLib PUBLIC 
    Boost::fiber
)
