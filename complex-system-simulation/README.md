# Major depression as a symptom network  
Our model is a network - representation of major depression. The final model is a Netlogo implementation showing the dynamics of depression over time while the analysis is performed in Python.

## Data
- All the data is included in the zip file.  
- The empirical data we used to create our final model is based on the 14 symptoms disaggregated network model of Major Depression in the paper https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0167490 . The dataset is publicly available at https://figshare.com/projects/Major_depression_as_a_complex_dynamic_system_accepted_for_publication_in_PLoS_ONE_/17360  
## Required Python dependencies
Besides the standard python data analysis (*numpy, pandas, scipy*) and plotting libraries (*matplotlib*), please install the following: 
- *Rise* extension for Jupyter sildeshow  
https://rise.readthedocs.io/en/stable/installation.html  
- *NetworkX* extension for analysing network structures.  
https://networkx.org/documentation/stable/install.html  
- *SALib* package for sensitivity analysis.  
https://salib.readthedocs.io/en/latest/getting-started.html#installing-salib  
- *seaborn* package.  
https://seaborn.pydata.org/installing.html
- *tqdm* package.  
https://anaconda.org/conda-forge/tqdm
- Though animation is included in *matplotlib*, one may require to install the *ffmpeg* extension.  
https://pypi.org/project/ffmpeg-python/  

## Netlogo Model  
- Install Netlogo from https://ccl.northwestern.edu/netlogo/ 

- Our final model can also be run from a web browser at http://www.netlogoweb.org/launch?#https://kamleshsahoo.github.io./Depression.nlogo. However, for efficieny reasons we recommend installing Netlogo.

- The sensitivity analysis is based on the Netlogo model. To avoid the long execution times we have included the sensitivity analysis results as 'ouput.txt' file which is based on 7200 parameter combinations each running for 5000 time points. To do the analysis again, run the 'sobol_analysis.nlogo' file. Additional comments are included in the file and Appendix of the presentation slides. 

## Gephi
- Install Gephi from https://gephi.org/  

## Note  
- 'Extract-Here' (on *Windows machine*) the 'data-files.zip' so that the data files are extracted in the same folder where the jupyter notebook files are running. This will avoid any conflicts when running the presentation slides and sensitivity analysis.
- The python code is in the presentation slides.  
