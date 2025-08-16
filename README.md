docker compose run --rm jna-builder
docker compose run --rm jni-builder
# CompileCppLibraries - Docker Cross-Compile para JNI y JNA

## Descripción

Este proyecto permite compilar librerías C++ para Java (JNI y JNA) tanto para Linux (.so) como para Windows (.dll) usando Docker y cross-compiling.
Ideal para proyectos multiplataforma y para automatizar builds sin depender de entornos de desarrollo específicos.

---

## Estructura de carpetas

- cpp/            → Código fuente C++
- includes/       → Headers propios y JNI generados por javac
- includes/win32/ → Headers JNI de Windows (jni.h y jni_md.h)
- Win/JNA/        → Salida DLL para JNA
- Win/JNI/        → Salida DLL para JNI
- Linux/JNA/      → Salida SO para JNA
- Linux/JNI/      → Salida SO para JNI

---

## Uso rápido

### 1. Compilar para JNA (Windows y Linux)

	docker compose run --rm jna-builder

Genera:
- Win/JNA/myLib.dll
- Linux/JNA/libmyLib.so

### 2. Compilar para JNI (Windows y Linux)

Asegúrate de tener en `includes/win32/` los headers JNI de Windows (`jni.h` y `jni_md.h`).

	docker compose run --rm jni-builder

Genera:
- Win/JNI/mylib.dll
- Linux/JNI/libmylib.so

---

## Requisitos

- Docker y Docker Compose
- Tener los headers JNI de Windows en `includes/win32/` (puedes copiarlos desde un JDK de Windows)

---

## Notas

- Si cambias el nombre de la librería, ajusta los comandos en `docker-compose.yml`.
- Para debug de memoria en Linux, puedes usar ASan o Valgrind, pero en Windows no están disponibles.
- Puedes usar WSL2 para debuggear en Linux y compilar en ambos sistemas.

### Sobre los headers JNI de Windows

Los archivos `jni.h` y `jni_md.h` en `includes/win32/` provienen de un JDK de Windows (por ejemplo, OpenJDK o Adoptium) y se incluyen únicamente para permitir la compilación cruzada de librerías JNI para Windows desde entornos Linux. No contienen código propietario ni binarios, solo definiciones estándar de la interfaz JNI.

---

## Consejos

- Mantén sincronizados los headers JNI según la plataforma de destino.
- Si tienes problemas con JNI, revisa siempre los paths de los includes y la versión de los headers.

---

¡Feliz cross-compiling!

