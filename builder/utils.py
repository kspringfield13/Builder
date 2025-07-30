"""
Utility functions for Builder
"""

import logging
import sys
from datetime import datetime
from pathlib import Path
from typing import Optional


def setup_logging(level: str = 'INFO'):
    """Setup logging configuration"""
    log_format = '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    date_format = '%Y-%m-%d %H:%M:%S'
    
    # Convert string level to logging constant
    numeric_level = getattr(logging, level.upper(), logging.INFO)
    
    # Configure root logger
    logging.basicConfig(
        level=numeric_level,
        format=log_format,
        datefmt=date_format,
        handlers=[
            logging.StreamHandler(sys.stdout),
            logging.FileHandler(f'builder_{datetime.now().strftime("%Y%m%d")}.log')
        ]
    )
    
    # Set specific loggers
    logging.getLogger('asyncio').setLevel(logging.WARNING)
    logging.getLogger('sqlite3').setLevel(logging.WARNING)


def print_banner():
    """Print Builder banner"""
    banner = """
╔══════════════════════════════════════════════════════════════════╗
║                                                                  ║
║                    🏗️  BUILDER v2.0.0 🏗️                         ║
║                                                                  ║
║           Autonomous Build Orchestration System                  ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
"""
    print(banner)


def format_duration(seconds: float) -> str:
    """Format duration in human-readable format"""
    if seconds < 60:
        return f"{int(seconds)}s"
    elif seconds < 3600:
        minutes = int(seconds // 60)
        secs = int(seconds % 60)
        return f"{minutes}m {secs}s"
    else:
        hours = int(seconds // 3600)
        minutes = int((seconds % 3600) // 60)
        return f"{hours}h {minutes}m"


def truncate_text(text: str, max_length: int = 100, suffix: str = '...') -> str:
    """Truncate text to maximum length"""
    if len(text) <= max_length:
        return text
    return text[:max_length - len(suffix)] + suffix


def ensure_directory(path: Path) -> Path:
    """Ensure directory exists"""
    path.mkdir(parents=True, exist_ok=True)
    return path


def get_timestamp() -> str:
    """Get current timestamp string"""
    return datetime.now().strftime('%Y%m%d_%H%M%S')


def sanitize_filename(filename: str) -> str:
    """Sanitize filename for filesystem"""
    # Remove invalid characters
    invalid_chars = '<>:"|?*'
    for char in invalid_chars:
        filename = filename.replace(char, '_')
    
    # Remove leading/trailing dots and spaces
    filename = filename.strip('. ')
    
    # Limit length
    if len(filename) > 255:
        name, ext = filename.rsplit('.', 1) if '.' in filename else (filename, '')
        name = name[:255 - len(ext) - 1]
        filename = f"{name}.{ext}" if ext else name
    
    return filename


class ProgressBar:
    """Simple progress bar for terminal output"""
    
    def __init__(self, total: int, width: int = 50, prefix: str = '', suffix: str = ''):
        self.total = total
        self.width = width
        self.prefix = prefix
        self.suffix = suffix
        self.current = 0
    
    def update(self, current: int):
        """Update progress bar"""
        self.current = current
        self.display()
    
    def increment(self, amount: int = 1):
        """Increment progress"""
        self.current += amount
        self.display()
    
    def display(self):
        """Display progress bar"""
        if self.total == 0:
            percent = 100
        else:
            percent = int(100 * self.current / self.total)
        
        filled = int(self.width * self.current / self.total) if self.total > 0 else self.width
        bar = '█' * filled + '░' * (self.width - filled)
        
        # Clear line and print progress
        print(f'\r{self.prefix} |{bar}| {percent}% {self.suffix}', end='', flush=True)
        
        if self.current >= self.total:
            print()  # New line when complete


def format_size(bytes: int) -> str:
    """Format byte size in human-readable format"""
    for unit in ['B', 'KB', 'MB', 'GB', 'TB']:
        if bytes < 1024.0:
            return f"{bytes:.1f} {unit}"
        bytes /= 1024.0
    return f"{bytes:.1f} PB"


def is_docker() -> bool:
    """Check if running inside Docker container"""
    return Path('/.dockerenv').exists() or Path('/proc/self/cgroup').exists()


def get_system_info() -> dict:
    """Get system information"""
    import platform
    
    return {
        'platform': platform.system(),
        'platform_release': platform.release(),
        'platform_version': platform.version(),
        'architecture': platform.machine(),
        'hostname': platform.node(),
        'python_version': platform.python_version(),
        'in_docker': is_docker()
    }