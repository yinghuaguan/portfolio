"""
Credible Interval Tests(bayesian approach)
"""

import pytest
import numpy as np
from BlackBox_Python import ci

#sample vector
np.random.seed(1)
sample=np.random.normal(loc=4,scale=1,size=5)


#check input
def test_input():
    '''
    check if the input is valid for getCredibleInterval()
    '''
    with pytest.raises(AttributeError):
        ci.getCredibleInterval(np.array([[1,2,3],[2,3,4]]),list([3,1]),list([4,1]))


    with pytest.raises(TypeError):
        ci.getCredibleInterval()

    with pytest.raises(TypeError):
        ci.getCredibleInterval(list([1,2,3]))

    #valid dataframe must have at least 1 observations
    assert sample.shape[0]>0

    #valid dataframe must include two columns only
    assert len(sample.shape)==1

    #check if the vector is numeric
    assert sample.dtype==np.int64 or sample.dtype==np.float64

def test_output():
    '''
    check if the output interval is valid
    '''

    #output is a list with two elements
    assert len(ci.getCredibleInterval(sample,list([3,1]),list([4,1])))==2


    #check if the interval is correct
    expected_lower=3.55281
    expected_upper=4.206136

    evaluated_lower=ci.getCredibleInterval(sample,list([3,1]),list([4,1]))[0]
    evaluated_upper=ci.getCredibleInterval(sample,list([3,1]),list([4,1]))[1]
    assert abs(evaluated_lower-expected_lower)<1e-5
    assert abs(evaluated_upper-expected_upper)<1e-5
