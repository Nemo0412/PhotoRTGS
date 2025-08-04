#!/bin/bash

# Photo-SLAM Original Runner Script
# Usage: ./run_original.sh [dataset_type] [scene_name] [dataset_path] [results_path] [options]

set -e

# Check arguments
if [ $# -lt 4 ]; then
    echo "Usage: $0 [dataset_type] [scene_name] [dataset_path] [results_path] [options]"
    echo ""
    echo "Dataset types:"
    echo "  mono    - Monocular camera datasets"
    echo "  rgbd    - RGB-D camera datasets"
    echo "  stereo  - Stereo camera datasets"
    echo ""
    echo "Scene names:"
    echo "  TUM: tum_freiburg1_desk, tum_freiburg2_xyz, tum_freiburg3_long_office_household"
    echo "  Replica: office0, office1, office2, room0, room1, room2, apartment0, apartment1, apartment2"
    echo "  EuRoC: EuRoC"
    echo ""
    echo "Options:"
    echo "  no_viewer - Disable viewer for evaluation"
    echo ""
    echo "Examples:"
    echo "  $0 rgbd tum_freiburg1_desk /path/to/tum/dataset /path/to/results"
    echo "  $0 rgbd office0 /path/to/replica/dataset /path/to/results no_viewer"
    exit 1
fi

DATASET_TYPE=$1
SCENE_NAME=$2
DATASET_PATH=$3
RESULTS_PATH=$4
OPTIONS=${@:5}

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PHOTOSLAM_DIR="$SCRIPT_DIR/PhotoSLAM"

# Check if PhotoSLAM directory exists
if [ ! -d "$PHOTOSLAM_DIR" ]; then
    echo "Error: PhotoSLAM directory not found at $PHOTOSLAM_DIR"
    exit 1
fi

# Check if dataset path exists
if [ ! -d "$DATASET_PATH" ]; then
    echo "Error: Dataset path does not exist: $DATASET_PATH"
    exit 1
fi

# Create results directory
mkdir -p "$RESULTS_PATH"

# Function to determine executable and config files
get_executable_and_config() {
    local dataset_type=$1
    local scene_name=$2
    
    case $dataset_type in
        "mono")
            case $scene_name in
                "tum_freiburg1_desk"|"tum_freiburg2_xyz"|"tum_freiburg3_long_office_household")
                    echo "tum_mono"
                    echo "cfg/ORB_SLAM3/Monocular/TUM/${scene_name}.yaml"
                    echo "cfg/gaussian_mapper/Monocular/TUM/${scene_name}.yaml"
                    ;;
                "office0"|"office1"|"office2"|"room0"|"room1"|"room2"|"apartment0"|"apartment1"|"apartment2")
                    echo "replica_mono"
                    echo "cfg/ORB_SLAM3/Monocular/Replica/${scene_name}.yaml"
                    echo "cfg/gaussian_mapper/Monocular/Replica/${scene_name}.yaml"
                    ;;
                *)
                    echo "Error: Unknown scene name for mono dataset: $scene_name"
                    exit 1
                    ;;
            esac
            ;;
        "rgbd")
            case $scene_name in
                "tum_freiburg1_desk"|"tum_freiburg2_xyz"|"tum_freiburg3_long_office_household")
                    echo "tum_rgbd"
                    echo "cfg/ORB_SLAM3/RGB-D/TUM/${scene_name}.yaml"
                    echo "cfg/gaussian_mapper/RGB-D/TUM/${scene_name}.yaml"
                    ;;
                "office0"|"office1"|"office2"|"room0"|"room1"|"room2"|"apartment0"|"apartment1"|"apartment2")
                    echo "replica_rgbd"
                    echo "cfg/ORB_SLAM3/RGB-D/Replica/${scene_name}.yaml"
                    echo "cfg/gaussian_mapper/RGB-D/Replica/${scene_name}.yaml"
                    ;;
                *)
                    echo "Error: Unknown scene name for rgbd dataset: $scene_name"
                    exit 1
                    ;;
            esac
            ;;
        "stereo")
            case $scene_name in
                "EuRoC")
                    echo "euroc_stereo"
                    echo "cfg/ORB_SLAM3/Stereo/EuRoC/EuRoC.yaml"
                    echo "cfg/gaussian_mapper/Stereo/EuRoC/EuRoC.yaml"
                    ;;
                *)
                    echo "Error: Unknown scene name for stereo dataset: $scene_name"
                    exit 1
                    ;;
            esac
            ;;
        *)
            echo "Error: Unknown dataset type: $dataset_type"
            exit 1
            ;;
    esac
}

# Get executable and config files
read -r EXECUTABLE ORB_CONFIG GAUSSIAN_CONFIG <<< "$(get_executable_and_config $DATASET_TYPE $SCENE_NAME)"

# Check if executable exists
EXECUTABLE_PATH="$PHOTOSLAM_DIR/bin/$EXECUTABLE"
if [ ! -f "$EXECUTABLE_PATH" ]; then
    echo "Error: Executable not found: $EXECUTABLE_PATH"
    echo "Please build Photo-SLAM first:"
    echo "  cd $PHOTOSLAM_DIR && ./build.sh"
    exit 1
fi

# Check if config files exist
ORB_CONFIG_PATH="$PHOTOSLAM_DIR/$ORB_CONFIG"
GAUSSIAN_CONFIG_PATH="$PHOTOSLAM_DIR/$GAUSSIAN_CONFIG"

if [ ! -f "$ORB_CONFIG_PATH" ]; then
    echo "Error: ORB-SLAM3 config file not found: $ORB_CONFIG_PATH"
    exit 1
fi

if [ ! -f "$GAUSSIAN_CONFIG_PATH" ]; then
    echo "Error: Gaussian mapper config file not found: $GAUSSIAN_CONFIG_PATH"
    exit 1
fi

# Check if vocabulary file exists
VOCAB_PATH="$PHOTOSLAM_DIR/ORB-SLAM3/Vocabulary/ORBvoc.txt"
if [ ! -f "$VOCAB_PATH" ]; then
    echo "Error: ORB vocabulary file not found: $VOCAB_PATH"
    exit 1
fi

echo "Running Photo-SLAM Original..."
echo "Dataset Type: $DATASET_TYPE"
echo "Scene Name: $SCENE_NAME"
echo "Dataset Path: $DATASET_PATH"
echo "Results Path: $RESULTS_PATH"
echo "Executable: $EXECUTABLE"
echo "ORB Config: $ORB_CONFIG"
echo "Gaussian Config: $GAUSSIAN_CONFIG"
echo "Options: $OPTIONS"
echo ""

# Change to PhotoSLAM directory and run
cd "$PHOTOSLAM_DIR"

# Build command
CMD="$EXECUTABLE_PATH $VOCAB_PATH $ORB_CONFIG_PATH $GAUSSIAN_CONFIG_PATH $DATASET_PATH $RESULTS_PATH $OPTIONS"

echo "Executing: $CMD"
echo ""

# Execute the command
eval $CMD 