"""
Allow running builder as a module: python -m builder
"""

from .cli import cli

if __name__ == '__main__':
    cli()