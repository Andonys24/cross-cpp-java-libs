#!/bin/sh
# ./build.sh [MODO: jni/jna] [LANG: c/cpp]

MODE=$(echo $1 | tr '[:lower:]' '[:upper:]') 
LANG=$2
LIB_NAME=${LIB_NAME:-mylib}

# 1. Compiler Configuration
if [ "$LANG" = "cpp" ]; then
    CC="g++"
    WIN_CC="x86_64-w64-mingw32-g++"
    EXT="cpp"
    SRC_DIR="src/cpp"
else
    CC="gcc"
    WIN_CC="x86_64-w64-mingw32-gcc"
    EXT="c"
    SRC_DIR="src/c"
fi

# 2. Create output folders (Vital to avoid the 'No such file' error)
mkdir -p Linux/$MODE Win/$MODE

# 3. File Verification
if [ ! -d "$SRC_DIR" ] || [ -z "$(ls -A $SRC_DIR/*.$EXT 2>/dev/null)" ]; then
    echo "Error: No files found .$EXT in $SRC_DIR"
    exit 1
fi

echo "Compiling $LANG for $MODE (Library: $LIB_NAME)..."

# 4. Linux Compilation (.so)
# -Iincludes: to find HolaJNI.h
# -I$JAVA_HOME...: to find the system's jni.h
$CC -fPIC -shared -static-libgcc -static-libstdc++ \
    -Iincludes \
    -I$JAVA_HOME/include \
    -I$JAVA_HOME/include/linux \
    $SRC_DIR/*.$EXT -o Linux/$MODE/lib${LIB_NAME}.so

# 5. Windows Compilation (.dll)
# -Iincludes/win32: to find the Windows jni.h and jni_md.h files you have there
$WIN_CC -shared -static -static-libgcc -static-libstdc++ \
    -Iincludes \
    -Iincludes/win32 \
    $SRC_DIR/*.$EXT -o Win/$MODE/${LIB_NAME}.dll

echo "Build completed successfully for $LIB_NAME!"