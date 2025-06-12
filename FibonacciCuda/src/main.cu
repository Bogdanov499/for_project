#include <iostream>
#include <vector>
#include <cstdint>
#include <cuda_runtime.h>

// Ядро: вычисление чисел Фибоначчи
__global__ void fibonacciKernel(uint64_t* d_fib, int N) {
    int i = threadIdx.x + blockIdx.x * blockDim.x;

    if (i == 0) {
        d_fib[i] = 0;
    } else if (i == 1) {
        d_fib[i] = 1;
    } else if (i < N) {
        uint64_t a = 0, b = 1;
        for (int j = 2; j <= i; ++j) {
            uint64_t tmp = a + b;
            a = b;
            b = tmp;
        }
        d_fib[i] = b;
    }
}

// Хост-функция: вызов ядра и копирование данных
void computeFibonacciGPU(std::vector<uint64_t>& fib) {
    int N = fib.size();

    uint64_t* d_fib;
    cudaMalloc(&d_fib, N * sizeof(uint64_t));

    int threadsPerBlock = 256;
    int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;

    fibonacciKernel<<<blocksPerGrid, threadsPerBlock>>>(d_fib, N);

    cudaMemcpy(fib.data(), d_fib, N * sizeof(uint64_t), cudaMemcpyDeviceToHost);

    cudaFree(d_fib);
}

// Точка входа
int main() {
    const int N = 50;
    std::vector<uint64_t> fib(N);

    computeFibonacciGPU(fib);

    std::cout << "Первые " << N << " чисел Фибоначчи:\n";
    for (int i = 0; i < N; ++i) {
        std::cout << fib[i] << " ";
    }
    std::cout << std::endl;

    return 0;
}