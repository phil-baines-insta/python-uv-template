from package.core.example import add_numbers, get_sample_config, main


def test_add_numbers():
    """Test the add_numbers function."""
    assert add_numbers(2, 3) == 5


def test_get_sample_config_with_value(mocker):
    """Test get_sample_config when SAMPLE_CONFIG environment variable is set."""
    mocker.patch.dict("os.environ", {"SAMPLE_CONFIG": "test_value"})
    assert get_sample_config() == "test_value"


def test_get_sample_config_default():
    """Test get_sample_config when SAMPLE_CONFIG environment variable is not set."""
    assert get_sample_config() == "not_set"


def test_main():
    """Test main function."""
    assert main() == 0
