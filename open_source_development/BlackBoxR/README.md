# Bayesian and Frequentist approach using BlackBoxR
[![Build Status](https://travis-ci.org/UBC-MDS/BlackBoxR.svg?branch=master)](https://travis-ci.org/UBC-MDS/BlackBoxR)

### Contributors

1. Siddharth Arora(@sarora)
2. Yinghua Guan(@vinverguan)
3. Abishek Murali(@abimur-123)

### Summary

The Bayesian vs Frequentist approach is more of a philosophical debate which this package will not delve into. This package attempts at breaking down the understanding and the underlying assumptions of the 2 approaches and how they compare. The package will run a significance analysis using both approaches based on data provided by the user, compare credible and confidence intervals and finally debunks the understanding of MAP and MLE for parameter estimation.

This package is aimed at users who are attempting to familiarize themselves with the Bayesian/Frequentist approach(although I'm guessing it will be more Bayesian). This package can elucidate the difference in approaches and will attempt to help the user get a basic high-level understanding of both approaches and how they should proceed to carry out further analysis.


#### Confidence and Credible Intervals

##### Function
`getCredibleInterval(x,prior\_dis,sample\_dis)`

**Purpose:** obtain credible intervals using Bayesian approach(we now just accept **normal distribution** data, may accept more distribution in future )  

#### Parameters

* x, a numeric vector  
* prior\_dis, a numeric vector  
* sample\_dis, a numeric vector

#### Returns   
numeric vector with length 2

**Example**   

```
sample<-rnorm(5,mean=3,sd=1)
getCredibleInterval(sample,c(2,1),c(3,1))
```

##### Function

`getConfidenceInterval(x)`

**Purpose:** Obtain confidence interval for the result(we now just accept **normal distribution** data, may accept more distribution in future)

#### Parameters
* x
* a numeric vector  

#### Returns    
numeric vector with length 2

**Example**   

```
sample<-rnorm(5,mean=2, sd =0.98)
getConfidenceInterval(sample)
```

### Frequentist approach

#### AB Testing

**Purpose:**

A/B testing is an experiment with 2 versions - A and B. It is a two sample hypothesis testing which compares the subject's response to 2 versions of an entity(like a website).

##### Function
`performABTest(data,alpha = 0.05)`

##### Parameters
- data: input dataframe with 2 columns: name and event. Name consists of the A and B values one is trying to test and event consists of the outcome of the event(0 or 1).
- alpha: This defines the false positive rate while testing. Default value is **0.05**

**Example**   

```
df<-data.frame(name=rep(c('A','B'),100),events=rbinom(200,1,0.5))
op <- performABTest(df,0.05)
```

#### Maximum Likelihood Estimate

**Purpose:**

Maximum likelihood estimation (MLE) is a method of estimating the parameters of a statistical model, given observations. It attempts to find the parameter values that maximize the likelihood function, given the observations.

##### Function

`getMLE(distribution,column): Get maximum likelihood value of the parameter for a given distribution.`

#### Parameters
- distribution: type of distribution of the data: Supporting **bernoulli** and **poisson** as of now
- column: the column is a vector of numeric data over which likelihood is performed

#### Returns
log likelihood of the data. For example, mean for Poisson, probability for Bernoulli.

**Example**   

```
bernoulli_column <- c(0,1,1,0,1,0,1,1,1,1,1)
getMLE("bernoulli",bernoulli_column)

poisson_column <- c(0,1,2,3,1,2,3,9,6,10,11)
getMLE("poisson",poisson_column)
```

We make sure all our tests provide 100% coverage. 

### Similar Packages

The [BayesAB package](https://cran.r-project.org/web/packages/bayesAB/index.html) does AB testing using Bayesian approach with different distributions.
