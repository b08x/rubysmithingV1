---
id: "card-implement-token-cleaning-preprocessing-with-ruby-025s9a2"
boardId: "default"
title: "Implement Token Cleaning & Preprocessing with ruby-spacy"
parentId: null
scope: {"kind":"project","ref":"global"}
trackId: null
column: "backlog"
rank: "j"
labels: []
assignee: null
fieldValues: {}
createdAt: "2026-05-12T22:00:04.945Z"
updatedAt: "2026-05-12T22:00:04.945Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
**Priority**: HIGH - Stage 2 of 7-stage NLP pipeline

**Research Findings** (QMD search results):
- **ruby-spacy integration**: Provides morphological analysis, lemmatization, POS tagging capabilities
- **Token normalization**: Methods for removing punctuation, normalizing whitespace, stemming/lemmatization
- **NLP preprocessing pipeline**: Text cleaning, segmentation, tokenization, feature extraction with discrete stages
- **TF-IDF/BM25 integration**: Pragmatic text preprocessing for contextual retrieval

**Implementation Strategy**:
1. **Preprocessing layer**: Remove noise, normalize encoding, handle special characters
2. **Tokenization**: Split text into linguistic units while preserving semantic boundaries
3. **Normalization**: Case folding, punctuation handling, whitespace cleanup
4. **Linguistic preprocessing**: Use ruby-spacy for lemmatization and morphological analysis
5. **Context preservation**: Maintain token-to-original-text mapping for debugging

**ruby-spacy Integration Points**:
- Lemmatization: `doc.map(&:lemma_)` for root form extraction
- Morphological analysis: Access to linguistic features for each token
- Integration with existing NLP pipeline via ruby-spacy gem

**Files to create**:
- `lib/rubysmithing/preprocessing/token_cleaner.rb`
- `lib/rubysmithing/preprocessing/linguistic_normalizer.rb` 
- DSPy tool wrapper for ruby-spacy integration
- Tests with various text encodings and edge cases