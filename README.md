# REPPU-ESN2
The machine-learning based surrogate model for the ionospheric outputs from REPPU global MHD simulation is developed using the echo state network (ESN, e.g., [Tanaka et al., Phys. Rev. Res. 2022](https://journals.aps.org/prresearch/abstract/10.1103/PhysRevResearch.4.L032014)). The python codes and the training dataset for the ESN-based emulator model ver2.0 (Kataoka et al., 2023, submitted to GMD) are provided here.

  ## Files
  * img?.npy: REPPU simulation results of (f: field-aligned current, p: potential, w: height-integrated conductivity), PCA images.
  * mean?.npy: REPPU simulation results of (f: field-aligned current, p: potential, w: height-integrated conductivity), PCA mean values. 
  * pca?.npy: REPPU simulation results of (f: field-aligned current, p: potential, w: height-integrated conductivity), PCA variables. 
  * swall3_5min.txt: Solar wind input data. 
  * rep_emu_?2.ipyb: Jupyter notebook demo (f: field-aligned current, p: potential, w: height-integrated conductivity), for reproducing clock-angle figures in the reference paper.
  * rep_emu_omni_ae.ipyb: Jupyter notebook demo, for reproducing OMNI-input and AE output figures.

  ## How to Use
  * Run the sample code rep_emu_?2.ipyb and rep_emu_omni_ae.ipyb in the jupyter notebook.
  * Some python modules, such as numpy, scipy, matplotlib, networkx, pyspedas, as well as [esn_dts_openloop.py](https://github.com/GTANAKA-LAB/DTS-ES), are required to run the codes. 

  ## Developer
  Ryuho Kataoka, National Institute of Polar Research, Japan
  
  ## Citation
  Kataoka, R., A. Nakanmizo, S. Nakano, and S. Fujita (2023), Machine learning emulator for the simulation results of auroral current system, submitted to Geoscientific Model Development (submitted in May, 2003)
