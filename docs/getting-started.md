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

### Recommended folder structure

Before running VTC, it helps to organize your files in a clear structure. Here is a recommended layout:

```
my_project/
├── audio/               # Your WAV files go here
│   ├── child01_day1.wav
│   ├── child01_day2.wav
│   └── child02_day1.wav
└── output/              # VTC will write results here
    ├── rttm/
    │   ├── child01_day1.rttm
    │   └── ...
    └── rttm.csv
```

Place all of your `.wav` files inside a single folder (e.g., `audio/`). When you run VTC, you will point it to this folder, and VTC will process every `.wav` file it finds inside. The results will be written to a separate output folder that VTC creates for you.

!!! tip "Subfolders"
    If your audio files are organized in subfolders (e.g., one subfolder per child), you can use the `--recursive_search` flag to tell VTC to look inside subfolders. See the [Command Line Interface Arguments](guide.md#command-line-interface-arguments) for details.

### Audio format requirements

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

## Common errors

If you run into problems during installation or when running VTC, check the table below for quick fixes. A more detailed list is available on the [Troubleshooting](misc/troubleshooting.md) page.

| Problem | Likely cause | Fix |
|---------|-------------|-----|
| `uv: command not found` | uv is not installed | For detailed installation instructions, see the [uv installation guide](https://docs.astral.sh/uv/getting-started/installation/) |
| `ffmpeg: command not found` | ffmpeg is not installed | `sudo apt install ffmpeg` (Linux) or `brew install ffmpeg` (macOS) |
| Model weights missing | Cloned without `--recurse-submodules` | Run `git lfs install && git submodule update --init --recursive` |
| `CUDA out of memory` | Batch size is too large for your GPU | Add `--batch_size 64` (or lower) to your command, or use `--device cpu` |
| No `.wav` files found | Wrong folder or wrong audio format | Make sure the `--wavs` path points to a folder containing `.wav` files |
