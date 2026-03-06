---
icon: lucide/server-cog
---

# HPC / SLURM setup

Example job script for running VTC on a cluster:

```bash
#!/bin/bash
#SBATCH --job-name=vtc2
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=04:00:00
#SBATCH --output=vtc_%j.out

cd /path/to/VTC

uv run scripts/infer.py \
    --wavs /path/to/audio_files \
    --output /path/to/output \
    --device cuda
```

Adjust partition names, modules, and resource requests for your cluster. Use the [speed benchmarks](guide.md#speed) to estimate wall time. For very large corpora, split audio into batches and use SLURM array jobs.


## Related tools

| Tool | Role |
|------|------|
| [segma](https://github.com/arxaqapi/segma) | Audio segmentation library powering VTC 2.0's training and inference |
| [BabyHuBERT](https://github.com/LAAC-LSCP/BabyHuBERT) | Self-supervised speech model that VTC 2.0 is built on |
| [ALICE](https://github.com/orasanen/ALICE) | Adult word count estimator — uses VTC output as input |
| [ChildProject](https://childproject.readthedocs.io/) | Dataset management framework for child-centered recordings |
| [pyannote.audio](https://github.com/pyannote/pyannote-audio) | Speaker diarization toolkit; VTC uses its segment merging logic |
| [vtc-finetune](https://github.com/arxaqapi/vtc-finetune) | Fine-tuning tools for VTC |
