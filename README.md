# Cross-Compile C/C++ Libraries for Java (JNI/JNA) with Docker

This project cross-compiles C/C++ libraries for Java using **JNI** and **JNA**, producing Linux `.so` and Windows `.dll` binaries from a Docker-based toolchain.

---

##ProjectLayout

- **[src/](src/)** 
- **[src/c/](src/c/)** → C sources 
- **[src/cpp/](src/cpp/)** → C++ sources 
- **[src/java/](src/java/)** → Java sources (JNI/JNA demos)
- **[includes/](includes/)** → Project headers and generated JNI headers 
- **[includes/win32/](includes/win32/)** → Windows JNI headers (`jni.h`, `jni_md.h`)
- **[Linux/JNI/](Linux/JNI/)** → Linux JNI build output
- **[Linux/JNA/](Linux/JNA/)** → Linux JNA build output
- **[Win/JNI/](Win/JNI/)** → Windows JNI build output
- **[Win/JNA/](Win/JNA/)** → Windows JNA build output

---

##QuickStart

### 0) Build the Docker image (first time only)

The first build can take a while because the toolchain is downloaded and configured. This is expected.

```sh
docker compose build
```

### 1) Build JNA (Linux + Windows)

Choose one of the available JNA builders:

- **C library (JNA)** 
```sh 
docker compose run --rm jna-c 
```
- **C++ library (JNA)** 
```sh 
docker compose run --rm jna-cpp 
```

Outputs:
- `Linux/JNA/*.so`
- `Win/JNA/*.dll`

### 2) Build JNI (Linux + Windows)

Choose one of the available JNI builders:

- **C library (JNI)** 
```sh 
docker compose run --rm jni-c 
```
- **C++ library (JNI)** 
```sh 
docker compose run --rm jni-cpp 
```

Outputs:
- `Linux/JNI/*.so`
- `Win/JNI/*.dll`

---

##Windows JNI Headers

To cross-compile JNI for Windows, you must provide the Windows JNI headers:

- **[includes/win32/jni.h](includes/win32/jni.h)**
- **[includes/win32/jni_md.h](includes/win32/jni_md.h)**

These come from a Windows JDK (e.g., Adoptium/OpenJDK). They are required only for compilation, not runtime.

---

##BuildScript

There is a helper script in **[build.sh](build.sh)** if you want to run builds locally or wrap Docker commands.

---

##Notes

- The output directories (**[Linux/JNI/](Linux/JNI/)**, **[Linux/JNA/](Linux/JNA/)**, **[Win/JNI/](Win/JNI/)**, **[Win/JNA/](Win/JNA/)**) are intentionally kept in the repo for consistent structure.
- **Linux builds are compiled against musl (Alpine).** If you plan to use the `.so` files on Ubuntu/Debian (glibc), you will need to rebuild them with a glibc-based toolchain.

### Library Name Customization

The Docker Compose services set `LIB_NAME` so you can control the output library name. Edit [docker-compose.yml](docker-compose.yml) and change the values ​​if needed.

Example:

```
environment: 
- LIB_NAME=myLibJNA_C
```

This affects the filename produced in the output directories.

---

## Source Files

- **JNI** 
- C: **[src/c/HelloJNI.c](src/c/HelloJNI.c)** 
- C++: **[src/cpp/HelloJNI.cpp](src/cpp/HelloJNI.cpp)** 
- Java: **[src/java/HelloJNI.java](src/java/HelloJNI.java)**

- **JNA** 
- C++: **[src/cpp/HelloJNA.cpp](src/cpp/HelloJNA.cpp)** 
- Java: **[src/java/HelloJNA.java](src/java/HelloJNA.java)**