# solar-models-python-matlab
Comparative implementation of ASHRAE 2001, Hottel (1976), and ASHRAE 2009 solar radiation models in Python and MATLAB, with experimental validation (ICAIIT 2025).
# Modeling of Solar Radiation — ASHRAE / Hottel Comparison (ICAIIT 2025)

Authors: Rozikov J.Y., Sobirov M.M., Ruziboyev V.U., Akhmedova S.Y.  
Repository for the ICAIIT 2025 paper "Modeling of Solar Radiation Using Python Programming and Comparison with Experimental Data"

## Short description
This repository contains Python and MATLAB implementations of three solar radiation models: ASHRAE 2001, Hottel (1976), and ASHRAE 2009. The code was used to reproduce results presented in the ICAIIT 2025 paper and includes scripts for model runs, postprocessing, plotting, and cross-checks between Python and MATLAB.

## Contents
- `/python/` — main Python implementation, modular model files, and example notebooks
- `/matlab/` — MATLAB scripts used for cross-check validation
- `/data/` — sample input and experimental data (if permitted for sharing)
- `/results/` — generated figures and summary tables
- `requirements.txt` — Python dependencies and versions
- `README.md` — this file
- `LICENSE` — license file (MIT recommended)
- `CITATION.cff` — citation metadata

## Requirements
- Python 3.9
- numpy >= 1.21
- pandas >= 1.3
- pvlib >= 0.9.3
- matplotlib >= 3.4

Install via:
```bash
python -m pip install -r requirements.txt
