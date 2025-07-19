#include "testclass.hpp"

#include <iostream>

int main()
{
    std::cout << "Hello, C++ on macOS with CMake and Clang!" << '\n';
    test::TestClass::printHello();
    return 0;
}
