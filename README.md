README
================

This is the code used for data processing and statistical analyses in
Flaherty, R., et al. (2024). *Diffusion MRI Findings in Hippocampal Subregions of People with Subjective Cognitive Decline*. Presented at the International Society for Magnetic Resonance in Medicine Annual Meeting, 2024, Singapore.

## Directions

Running this code requires the following dependencies:

- RStudio \>= 2023.09.1+494 with the following packages:
  - base
  - tidyverse
  - data.table
  - arsenal
  - ggpubr
  - effectsize
- python == 3.7 with the following packages:
  - pandas
  - pybids
  - packaging
  - PyDesigner == 1.0.0
  - mrtrix3 == 3.0.4
- FreeSurfer == 7.4.1
- FSL == 6.0.6
  
Scripts with names ending in _sbatch are written for submission to a SLURM
batch processing system on an HPC. It is highly recommended to conduct
this analysis on an HPC. Scripts with .sh extensions are written for
Mate Desktop and can be run with either bash or zsh.

Run each numbered script in order. Unnumbered scripts are called by the
numbered scripts and do not need to be called manually. Wait until the
script finishes before starting the next numbered script.

The original analysis was conducted on Red Hat Enterprise Linux Server
release 7.4.

The data is availabe from the NYU Alzheimer's Disease Research Center at https://med.nyu.edu/centers-programs/alzheimers-disease-research/research/resources-researchers/request-resources

## License
Shield: [![CC BY-SA
4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by-sa/4.0/)
This work is licensed under a [Creative Commons Attribution-ShareAlike
4.0 International
License](http://creativecommons.org/licenses/by-sa/4.0/).
[![CC BY-SA
4.0](https://licensebuttons.net/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)
