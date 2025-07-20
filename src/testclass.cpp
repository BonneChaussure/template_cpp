#include "testclass.hpp"

#include <spdlog/spdlog.h>

using namespace test;

void TestClass::printHello()
{
    spdlog::info("Hello");
}