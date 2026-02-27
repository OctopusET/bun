set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR riscv64)

# Cross-compilation with riscv64-linux-gnu-gcc (from Arch riscv64-linux-gnu-gcc)
# or clang --target=riscv64-linux-gnu.
#
# For GCC cross-compiler:
#   cmake -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/linux-riscv64.cmake ...
#
# For clang cross-compiler:
#   cmake -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/linux-riscv64.cmake \
#         -DUSE_CLANG_CROSS=ON ...

option(USE_CLANG_CROSS "Use clang instead of GCC for cross-compilation" OFF)

set(RISCV64_SYSROOT "/usr/riscv64-linux-gnu" CACHE PATH "riscv64 sysroot path")

if(USE_CLANG_CROSS)
    set(CMAKE_C_COMPILER clang)
    set(CMAKE_CXX_COMPILER clang++)
    set(CMAKE_C_COMPILER_TARGET riscv64-linux-gnu)
    set(CMAKE_CXX_COMPILER_TARGET riscv64-linux-gnu)
    set(CMAKE_C_FLAGS_INIT "--sysroot=${RISCV64_SYSROOT} -march=rv64gc")
    set(CMAKE_CXX_FLAGS_INIT "--sysroot=${RISCV64_SYSROOT} -march=rv64gc")
    set(CMAKE_EXE_LINKER_FLAGS_INIT "--sysroot=${RISCV64_SYSROOT} -fuse-ld=lld")
else()
    set(CMAKE_C_COMPILER riscv64-linux-gnu-gcc)
    set(CMAKE_CXX_COMPILER riscv64-linux-gnu-g++)
    set(CMAKE_C_FLAGS_INIT "-march=rv64gc")
    set(CMAKE_CXX_FLAGS_INIT "-march=rv64gc")
endif()

set(CMAKE_FIND_ROOT_PATH ${RISCV64_SYSROOT})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
