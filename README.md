# Effects of False Positive and False Negative Connections on Network-Level Metrics
This projectis aiming to measure the of False Positive (FP) and False Negative (FN) connections in a connectome on the network properties. To to that, the fundamental measurements were taken into account:  
- Clusterring Coefficient (C)
- Global efficiency (GE) 
- Modularity
- Number of modules
  
Some functions also allow measurement of Characteristic Path Length (L) and Rich Club, and weighted and binary density.

## The data
The data was taken from the updated C. elegans weighted connectome (Vashney et al, 2011) that was an extension of the existing full-scale nervous system of C. elegans obtained through serial partitioning and electron microscopy (White et al, 1986). The network consists of 279 nodes, each corresponding to a neuron in the nervous system and each connection denotes the presence of a synaptic contact, the weight represents the amount of such contacts. The initial matrix is directed and has a density of 2.83%.  

## Processing and software  
This data was used as a reference graph for subsequently introducing FP and FN connections one by one in order to generate perturbed networks. While FN simulation simply chose one of the existing edges with any weight and removed it, FP simulation drew the weight of each new edge from the empirical distribution of existing edge weights. Once a connection was established or removed, the new edited matrix was becoming the reference for a future analogical modification with constant reassigning. This was repeated 300 times to simulate gradual increase in the network perturbation and study the effects of FN and FP connections in dynamics. On each step, the clustering coefficient (C), global efficiency (GE), modularity and the amount of modules were documented to measure the network behavior. C, GE, and modularity are standard network-level metrics that are well suited for dynamic analysis; the number of modules was added in order to get more insight on the change in modular topology of the network. The processing was performed in Matlab (2025b) with the usage of BCT toolbox.

## Extrapolation of the method  
In order to account for different network types, the initial matrix was then binarized to simulate binary undirected connectome, and the whole process was repeated. In the binary case the weights for FP were equal 1. Later the initial weighted matrix was symmetrified and binarized again to also simulate symmetrical weighted and unweighted data and was fed into the same pipeline. 

The full research report with the results is stored in "Effects of False Positive and False Negative Connections on Network, Mariia Dolmatova.pdf"  

## Function overview:


## Function dependencies:  
```

```

## Requirements

```
- MATLAB (R2017a or later)
- Statistics and Machine Learning Toolbox (optional, if using statistical tests)
- Brain Connectivity Toolbox (BCT) — for network metric functions
- Network Based Statistic Toolbox (optional)
```
_This is a school project for Networks Neuroscience course at VU Amsterdam._
