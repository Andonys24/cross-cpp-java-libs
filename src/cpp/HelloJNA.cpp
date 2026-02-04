#include <iostream>

extern "C" {
    void sayHelloJNA() {
        std::cout << "Hello from C++ using JNA! (Without Java headers)" << std::endl;
    }
}
