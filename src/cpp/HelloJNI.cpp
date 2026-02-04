#include <jni.h>
#include <iostream>
#include "HelloJNI.h"

// The extern "C" is required in C++ for JNI to find the function
extern "C" {
    JNIEXPORT void JNICALL Java_HelloJNI_sayHello(JNIEnv *env, jobject obj) {
        std::cout << "Hello from C++ using JNI and streams!" << std::endl;
    }
}
