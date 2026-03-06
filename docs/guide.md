---
icon: lucide/file-sliders
---

# User Guide

## Understanding outputs

After running VTC, you get:

```
<output_folder>/
├── rttm/          # Final segments (with merging applied)
├── raw_rttm/      # Raw model output (before merging)
├── rttm.csv       # Final segments as CSV
└── raw_rttm.csv   # Raw segments as CSV
```

**Use `rttm.csv` for analysis.** Open it in any spreadsheet application — each row is one speech segment with a filename, start time (`onset`), end time (`offset`), and speaker label.

The `raw_rttm/` outputs skip the post-processing step that merges short adjacent segments and removes noise. They're provided for debugging or custom pipelines.

### RTTM format

If you need the RTTM files (standard speech processing format), each line reads:

```
SPEAKER <file_id> 1 <onset> <duration> <NA> <NA> <label> <NA> <NA>
```

Note: RTTM uses `onset + duration`, while the CSV uses `onset + offset`.

## Accuracy

VTC 2.0 performance on the held-out test set:

| Model | KCHI | OCH | MAL | FEM | Average F1 |
|-------|------|-----|-----|-----|------------|
| VTC 1.0 | 68.2% | 30.5% | 41.2% | 63.7% | 50.9% |
| VTC 1.5 | 68.4% | 20.6% | 56.7% | 68.9% | 53.6% |
| **VTC 2.0** | **71.8%** | **51.4%** | **60.3%** | **74.8%** | **64.6%** |
| Human 2 | 79.7% | 60.4% | 67.6% | 71.5% | 69.8% |

**KCHI** and **FEM** are the most reliable classes. **OCH** is the weakest — use other-child counts with caution. **Overlapping speech** is a major source of error: when multiple people talk at once, VTC may attribute the speech to only one speaker.

!!! warning "VTC outputs are estimates"
    Classification errors propagate into downstream analyses. Always account for error margins when interpreting results.

## Speed

| Setup | Speedup | 1h audio | 16h audio |
|-------|---------|----------|-----------|
| H100 GPU, batch 256 | 1/905 | ~4 sec | ~1 min |
| A40 GPU, batch 256 | 1/650 | ~6 sec | ~1.5 min |
| CPU (Xeon Silver), batch 64 | 1/16 | ~4 min | ~1 hour |

GPU processing is strongly recommended for large corpora. If you get out-of-memory errors, reduce the batch size.

## Practical examples

### Counting child vocalizations

After running VTC, count KCHI segments from the command line:

```bash
grep "KCHI" my_predictions/rttm.csv | wc -l
```

Or open `rttm.csv` in a spreadsheet and filter by the label column.

### Measuring caregiver input by gender

Sum the durations of FEM vs. MAL segments in your CSV output. The `offset - onset` difference gives you each segment's duration in seconds.

### Feeding into ALICE or ChildProject

VTC's RTTM output can be directly used by [ALICE](https://github.com/orasanen/ALICE) (which requires VTC as a prerequisite) and imported into [ChildProject](https://childproject.readthedocs.io/) datasets as annotation sets. Use the merged `rttm/` files.
