.PHONY: clean setup setup-dev format lint test check-all build-docker run-docker

clean:
	@echo "Cleaning up cache and temporary files..."
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	rm -rf .coverage
	rm -rf .mypy_cache/
	rm -rf .pytest_cache/
	rm -rf .ruff_cache/
	rm -rf .venv/
	rm -rf coverage_reports/
	rm -rf dist/
	rm -rf test_results/

setup:
	@echo "Installing Python dependencies without dev tools..."
	uv sync --no-dev

setup-dev:
	@echo "Installing Python dependencies with dev tools..."
	uv sync

format:
	@echo "Running ruff formatting..."
	uv run ruff format
	uv run ruff check --fix

lint:
	@echo "Running mypy..."
	uv run mypy

test:
	@echo "Running pytest"
	uv run pytest

check-all: format lint test

build-docker:
	@echo "Building docker image with docker-compose"
	docker compose build

run-docker:
	@echo "Running docker image with docker-compose"
	docker compose run app uv run example_script
