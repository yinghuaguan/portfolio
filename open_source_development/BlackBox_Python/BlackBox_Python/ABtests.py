import scipy.stats as stats
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import math

def performABtest_Freq(data,alpha = 0.05):
    """
    Get results of A/B tests done using the frequentist approach

    Args:
    data: dataframe with the events and the outcomes
    alpha: False positive rate for the experiment

    Return:
    1. p-value of the outcome
    2. Graph indicating the variation of p-values
    3. Method used to evaluate p-value
    """

    if data is None or (not isinstance(data,pd.DataFrame)):
        raise TypeError("Input data must be a dataframe")

    if alpha > 1 or alpha < 0:
        raise ValueError("Alpha/False positive rate cannot be greater than 1 or less than 0")

    if data.shape[1] != 2:
        raise TypeError("Input data must have 2 columns")

    if not np.array_equal(data["event"].sort_values().unique(),[0,1]):
        raise TypeError("Input events can have values of just 0 and 1")

    if (len(np.unique(data["input"])) != 2):
        raise TypeError("Can have only 2 events for the test")

    if (len(data) < 20):
        raise TypeError("Must have at least 20 rows in the dataframe")

    data = data.sample(frac=1).reset_index(drop=True)

    conti_tab = data.groupby('input').agg({'event': ['sum', 'count']})
    conti_tab['event']['count'] = conti_tab['event']['count'] - conti_tab['event']['sum']

    start_iter = math.floor(0.75 * len(data))

    ip = {'index':[],'p_val':[]}
    if len(data) < 2000:
        method = "Fisher's exact test"
        for i in range(start_iter,len(data)):
            conti_tab = data[0:i].groupby('input').agg({'event': ['sum', 'count']})
            conti_tab['event']['count'] = conti_tab['event']['count'] - conti_tab['event']['sum']
            ip['index'].append(i)
            pval = stats.fisher_exact(conti_tab['event'])[1]
            ip['p_val'].append(round(pval,4))
    else:
        method = "Chi square test"
        for i in range(start_iter,len(data)):
            conti_tab = data[0:i].groupby('input').agg({'event': ['sum', 'count']})
            conti_tab['event']['count'] = conti_tab['event']['count'] - conti_tab['event']['sum']
            ip['index'].append(i)
            pval = stats.chi2_contingency(conti_tab['event'])[1]
            ip['p_val'].append(round(pval,4))

    f, ax = plt.subplots(figsize=(8,8))
    ax.plot(ip['index'],ip['p_val'], "-or")
    ax.axhline(y=alpha, color='g', linestyle='-')
    ax.set_xlabel("Record number")
    ax.set_ylabel("p-value")
    ax.set_title("Variation of p-values",fontsize = 15)
    ax.annotate('Alpha value = ' + str(alpha),xy=(len(data) - len(data)//4,alpha + 0.02),fontsize = 12)

    return [ip['p_val'][-1],ax,method]

# def performABtest_Bayesian(df,prior = None):
#     """
#     Get results of A/B tests done using the Bayesian approach
#
#     Args:
#     dataframe: first column is event(string), second column is value(numeric)
#     prior: prior assumptions of the data
#
#     Return:
#     p-value indicating significance.
#     """
#     if(isinstance(df,pd.DataFrame) == False):
#         raise TypeError("Not a data frame")
#
#     dummy_p_value = -0.5
#     return dummy_p_value
