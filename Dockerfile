FROM squidfunk/mkdocs-material:7.1.9

COPY requirements.txt /docs/requirements.txt
RUN pip install -U -r /docs/requirements.txt