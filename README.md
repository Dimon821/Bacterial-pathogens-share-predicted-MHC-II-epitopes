<div align="center">
  <img src="https://www.ru.nl/sites/default/files/styles/content_full/public/2023-10/RU_drupal_logo_RU_0.png.webp" alt="Radboud University Logo" style="height: 80px; width: auto; margin-bottom: 20px;" />
  
  <h1 style="margin-top: 0;">Bacterial-pathogens-share-predicted-MHC-II-epitopes</h1>
  <p><em>High-throughput computational pipeline for identifying conserved T-cell epitopes in respiratory pathogens.</em></p>
  <p>
    Course: <strong>Bioinformatics & Computational Biology</strong><br>
    Author: <strong>Simon Wagener</strong>
  </p>
  
  [![Python](https://img.shields.io/badge/Python-3.8%2B-blue.svg)](https://www.python.org/)
  [![NetMHCIIpan](https://img.shields.io/badge/NetMHCIIpan-4.0-green.svg)](https://services.healthtech.dtu.dk/services/NetMHCIIpan-4.0/)
  [![Jupyter Notebook](https://img.shields.io/badge/Jupyter-Notebook-orange.svg)](https://jupyter.org/)
</div>

---

## Introduction
The rapid emergence of antibiotic-resistant respiratory pathogens necessitates the development of novel vaccine strategies. This project aims to identify cross-reactive, immunogenic T-cell epitopes shared across four major bacterial pathogens: *Bordetella pertussis*, *Haemophilus influenzae*, *Streptococcus pneumoniae*, and *Streptococcus pyogenes*.

By integrating comparative proteomics with MHC-II binding affinity predictions, this pipeline systematically maps conserved peptide sequences across species, filtering for candidates that demonstrate both high conservation and predicted immunogenicity.

## Computational Workflow
The analysis is structured into a four-stage computational pipeline:



1. **Proteome Acquisition:** Extraction of target bacterial proteomes from UniProt.
2. **N-mer Extraction:** Systematic generation of overlapping peptide n-mers using sliding window algorithms.
3. **Overlap Mapping:** Cross-species frequency analysis to identify conserved peptide sequences.
4. **Immunogenicity Prediction:** Assessment of peptide binding affinity to MHC-II allelic variants using NetMHCIIpan-4.0.

## Methodology
The pipeline utilizes a modular Python architecture to process large-scale proteomic data. Key steps include:
* **Redundancy Filtering:** Normalizing peptide datasets by constructing unique identifier dictionaries to exclude intra-protein homologous matches.
* **Contextless Binding Assessment:** Evaluating the intrinsic binding propensity of peptides to a broad panel of MHC-II alleles.
* **Statistical Correlation:** Quantifying the relationship between species-specific conservation (as measured by n-mer overlap) and predicted eluted ligand (EL) scores.
* **Empirical Validation:** Cross-referencing identified candidates against known experimental T-cell epitopes.

## Getting Started

### Prerequisites
Ensure your environment is configured for Python 3.8+ and that the NetMHCIIpan-4.0 software is installed locally.
