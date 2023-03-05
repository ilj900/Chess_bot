find_package(Boost REQUIRED COMPONENTS fiber)

file(GLOB_RECURSE SOURCES *.cpp *.hpp)

add_executable(WCSL_server ${SOURCES})

target_include_directories(WCSL_server PUBLIC ${Boost_INCLUDE_DIR})