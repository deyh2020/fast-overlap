from setuptools import Extension, setup
import numpy

setup(
    ext_modules = [Extension("fast_overlap", ["fast_overlap.c"], include_dirs=[numpy.get_include()])]
)

