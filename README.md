# Python UV Template

A modern Python project template using [uv](https://docs.astral.sh/uv/) for fast dependency management and Docker for containerization.


## 📁 Directory Structure

```
python-uv-template/
├── .gitignore               # Git ignore patterns
├── .python-version          # Python version specification
├── VERSION                  # Package version
├── pyproject.toml           # Project configuration and dependencies
├── uv.lock                  # Locked dependency versions
├── Makefile                 # Development commands
├── Dockerfile               # Container configuration
├── docker-compose.yml       # Docker Compose configuration
├── README.md                # This file
├── package/                 # Main package source code
│   ├── __init__.py          # Package initialization
│   └── core/                # Core package modules
│       └── example.py       # Example module with sample functions
└── tests/                   # Test suite
    ├── __init__.py          # Test package initialization
    └── core/                # Core tests
        └── test_example.py  # Example tests
```


## 🛠️ Getting Started

### Prerequisites
- Python 3.11+
- [uv](https://docs.astral.sh/uv/) package manager
- Docker & Docker Compose (for containerization)

### Quick Start

1. **Install dependencies:**
```bash
make setup-dev
# Or manually: uv sync
```

2. **Customize for your project:**
   - Update `pyproject.toml`: Change `name`, `description`, `authors`, and `dependencies`
   - Update `VERSION` file with your initial version
   - Rename the `package/` directory to your package name
   - Update test imports accordingly

3. **Verify setup:**
```bash
make check-all  # Runs format, lint, and tests
```


## 🧪 Development & Testing

### Available Make Commands

**Development:**
```bash
make clean         # Clean build artifacts and caches
make setup         # Install production dependencies only
make setup-dev     # Install all dependencies including dev tools
make format        # Format code with ruff
make lint          # Run mypy type checking
make test          # Run tests with pytest
make check-all     # Run format, lint, and test together
```

**Docker:**
```bash
make build-docker  # Build Docker image using docker-compose
make run-docker    # Run container with example script
```

### Development Workflow

1. Write your code in the `package/` directory
2. Add tests in the `tests/` directory
3. Run `make check-all` before committing

### Quality Tools

- **Ruff**: Fast Python linter and formatter
- **MyPy**: Static type checking
- **Pytest**: Testing framework with coverage reports
- **Coverage**: HTML and LCOV reports generated in `coverage_reports/`


## 🐳 Docker Support

### Using Docker Compose

The project includes Docker Compose configuration with support for build secrets.

**Build and run:**
```bash
# Set the UV_INDEX_URL secret (if using a private package index)
export UV_INDEX_URL="your-package-index-url"

# Build the Docker image
make build-docker

# Run the container
make run-docker
```

**Docker Compose Features:**
- Uses official `ghcr.io/astral-sh/uv:python3.11-bookworm` base image
- Supports build-time secrets for private package indexes
- Automatically handles secret mounting during build

**Customization:**
- Edit `docker-compose.yml` to add runtime environment variables
- Modify `Dockerfile` to adjust the build process
- See `docker-compose.yml` for secret configuration options

### About UV_INDEX_URL

The `UV_INDEX_URL` secret is used for accessing private package indexes (like AWS CodeArtifact or private PyPI servers).

**If you don't need private packages:**
1. Remove the secret mount from `Dockerfile`:
```dockerfile
# Remove this line:
RUN --mount=type=secret,id=UV_INDEX_URL,env=UV_INDEX_URL \
    uv sync --locked

# Replace with:
RUN uv sync --locked
```

2. Remove the secrets section from `docker-compose.yml`:
```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
      # Remove the secrets section below
```

**If you need private packages:**
- Set `UV_INDEX_URL` as an environment variable before building
- Format: `https://username:password@your-package-index.com/simple/`
- For AWS CodeArtifact: Use `aws codeartifact login` to configure


## 🔧 Configuration

All tools are pre-configured in `pyproject.toml`:

### Ruff
- Python 3.11 target version
- Automatic code formatting and linting
- Import sorting with isort-compatible rules

### MyPy
- Type checking for `package/` and `tests/` directories
- Automatic type stub installation
- Ignores missing imports for external packages

### Pytest
- Coverage reporting (HTML, LCOV, terminal)
- JUnit XML output for CI integration
- pytest-sugar for better test output
- Minimum 80% coverage recommended

## 📋 Features

✅ **Modern tooling**: uv for blazing-fast dependency management
✅ **Type safety**: MyPy configuration with strict checking
✅ **Code quality**: Ruff for linting and formatting
✅ **Testing**: Pytest with coverage reports
✅ **Docker ready**: Multi-stage builds with build secrets support
✅ **Development workflow**: Makefile with common commands
✅ **Consistent environment**: Locked dependencies with uv.lock
