# Bayesian and Frequentist approach using BlackBox_Python
[![Build Status](https://travis-ci.org/UBC-MDS/BlackBox_Python.svg?branch=master)](https://travis-ci.org/UBC-MDS/BlackBox_Python)

## Installation

`pip install git+https://github.com/UBC-MDS/BlackBox_Python.git`

### Contributors

1. Siddharth Arora(@sarora)
2. Yinghua Guan(@vinverguan)
3. Abishek Murali(@abimur-123)

### Summary

The Bayesian vs Frequentist approach is more of a philosophical debate which this package will not delve into. This package attempts at breaking down the understanding and the underlying assumptions of the 2 approaches and how they compare. The package will run a significance analysis using both approaches based on data provided by the user, compare credible and confidence intervals and finally debunks the understanding of MAP and MLE for parameter estimation.

This package is aimed at users who are attempting to familiarize themselves with the Bayesian/Frequentist approach(although I'm guessing it will be more Bayesian). This package can elucidate the difference in approaches and will attempt to help the user get a basic high-level understanding of both approaches and how they should proceed to carry out further analysis.

## Functions

### Confidence in parameter estimation

##### Function
`getCredibleInterval(x,prior_dis,sample_dis) :`

Obtain credible intervals using Bayesian approach(we now just accept normal distribution data, may accept more distribution in future)  

##### Parameters:  
x         :numpy array with at least 1 observation  
prior_dis : list, with exactly two number  
sample_dis: list, with exactly two number

##### Returns:   
interval: list with 2 elements

**Example Usage**   

```
import numpy as np
sample=np.random.normal(loc=3,scale=1,size=5)
getCredibleInterval(sample,list([2,1]),list([3,1]))
```

##### Function

`getConfidenceInterval() : Obtain confidence interval for the result`  

Obtain confidence interval for the result(we now just accpet normal distribution data, may accept more distribution in future)

##### Parameters:  
x :numpy array, with at least 1 observation


##### Returns:   
interval: list with 2 elements

**Example usage**   

```
import numpy as np
sample=np.random.normal(loc=3,scale=1,size=5)
getConfidenceInterval(sample)
```

### AB Testing

A/B testing is an experiment with 2 versions - A and B. It is a two sample hypothesis testing which compares the subject's response to 2 versions of an entity(like a website).

##### Function
`performABtest_Freq(data,alpha)`

This function uses the frequentist approach to compute results of the A/B tests.

##### Parameters
- *data*: input dataframe with 2 columns: name and event. Name consists of the A and B values one is trying to test and event consists of the outcome of the event(0 or 1).
- *alpha*: This defines the false positive rate while testing. Default value is **0.05**

##### Returns:   
1. p-value of significance between the 2 events
2. Graph plotting p-values over iterations. This graph tries to demonstrate why early stopping or repeated testing can be a problem without correction.
3. Method used to compute significance

**Example usage**

```
from BlackBox_Python import ABtests as AB
import numpy as np
import pandas as pd

n = 2500
p = 0.5
x = 1
name = np.repeat(('A','B'),n/2)
value= np.random.binomial(x, p,size = n)
d = {'input':name,'event':value}
inp = pd.DataFrame(data=d)
AB.performABtest_Freq(inp,0.1)
```

#### Bayesian approach
This approach is WIP

### Parameter estimation

#### Maximum Likelihood Estimate

Get maximum likelihood value of the parameter for a given distribution.

##### Function

`getMLE(distribution,data): Get maximum likelihood value of the parameter for a given distribution.`

#### Parameters
- distribution: type of distribution of the data: Supporting **bernoulli** and **poisson** as of now
- data: the column is a list of numeric data over which likelihood is performed

#### Returns
log likelihood of the data. For example, mean for Poisson, probability for Bernoulli.

**Example usage**   

```
bernoulli_column = [0,1,1,0,1,0,1,1,1,1,1]
getMLE("bernoulli",bernoulli_column)

poisson_column = [0,1,2,3,1,2,3,9,6,10,11]
getMLE("poisson",poisson_column)
```

#### Maximum a Posteriori(MAP)
This approach is WIP

### Similar Packages

We are still on the hunt for similar packages.
