---
# icon: lucide/server-cog # gpu
icon: octicons/ai-model-24
---

# Fine-tuning VTC 2.0


Fine-tuning VTC on your own annotated data can improve results for specific recording environments or populations. This requires annotated audio (human-labeled RTTM files), a GPU with 16+ GB memory, and familiarity with deep learning training pipelines.

The fine-tuning code is at [arxaqapi/vtc-finetune](https://github.com/arxaqapi/vtc-finetune). The general workflow is:

1. Prepare annotated data (audio + RTTM) split into train/validation/test
2. Configure training starting from the pre-trained VTC 2.0 checkpoint
3. Train and evaluate against the base model to confirm improvement


Child-centered daylong recordings are essential for studying early language development, but existing speech models trained on clean adult data perform poorly due to acoustic and linguistic differences. We introduce BabyHuBERT, a self-supervised speech model trained on 13,000 hours of multilingual child-centered recordings spanning 40+ languages. Evaluated on voice type classification — distinguishing target children from female adults, male adults, and other children, a key preprocessing step for analyzing naturalistic language experiences — BabyHuBERT-VTC achieves F1-scores from 52.1% to 74.4% across six corpora, consistently outperforming W2V2-LL4300 (English daylongs) and HuBERT (clean adult speech). Notable gains include 13.2 and 15.9 absolute F1 points over HuBERT on Vanuatu and Solomon Islands, demonstrating effectiveness on underrepresented languages. We share code and model to support researchers working with child-centered recordings across diverse linguistic contexts.