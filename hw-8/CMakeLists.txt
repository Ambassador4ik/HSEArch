cmake_minimum_required(VERSION 3.10)
set(CMAKE_CXX_STANDARD 23)

project(hw-8 LANGUAGES C)

add_executable(hw-8 dotProduct.c)

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)
