import pandas as pd
import numpy as np
import pandas as pd
from scipy.optimize import minimize

def getMLE(distribution,data):
    """
    compute the log likelihood of data given the distribution
    Args:
    distribution: type of distribution of the data. for example (binomial, poisson). Support for 2 as of now.
    data: the list of numeric data over which we perform the maximum likelihood
    Return:
    the log likelihood of the data
    """
    if not (isinstance(distribution,str)):
        raise TypeError("Type of distribution must be a string value")

    if not isinstance(data, list):
        raise TypeError("Input data must be a numeric list")

    vec_list = np.array(data)

    if (str.lower(distribution) != "poisson") ^ (str.lower(distribution) == "bernoulli"):
        raise TypeError("Input values for distribution can only take in values; Bernoulli and Poisson")

    if str.lower(distribution) == "bernoulli" and len(vec_list) > 1 and not np.array_equal(np.unique(vec_list), [0, 1]):
        raise TypeError("Data for bernoulli should only have values of numeric 0 and 1")

    if (str.lower(distribution) == "bernoulli" or str.lower(distribution) == "poisson") and np.array_equal(len(vec_list),1):
        raise TypeError("Wrong format for data input; list of length > 1 expected")

    if isinstance(distribution,str) and not np.equal(np.mod(vec_list, 1), 0).all():
        raise TypeError("Wrong format for data input, list must contain must only contain integer values")

    if isinstance(distribution,str) and not (vec_list >= 0).all():
        raise TypeError("Wrong format for data input, list must contain must only contain non-negative integer values")

    if str.lower(distribution) == "poisson":
        likelihood_poisson = np.mean(vec_list)
        return likelihood_poisson

    if str.lower(distribution) == "bernoulli":
        return np.mean(vec_list)
