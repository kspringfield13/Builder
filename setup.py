"""
Setup script for Builder
"""

from setuptools import setup, find_packages
from pathlib import Path

# Read README
readme_file = Path(__file__).parent / 'README.md'
if readme_file.exists():
    long_description = readme_file.read_text()
else:
    long_description = 'Builder - Autonomous Build Orchestration System'

setup(
    name='builder-orchestrator',
    version='2.0.0',
    description='Unified autonomous build orchestration system for Claude',
    long_description=long_description,
    long_description_content_type='text/markdown',
    author='Raivyn',
    python_requires='>=3.8',
    packages=find_packages(),
    install_requires=[
        'click>=8.0',
        'pyyaml>=6.0',
        'aiofiles>=0.8',
        'rich>=10.0',  # For better terminal output
    ],
    extras_require={
        'web': [
            'fastapi>=0.68',
            'uvicorn>=0.15',
            'websockets>=10.0',
            'jinja2>=3.0',
        ],
        'dev': [
            'pytest>=6.0',
            'pytest-asyncio>=0.18',
            'black>=22.0',
            'flake8>=4.0',
            'mypy>=0.910',
        ]
    },
    entry_points={
        'console_scripts': [
            'builder=builder.cli:cli',
        ],
    },
    classifiers=[
        'Development Status :: 4 - Beta',
        'Intended Audience :: Developers',
        'Topic :: Software Development :: Build Tools',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3.10',
        'Programming Language :: Python :: 3.11',
    ],
)