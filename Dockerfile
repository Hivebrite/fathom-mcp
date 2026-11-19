# The base image comes from our registry; octopilot bumps the HB_VERSION below.
# HB_VERSION: python-3.13
ARG PYTHON_VERSION=3.13.17-debian13-202610212246

FROM europe-docker.pkg.dev/ss-automation-7176/registry-docker-europe/python:${PYTHON_VERSION}

ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

COPY pyproject.toml requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Environment variable placeholder (set at runtime)
ENV FATHOM_API_KEY=""

CMD ["fastmcp", "run", "server.py"]
