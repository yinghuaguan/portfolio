import numpy as np
import scipy.stats as stats

def getConfidenceInterval(x):
    """
    Compute 95% confidence interval (frequentist approach)

    Args:
    x :numpy array, with at least 1 observation

    Return:
    interval: list with 2 elements
    """
    if (len(x.shape)>1):
        raise AttributeError('Input data must be numpy array with one column only')

    if(isinstance(x,np.ndarray) == False):
        raise TypeError("Not a numpy array")

    assert x.shape[0]!=0, "Empty Array!"

    xbar=x.mean()
    n=x.shape[0]
    sd=x.std()
    lower=xbar-1.96*(sd/np.sqrt(n))
    upper=xbar+1.96*(sd/np.sqrt(n))
    interval=[lower,upper]
    return interval


def getCredibleInterval(x,prior_dis,sample_dis):
    """
    compute 95% credible interval (bayesian approach)

    Args:
    x:numpy array with at least 1 observation
    prior_dis: list, with exactly two number
    sample_dis: list, with exactly two number

    Return:
    interval: list with 2 elements
    """
    if (len(x.shape)>1):
        raise AttributeError('Input data must be numpy array with one column only')
    if(isinstance(x,np.ndarray) == False):
        raise TypeError("Not a numpy array")
    assert x.shape[0]!=0, "Empty Array!"

    prior_mean=prior_dis[0]
    prior_sd=prior_dis[1]
    sample_mean=sample_dis[0]
    sample_sd=sample_dis[1]
    vector_mean=x.mean()
    vector_n=x.shape[0]
    post_mean=(vector_mean*vector_n/sample_sd+prior_mean*1/prior_sd)/(vector_n/sample_sd+1/prior_sd**2)
    post_sd=1/(vector_n/(sample_sd**2)+1/(prior_sd**2))

    lower=stats.norm.ppf(0.025,loc=post_mean,scale=post_sd)
    upper=stats.norm.ppf(0.975,loc=post_mean,scale=post_sd)

    interval=[lower,upper]

    return interval
