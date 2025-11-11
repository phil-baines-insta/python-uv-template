import logging
import os

logger = logging.getLogger(__name__)


def add_numbers(a: int, b: int) -> int:
    """Add two numbers together.

    Args:
        a: First number
        b: Second number

    Returns:
        Sum of a and b
    """
    return a + b


def get_sample_config():
    return os.getenv("SAMPLE_CONFIG", "not_set")


def main():
    logging.basicConfig(level=logging.INFO)
    config = get_sample_config()
    logger.info(f"Config value is: {config}")
    return 0


if __name__ == "__main__":
    exit(main())
