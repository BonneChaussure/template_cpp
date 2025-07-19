#!/usr/bin/env bash

set -e  # Stop on error
set -o nounset

# -------- CONFIG --------
BUILD_TYPE=${1:-Debug}
BUILD_DIR="build"

# -------- INFO --------
echo "=============================="
echo "Building in $BUILD_TYPE mode"
echo "=============================="

# -------- SETUP --------
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Detect compiler (optional: override if needed)
if command -v clang++ &> /dev/null; then
    export CXX=clang++
    echo "Using compiler: clang++"
elif command -v g++ &> /dev/null; then
    export CXX=g++
    echo "Using compiler: g++"
else
    echo "No supported C++ compiler found (clang++ or g++)"
    exit 1
fi

# -------- GENERATE --------
cmake -DCMAKE_BUILD_TYPE="$BUILD_TYPE" ..

# -------- BUILD (parallel) --------
# Detect CPU core count
if command -v nproc &> /dev/null; then
    CORES=$(nproc)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    CORES=$(sysctl -n hw.ncpu)
else
    CORES=4  # default fallback
fi

echo "🧵 Building using $CORES threads..."
cmake --build . --parallel "$CORES"

echo "✅ Build complete."