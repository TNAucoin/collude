FROM python:3.10-bullseye as python-base

# Set Python Env Vars
ENV PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=0 

ENV POETRY_HOME="/opt/poetry" \
    POETRY_VERSION=1.2.2 \
    # make poetry create the virtual environment in the project's root
    # it gets named `.venv`
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    # do not ask any interactive question
    POETRY_NO_INTERACTION=1 \
    \
    # paths
    # this is where our requirements + virtual environment will live
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"

ENV APP_ROOT="/app"

# prepend poetry and venv to path
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

FROM python-base as builder-base


RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    # deps for installing poetry
    curl \
    # deps for building python deps
    build-essential 

RUN curl -sSL https://install.python-poetry.org | python3 -


# copy requirement files for cache
WORKDIR $PYSETUP_PATH
COPY poetry.lock pyproject.toml ./

#install runtime deps
RUN poetry install --no-root

# development image
FROM python-base as development

#copy the built poetry & venv
COPY --from=builder-base $POETRY_HOME $POETRY_HOME
COPY --from=builder-base $PYSETUP_PATH $PYSETUP_PATH


# Copying in our entrypoint
COPY ./provision/docker/api/bin/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

WORKDIR $PYSETUP_PATH
RUN poetry install --no-root

# mountpoint for app code
WORKDIR $APP_ROOT

COPY . .

EXPOSE 8000


