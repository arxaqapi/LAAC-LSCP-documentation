---
icon: lucide/home
---

# Voice Type Classifier (VTC)

VTC is a deep learning model that identifies **who is speaking when** in child-centered long-form audio recordings. It detects speech segments and classifies them into four speaker types:

| Label | Meaning |
|-------|---------|
| **KCHI** | Key child (wearing the recorder) |
| **OCH** | Other children (siblings, ...) |
| **MAL** | Adult male speech |
| **FEM** | Adult female speech |

VTC is designed for naturalistic recordings captured by a portable recorder worn by a child (typically 0–5 years old), often spanning several hours.

## What can I do with it?

- Count child vocalizations across a day and track how they change with age
- Measure the proportion of female vs. male caregiver speech
- Feed speaker segments into downstream tools like [ALICE](https://github.com/orasanen/ALICE) or [ChildProject](https://childproject.readthedocs.io/)

## What VTC is *not*

- **Not a speech recognizer** — it identifies *who* speaks *when*, not *what* they say.
- **Not a speaker diarizer** — it classifies speaker *types*, not individual identities (it cannot distinguish two adult females from each other).
