#include <iostream>
#include <vector>
#include <cstdint>  // для uint64_t

// Объявляем функцию здесь, если нет заголовочного файла
void computeFibonacci(std::vector<uint64_t>& fib);

int main() {
    const int N = 50;
    std::vector<uint64_t> fib(N);

    computeFibonacci(fib);

    std::cout << "First " << N << " of number Fibonacci:\n";
    for (int i = 0; i < N; ++i) {
        std::cout << fib[i] << " ";
    }
    std::cout << std::endl;

    return 0;
}

// Реализация функции прямо в main.cpp
void computeFibonacci(std::vector<uint64_t>& fib) {
    int n = fib.size();
    if (n >= 1) fib[0] = 0;
    if (n >= 2) fib[1] = 1;

    for (int i = 2; i < n; ++i) {
        fib[i] = fib[i - 1] + fib[i - 2];
    }
}