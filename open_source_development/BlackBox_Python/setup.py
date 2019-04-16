from distutils.core import setup

setup(
    name='BlackBox_Python',
    version='0.0.1dev',
    packages=['BlackBox_Python',],
    license='License.md',
    long_description=open('README.md').read(),
    author = ['Vinver Guan', 'Siddharth Arora', 'Abishek Murali'],
    install_requires=[
        "Numpy >= ",
        "Pandas >= ",
    ],
)
