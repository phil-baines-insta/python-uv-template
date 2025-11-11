FROM ghcr.io/astral-sh/uv:python3.11-bookworm

RUN useradd -m -u 1000 -s /bin/bash app
RUN echo "app:app" | chpasswd
RUN echo "app ALL=NOPASSWD: ALL" >> /etc/sudoers

ENV runDeps=' \
    awscli \
'

RUN set -ex \
    && apt-get update --allow-releaseinfo-change -yqq \
    && apt-get dist-upgrade -y \
    && apt-get install -yqq --no-install-recommends \
        $runDeps

USER app
ENV HOME=/app
WORKDIR /app

COPY --chown=app:app pyproject.toml /app/pyproject.toml
COPY --chown=app:app uv.lock /app/uv.lock
COPY --chown=app:app VERSION /app/VERSION
COPY --chown=app:app README.md /app/README.md
COPY --chown=app:app package /app/package

RUN --mount=type=secret,id=UV_INDEX_URL,env=UV_INDEX_URL \
    uv sync --locked
