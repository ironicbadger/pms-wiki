FROM squidfunk/mkdocs-material:8.2.13

RUN git config --global --add safe.directory /docs

COPY requirements.txt /docs/requirements.txt
RUN pip install -U -r /docs/requirements.txt