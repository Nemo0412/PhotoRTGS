#!/bin/bash

# Download datasets for both Photo-SLAM versions
# Usage: ./download_datasets.sh

set -e

echo "Downloading datasets for Photo-SLAM Project..."
echo "=============================================="

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Download datasets for original Photo-SLAM
echo ""
echo "Downloading datasets for Photo-SLAM (Original)..."
echo "------------------------------------------------"
if [ -d "$SCRIPT_DIR/PhotoSLAM/scripts" ]; then
    cd "$SCRIPT_DIR/PhotoSLAM/scripts"
    chmod +x ./*.sh
    
    echo "Downloading Replica dataset..."
    ./download_replica.sh
    
    echo "Downloading TUM dataset..."
    ./download_tum.sh
    
    echo "Downloading EuRoC dataset..."
    ./download_euroc.sh
    
    echo "✓ Datasets downloaded for Photo-SLAM (Original)"
else
    echo "✗ PhotoSLAM/scripts directory not found"
    exit 1
fi

# Download datasets for Photo-SLAM RTGS
echo ""
echo "Downloading datasets for Photo-SLAM RTGS..."
echo "------------------------------------------"
if [ -d "$SCRIPT_DIR/PhotoSLAM_RTGS/scripts" ]; then
    cd "$SCRIPT_DIR/PhotoSLAM_RTGS/scripts"
    chmod +x ./*.sh
    
    echo "Downloading Replica dataset..."
    ./download_replica.sh
    
    echo "Downloading TUM dataset..."
    ./download_tum.sh
    
    echo "Downloading EuRoC dataset..."
    ./download_euroc.sh
    
    echo "✓ Datasets downloaded for Photo-SLAM RTGS"
else
    echo "✗ PhotoSLAM_RTGS/scripts directory not found"
    exit 1
fi

echo ""
echo "=============================================="
echo "✓ All datasets downloaded successfully!"
echo ""
echo "You can now run experiments with:"
echo "  ./run_original.sh [dataset_type] [scene_name] [dataset_path] [results_path]"
echo "  ./run_rtgs.sh [dataset_type] [scene_name] [dataset_path] [results_path]" 