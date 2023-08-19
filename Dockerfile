#FROM squidfunk/mkdocs-material:9.1
FROM ghcr.io/ironicbadger/mkdocs-material-insiders:latest

RUN git config --global --add safe.directory /docs

COPY requirements.txt /docs/requirements.txt
RUN pip install -U -r /docs/requirements.txt