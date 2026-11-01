FROM python:3.11-slim@sha256:673719e071ecf27434fd2635bbd8d00f49f4fdd81f243143438a42ced8bedf60

# add apache bench (ab) tool
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apache2-utils \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash appuser

WORKDIR /seed

COPY --chown=appuser:appuser . .

# create POST data files with ab friendly formats
RUN python make-data.py && chown -R appuser:appuser /seed

USER appuser

CMD ["/seed/generate-votes.sh"]
