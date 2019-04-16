"""
AB Tests(frequentist approach)
"""
import pytest
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

import sys
import os
sys.path.insert(0, os.path.abspath("."))
sys.path.insert(0, os.path.abspath("../"))

from BlackBox_Python import ABtests as AB

#check input
def test_input():
    '''
    Checks if input for the functions are as expected
    This should silently error
    '''
    #sample dataframes
    n = 2
    p = 0.5
    x = 1
    name = np.repeat(('A','B'),n/2)
    value= np.random.binomial(x, p,size = n)
    data = {'name':name,'value':value}
    data=pd.DataFrame(data)

    # Capture incorrect input data
    try:
        AB.performABtest_Freq()
    except(TypeError):
        assert True
    else:
        assert False

    # Capture incorrect alpha values
    try:
        AB.performABtest_Freq(data = data,alpha = 1.5)
    except(ValueError):
        assert True
    else:
        assert False


    try:
        data = {'name':name,'value':value,'value_copy':value}
        data=pd.DataFrame(data)
        AB.performABtest_Freq(data = data)
    except(TypeError):
        assert True
    else:
        assert False

    try:
        #sample dataframe
        n = 20
        p = 0.5
        x = 2
        name = np.repeat(('A','B'),n/2)
        value= np.random.binomial(x, p,size = n)
        data = {'name':name,'value':value}
    except(TypeError):
        assert True
    else:
        False

    #More than 2 kinds of event
    try:
        n = 20
        p = 0.5
        x = 1
        name = np.repeat(('A','B','C'),n/3)
        value= np.random.binomial(x, p,size = n)
        data = {'name':name,'value':value}
    except(TypeError):
        assert True
    else:
        False

    # Length of dataframes
    try:
        n = 18
        d = {'input':('A','B') * (n//2),'event':np.random.binomial(1,0.5,n)}
        inp = pd.DataFrame(data=d)
        AB.performABtest_Freq(inp)
    except(TypeError):
        assert True
    else:
        False


def test_output():
    '''
    This function checks if output of the function is as expected and does branch testing(white box testing)
    '''

    # Generate output. This covers branch with Chi-square test(Branch 1)
    n = 2500
    p = 0.5
    x = 1
    name = np.repeat(('A','B'),n/2)
    value= np.random.binomial(x, p,size = n)
    d = {'input':name,'event':value}
    inp = pd.DataFrame(data=d)
    op = AB.performABtest_Freq(inp,0.1)
    assert op[2] == "Chi square test"

    # Generate output. This covers branch with Fisher's exact test(Branch 2)
    n = 250
    p = 0.5
    x = 1
    name = np.repeat(('A','B'),n/2)
    value= np.random.binomial(x, p,size = n)
    d = {'input':name,'event':value}
    inp = pd.DataFrame(data=d)
    op = AB.performABtest_Freq(inp,0.1)
    assert op[2] == "Fisher's exact test"

    # Check if p-value is between 0 and 1
    op_p_val = True if op[0] > 0 and op[0] <= 1 else False

    #assert length and type of op
    assert len(op) == 3
    assert isinstance(op,list) == True
    assert op_p_val == True
    #
    # assert AB.performABtest_Bayesian(df) > 0
    # assert AB.performABtest_Bayesian(df) < 1
