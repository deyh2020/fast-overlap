from setuptools import Extension, setup

setup(
    ext_modules = [Extension("fast_overlap", ["fast_overlap.c"])]
)

