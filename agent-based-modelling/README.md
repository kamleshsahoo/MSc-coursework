# EVOLUTIONARY CITY MODEL
### An Agent Based Model.
- We develop a spatial agent-based model of a system of cities that studies the emergence of Zipf’s Law. The model extends the one proposed by Mansury and Gulyas (2007), taking into account the entropy of cities, i.e. the diversity of population that inhabits them. The results show in which cases the distribution of cities follows a power law and in which it doesn’t. Critically, our model indicates that the power law breaks down when either the disagglomerating forces are too strong, or when the population is not diverse and large enough. Besides this main model, we provide a further extension of it that allows specific agents to live and work in two different cities (work-from-home scenario).

### Guide
##### EvolutionaryCity.ipynb
In the EvolutionaryCity.ipynb we show some basic statistics of the model for mostly one set of parameters and a certain amount of steps. You can find are:
    
    1. The vision distribution for different agent types.
    2. The distribution of agents across different city sizes, per type of agent.
    3. A visual of the grid for each step.
    4. The models overal utility at each step.
    5. A plot of the city rank versus city population. (Show emergence of Zipf's law)
    6. Entropy distribution of cities at the end of each run.
 
##### SensitivityAnalysis.ipynb
Here you can find the OFAT and SOBOL analysis. These analysis were done for the following parameters:

    1. Negative Coefficient
    2. Number of Groups
    3. Number of Agents
    4. Radius Coefficient

### Model classes and functions

* All agents are instances of class **Habitant** and the city model is an instance of class **City_Model**. 

* **shannon_E** is a global function that returns the entropy of a cell. 


* There are 5 model level data collectors-
  - **city_sizes** -  returns an array corresponding to model grid containing the number of agents in each cell.   
  - **city_ranks** - returns a list of tuples. Each tuple contains the cell coordinates and its rank.
  - **model_entropy** - returns a list of lists. Each sublist contains the cell coordinates and its entropy.
  - **model_utility** - returns utility of the entire model which is simply sum of individual agent utilities.
  - **skill_levels** - returns a sorted dictionary with agent types as values and city sizes as keys. Cities of same sizes are merged. 


* At each model step, the agents calculate the payoff before moving into one of their neighboring cells. If the utiltiy is higher than the agent's current cell, it makes a move otherwise stays put in his current cell.   

