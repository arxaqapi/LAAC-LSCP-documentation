---
icon: lucide/home
---

# Voice Type Classifier (VTC)

The Voice Type Classifier is a deep learning model that identifies **who is speaking when** in child-centered long-form audio recordings. It detects speech segments and classifies them into one of four speaker categories:

| Label | Meaning |
|-------|---------|
| **KCHI** | Key child (wearing the recorder) |
| **OCH** | Other children (siblings, ...) |
| **MAL** | Adult male speech |
| **FEM** | Adult female speech |

VTC is designed for naturalistic recordings that are captured by a portable recorder worn by a child (typically 0 to 5 years old), often spanning several hours.

## What VTC is *not*

- **Not a speech recognizer** — it identifies *who* speaks *when*, not *what* they say.
- **Not a speaker diarizer** — it classifies speaker *types*, not individual identities (it cannot distinguish two adult females from each other).

---

## Model Accuracy
Here are the performance of VTC 2.0 as measured on the held-out set:


| Model | KCHI ↑ | OCH ↑ | MAL ↑ | FEM ↑ | Average F1 ↑ |
|-------|------|-----|-----|-----|------------|
| VTC 1.0 | 68.2% | 30.5% | 41.2% | 63.7% | 50.9% |
| VTC 1.5 | 68.4% | 20.6% | 56.7% | 68.9% | 53.6% |
| **VTC 2.0** | **71.8%** | **51.4%** | **60.3%** | **74.8%** | **64.6%** |
| Human 2 | 79.7% | 60.4% | 67.6% | 71.5% | 69.8% |

**KCHI** and **FEM** are the most reliable classes. **OCH** is the weakest — use other-child counts with caution.

!!! warning "VTC outputs are estimates"
    Classification errors propagate into downstream analyses. Always account for error margins when interpreting results.

---

## Related tools

| Tool | Role |
|------|------|
| [segma](https://github.com/arxaqapi/segma) | Audio segmentation library powering VTC 2.0's training and inference |
| [BabyHuBERT](https://github.com/LAAC-LSCP/BabyHuBERT) | Self-supervised speech model that VTC 2.0 is built on |
| [ALICE](https://github.com/orasanen/ALICE) | Adult word count estimator — uses VTC output as input |
| [ChildProject](https://childproject.readthedocs.io/) | Dataset management framework for child-centered recordings |
| [pyannote.audio](https://github.com/pyannote/pyannote-audio) | Speaker diarization toolkit; VTC uses its segment merging logic |
| [vtc-finetune](https://github.com/arxaqapi/vtc-finetune) | Fine-tuning tools for VTC |
