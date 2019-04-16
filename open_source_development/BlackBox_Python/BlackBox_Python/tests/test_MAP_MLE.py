"""
MAP vs MLE
"""
import pytest
import numpy as np
import pandas as pd

import sys
import os
sys.path.insert(0, os.path.abspath("."))
sys.path.insert(0, os.path.abspath("../"))

from BlackBox_Python import MapVMle as MVM


# test inputs
def test_input_types():

    try:
        MVM.getMLE()
    except TypeError:
        assert True
    else:
        assert False

    try:
        MVM.getMLE(1,[1,0,0,1])
    except TypeError:
        assert True
    else:
        assert False

    try:
        MVM.getMLE("hello", [1, 0, 0, 1])
    except TypeError:
        assert True
    else:
        assert False

    try:
        MVM.getMLE("poisson", [1])
    except TypeError:
        assert True
    else:
        assert False

    try:
        MVM.getMLE("bernoulli", [1])
    except TypeError:
        assert True
    else:
        assert False

    try:
        MVM.getMLE("bernoulli", [1, 0, 2, 1])
    except TypeError:
        assert True
    else:
        assert False

    try:
        MVM.getMLE("poisson", [-1, 0, 1, 2])
    except TypeError:
        assert True
    else:
        assert False

    try:
        MVM.getMLE("poisson", [1.5, 0.1, 1, 2])
    except TypeError:
        assert True
    else:
        assert False



def test_output():
    '''
    check if the output is valid
    '''
    # likelihood returned is between 0 and 1
    assert MVM.getMLE("poisson",[1,0,1,1,1,3,2]) >= 0
    assert 0 <= MVM.getMLE("bernoulli", [1, 0, 1, 1, 1, 1, 0]) <= 1
