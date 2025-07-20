#include "testclass.hpp"

#include <spdlog/spdlog.h>

int main()
{
    // Set the global level
    spdlog::set_level(spdlog::level::info);
    // Set a log pattern
    spdlog::set_pattern("[%Y-%m-%d %H:%M:%S:.%e] [%^%l%$] [thread %t] %v");

    spdlog::info("Hello, C++ on macOS with CMake and Clang!");
    test::TestClass::printHello();
    return 0;
}
