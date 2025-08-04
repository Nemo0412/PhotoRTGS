# Photo-SLAM Project

This repository contains two versions of Photo-SLAM:

- **PhotoSLAM**: Original Photo-SLAM implementation
- **PhotoSLAM_RTGS**: Photo-SLAM with RTGS enhancements

## Project Structure

```
PhotoRTGS/
├── PhotoSLAM/          # Original Photo-SLAM implementation
├── PhotoSLAM_RTGS/     # Photo-SLAM with RTGS enhancements
├── run_original.sh     # Script to run original Photo-SLAM
├── run_rtgs.sh         # Script to run Photo-SLAM with RTGS
└── README.md           # This file
```

## Quick Start

### For Original TUM/Scene (using PhotoSLAM)
```bash
./run_original.sh [dataset_type] [scene_name] [dataset_path] [results_path]
```

### For RTGS TUM/Scene (using PhotoSLAM_RTGS)
```bash
./run_rtgs.sh [dataset_type] [scene_name] [dataset_path] [results_path]
```

## Usage Examples

### Original Photo-SLAM Examples

```bash
# TUM RGB-D dataset
./run_original.sh rgbd tum_freiburg1_desk /path/to/tum/dataset /path/to/results

# Replica dataset
./run_original.sh rgbd office0 /path/to/replica/dataset /path/to/results
```

### RTGS Photo-SLAM Examples

```bash
# TUM RGB-D dataset with RTGS
./run_rtgs.sh rgbd tum_freiburg1_desk /path/to/tum/dataset /path/to/results

# Replica dataset with RTGS
./run_rtgs.sh rgbd office0 /path/to/replica/dataset /path/to/results
```

## Supported Dataset Types

- `mono`: Monocular camera datasets
- `rgbd`: RGB-D camera datasets  

## Supported Scenes

### TUM RGB-D Dataset
- `tum_freiburg1_desk`
- `tum_freiburg2_xyz`
- `tum_freiburg3_long_office_household`

### Replica Dataset
- `office0`, `office1`, `office2`
- `room0`, `room1`, `room2`

## Installation

### Prerequisites

```bash
sudo apt install libeigen3-dev libboost-all-dev libjsoncpp-dev libopengl-dev mesa-utils libglfw3-dev libglm-dev
```

### Dependencies

| Dependencies | Tested with |
|--------------|-------------|
| OS | Ubuntu 20.04 LTS, Ubuntu 22.04 LTS, Jetpack 5.1.2 |
| gcc | 9.4.0, 10.5.0, 11.4.0 |
| cmake | 3.22.1, 3.26.4, 3.27.5 |
| CUDA | 11.4, 11.8 |
| cuDNN | 8.6.0, 8.7.0, 8.9.3 |
| OpenCV | 4.7.0, 4.8.0 (with opencv_contrib and CUDA) |
| LibTorch | <2.1.2 |

### Build Both Versions

```bash
# Build original Photo-SLAM
cd PhotoSLAM/
chmod +x ./build.sh
./build.sh

# Build Photo-SLAM with RTGS
cd ../PhotoSLAM_RTGS/
chmod +x ./build.sh
./build.sh
```

## Dataset Download

```bash
# Download datasets
cd PhotoSLAM/scripts
chmod +x ./*.sh
./download_replica.sh
./download_tum.sh

cd ../../PhotoSLAM_RTGS/scripts
chmod +x ./*.sh
./download_replica.sh
./download_tum.sh
```

## Evaluation

For evaluation, you can use the Photo-SLAM evaluation toolkit:

```bash
git clone https://github.com/HuajianUP/Photo-SLAM-eval.git
```

See the individual README files in `PhotoSLAM/` and `PhotoSLAM_RTGS/` for detailed evaluation instructions.

## 🔗 Related Projects

### MonoGS RTGS Implementation
For a RTGS-SLAM implementation based on MonoGS, please check out:
- [MonoGS RTGS Implementation](https://github.com/Nemo0412/MonoRTGS.git)


## 🙏 Acknowledgements

This project builds upon the excellent work of the authors of **MonoGS** and **Photo-SLAM**.  
We gratefully acknowledge their open-source contributions, which make this project possible.

- [MonoGS (CVPR 2024)](https://github.com/muskie82/MonoGS.git)
- [Photo-SLAM (CVPR 2024)](https://github.com/HuajianUP/Photo-SLAM.git) 