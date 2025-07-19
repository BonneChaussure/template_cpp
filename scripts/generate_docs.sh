#!/bin/bash

set -e

# Générer la documentation
doxygen Doxyfile

DOC_PATH="docs/html/index.html"

if [ -f "$DOC_PATH" ]; then
    echo "✅ Documentation generated at $DOC_PATH"
    
    echo "📖 Use this command to open it manually:"
    echo "   open $DOC_PATH      # macOS"
    echo "   xdg-open $DOC_PATH  # Linux"
    echo "   start $DOC_PATH     # Windows (Git Bash / WSL)"
else
    echo "❌ Documentation not found at $DOC_PATH"
    exit 1
fi
