"""
Custom exceptions for Builder
"""


class BuilderError(Exception):
    """Base exception for Builder"""
    pass


class BuildError(BuilderError):
    """Error during build execution"""
    pass


class BuildInterrupted(BuilderError):
    """Build was interrupted by user"""
    pass


class SessionError(BuilderError):
    """Error related to session management"""
    pass


class PromptError(BuilderError):
    """Error related to prompt handling"""
    pass


class ClaudeError(BuilderError):
    """Error related to Claude interaction"""
    pass


class ConfigError(BuilderError):
    """Error related to configuration"""
    pass