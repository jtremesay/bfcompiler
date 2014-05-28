cmake_minimum_required(VERSION 2.8)

set(PROJECT_NAME brainfuck)

project(${PROJECT_NAME})

add_definitions(-DENABLE_KLOGGING)

execute_process(COMMAND gnustep-config --objc-flags
    OUTPUT_VARIABLE OBJC_COMPILER_FLAGS
    OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND gnustep-config --base-libs
    OUTPUT_VARIABLE OBJC_LINKER_FLAGS
    OUTPUT_STRIP_TRAILING_WHITESPACE)

set(CMAKE_C_FLAGS
    "${CMAKE_C_FLAGS} ${OBJC_COMPILER_FLAGS} -std=c99")
set(CMAKE_EXE_LINKER_FLAGS
    "${CMAKE_EXE_LINKER_FLAGS} ${OBJC_LINKER_FLAGS}")

file(GLOB_RECURSE SRCS src/*.m)
set_source_files_properties(${SRCS} PROPERTIES LANGUAGE C)

set(LIBS gnustep-base objc m)

add_executable(${PROJECT_NAME} ${SRCS})
target_link_libraries(${PROJECT_NAME} ${LIBS})