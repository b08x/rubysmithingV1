---
id: "card-implement-comprehensive-tagging-linguistic-analy-1geo90c"
boardId: "default"
title: "Implement Comprehensive Tagging & Linguistic Analysis"
parentId: null
scope: {"kind":"project","ref":"global"}
trackId: null
column: "backlog"
rank: "j"
labels: []
assignee: null
fieldValues: {}
createdAt: "2026-05-12T22:00:18.231Z"
updatedAt: "2026-05-12T22:00:18.231Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
**Priority**: HIGH - Stage 3 of 7-stage NLP pipeline

**Research Findings** (QMD search results):
- **ruby-spacy POS tagging**: "Utilize the `ruby-spacy` gem for POS tagging, providing accurate and efficient tagging for various languages"
- **Multi-layer linguistic analysis**: Part-of-speech tagging, dependency parsing, named entity recognition
- **Verb phrase extraction**: For personality and semantic pattern capture
- **SFL metafunction mapping**: Integration with Ideational, Interpersonal, Textual analysis

**Tagging Components** (from research):
1. **Part-of-Speech (POS) tagging**: Grammatical categories for each token
2. **Named Entity Recognition (NER)**: Identify people, places, organizations, etc.
3. **Dependency parsing**: Syntactic relationships between words
4. **Lemmatization**: Morphological analysis for root forms
5. **Semantic role labeling**: Verb-argument structure analysis

**ruby-spacy Capabilities**:
- Accurate multi-language POS tagging
- Built-in NER models
- Dependency parsing with syntactic trees
- Integration with existing Ruby NLP ecosystem
- Morphological analysis with linguistic features

**SFL Integration**:
- Map linguistic tags to SFL metafunctions
- Process Type identification (Material, Mental, Relational, etc.)
- Modality analysis for Interpersonal metafunction
- Theme/Rheme structure for Textual metafunction

**Files to create**:
- `lib/rubysmithing/tagging/pos_tagger.rb`
- `lib/rubysmithing/tagging/ner_extractor.rb`
- `lib/rubysmithing/tagging/dependency_parser.rb`
- `lib/rubysmithing/tagging/sfl_mapper.rb`