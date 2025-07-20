#!/bin/bash

set -e

echo "🔍 Detecting operating system..."

OS="$(uname)"
CLANG_INSTALLED=false
CMAKE_INSTALLED=false

install_on_mac() {
    echo "🍏 macOS detected"

    # Install Xcode CLI tools if not present
    if ! xcode-select -p >/dev/null 2>&1; then
        echo "🔧 Installing Xcode Command Line Tools..."
        xcode-select --install
    else
        echo "✅ Xcode Command Line Tools already installed"
    fi

    # Install other tools via Homebrew
    if ! command -v brew >/dev/null 2>&1; then
        echo "🔧 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo "📦 Installing dependencies..."
    brew install cmake make doxygen

    export CXX=clang++
}

install_on_linux() {
    echo "🐧 Linux detected"

    if command -v apt >/dev/null 2>&1; then
        echo "📦 Installing dependencies with apt..."
        sudo apt update
        sudo apt install -y clang cmake make doxygen
    elif command -v pacman >/dev/null 2>&1; then
        echo "📦 Installing dependencies with pacman..."
        sudo pacman -Sy --noconfirm clang cmake make doxygen
    else
        echo "❌ Unsupported package manager. Install clang, cmake, and make manually."
        exit 1
    fi

    export CXX=clang++
}

install_on_windows() {
    echo "🪟 Windows (Git Bash or WSL) detected"

    # Vérifie si choco est installé
    if ! command -v choco >/dev/null 2>&1; then
        echo "❌ Chocolatey is not installed on your machine, please download it manually."
        exit 1
    else
        echo "✅ Chocolatey already installed"
    fi

    echo "📦 Installing dependencies via Chocolatey..."

    choco install -y llvm cmake doxygen

    echo "✅ Dependencies installed"

    export CXX=clang++
    echo "🔧 CXX set to clang++"
}

case "$OS" in
    Darwin)
        install_on_mac
        ;;
    Linux)
        install_on_linux
        ;;
    MINGW*|MSYS*|CYGWIN*|Windows_NT)
        install_on_windows
        ;;
    *)
        echo "❌ Unsupported OS: $OS"
        exit 1
        ;;
esac

echo ""

echo "✅ Environment ready. You can now run:"

echo ""
echo "   ./scripts/build.sh"
echo "   ./delivery/Debug/clang++/<YOUR_PROCESSOR>/your_executable"
echo ""

exit 0
