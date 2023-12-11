cmake_minimum_required(VERSION 3.10)
set(CMAKE_CXX_STANDARD 23)

project(hw-9 LANGUAGES C)

add_executable(hw-9 strangeThing.c)

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)
