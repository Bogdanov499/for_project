cmake_minimum_required(VERSION 3.28)
project(FibonacciCuda LANGUAGES CXX CUDA)

# Указываем версию CUDA (12.5 поддерживается через политики и флаги)
set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

# Устанавливаем флаги компиляции
set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} --extended-lambda")

# Добавляем исполняемый файл
add_executable(fibonacci_cuda src/main.cu)