#!/bin/bash

# SwiftLint Installation Script for SWPlanetViewer
echo "Installing SwiftLint for SWPlanetViewer..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Please install Homebrew first:"
    echo "https://brew.sh/"
    exit 1
fi

# Install SwiftLint
echo "Installing SwiftLint via Homebrew..."
brew install swiftlint

# Verify installation
if command -v swiftlint &> /dev/null; then
    echo "✅ SwiftLint installed successfully!"
    echo "Version: $(swiftlint version)"
    echo ""
    echo "SwiftLint is now configured to run during Xcode builds."
    echo "You should see linting errors directly in Xcode's Issue Navigator."
    echo ""
    echo "To test the integration:"
    echo "1. Open SWPlanetViewer.xcworkspace in Xcode"
    echo "2. Build the project (Cmd+B)"
    echo "3. Check the Issue Navigator for any SwiftLint warnings/errors"
else
    echo "❌ SwiftLint installation failed"
    exit 1
fi
