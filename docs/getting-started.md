---
icon: lucide/package-open
# icon: lucide/play
---

# Getting Started

## Requirements

- **OS**: Linux or macOS (Windows is not supported)
- **Python**: 3.13+
- **System tools**: [uv](https://docs.astral.sh/uv/), [ffmpeg](https://ffmpeg.org/), [git-lfs](https://git-lfs.com/)

## Installation

Install system dependencies, then clone and set up VTC:

```bash
# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install ffmpeg and git-lfs (Ubuntu/Debian)
sudo apt install ffmpeg git-lfs

# Clone the repo (--recurse-submodules is required for model weights)
git lfs install
git clone --recurse-submodules https://github.com/LAAC-LSCP/VTC.git
cd VTC

# Install Python dependencies
uv sync

# Verify everything is set up
./check_sys_dependencies.sh
```

On **macOS**, use `brew install ffmpeg git-lfs` instead of `apt`.

!!! warning "Don't skip `--recurse-submodules`"
    Without this flag, model weights won't be downloaded and VTC will fail.

## Prepare your audio

VTC expects **WAV** files sampled at **16 kHz** and with a single channel (mono). You can check your files with:

```bash
ffprobe your_recording.wav
```

If your audio needs conversion, use the included script or ffmpeg directly. Both will resample to 16 kHz and average across channels to produce a single mono file.

```bash
# Using the provided script
uv run scripts/convert.py --input /path/to/raw_audio --output /path/to/converted

# Or manually with ffmpeg (works with MP3, FLAC, M4A, etc.)
ffmpeg -i input.mp3 -acodec pcm_s16le -ar 16000 -ac 1 output.wav
```

## Run VTC

Place your `.wav` files in a folder and run:

```bash
uv run scripts/infer.py \
    --wavs my_audios \
    --output my_predictions \
    --device cpu
```

| Device flag | When to use |
|-------------|-------------|
| `cpu` | No GPU available |
| `cuda` or `gpu` | NVIDIA GPU with CUDA |
| `mps` | Apple Silicon (M1/M2/M3/M4) |

A helper script is also provided — edit the variables in `scripts/run.sh` and run `sh scripts/run.sh`.
