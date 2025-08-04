#!/bin/bash

# Build both Photo-SLAM versions
# Usage: ./build_all.sh

set -e

echo "Building Photo-SLAM Project..."
echo "================================"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Build original Photo-SLAM
echo ""
echo "Building Photo-SLAM (Original)..."
echo "--------------------------------"
if [ -d "$SCRIPT_DIR/PhotoSLAM" ]; then
    cd "$SCRIPT_DIR/PhotoSLAM"
    if [ -f "build.sh" ]; then
        chmod +x build.sh
        ./build.sh
        echo "✓ Photo-SLAM (Original) built successfully"
    else
        echo "✗ build.sh not found in PhotoSLAM directory"
        exit 1
    fi
else
    echo "✗ PhotoSLAM directory not found"
    exit 1
fi

# Build Photo-SLAM RTGS
echo ""
echo "Building Photo-SLAM RTGS..."
echo "---------------------------"
if [ -d "$SCRIPT_DIR/PhotoSLAM_RTGS" ]; then
    cd "$SCRIPT_DIR/PhotoSLAM_RTGS"
    if [ -f "build.sh" ]; then
        chmod +x build.sh
        ./build.sh
        echo "✓ Photo-SLAM RTGS built successfully"
    else
        echo "✗ build.sh not found in PhotoSLAM_RTGS directory"
        exit 1
    fi
else
    echo "✗ PhotoSLAM_RTGS directory not found"
    exit 1
fi

echo ""
echo "================================="
echo "✓ All builds completed successfully!"
echo ""
echo "You can now use:"
echo "  ./run_original.sh [dataset_type] [scene_name] [dataset_path] [results_path]"
echo "  ./run_rtgs.sh [dataset_type] [scene_name] [dataset_path] [results_path]" 