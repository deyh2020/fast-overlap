from setuptools import Extension, setup
from Cython.Build import cythonize
import numpy

setup(
    ext_modules=cythonize(
        [
            Extension(
                "fast_overlap", ["fast_overlap.pyx"], include_dirs=[numpy.get_include(), "."]
                # "fast_overlap", ["fast_overlap.pyx", "parallel_overlap.cpp"], include_dirs=[numpy.get_include(), "."]
            )
        ],
        language_level="3",
        language="c++",
    )
)
