FROM squidfunk/mkdocs-material:6.2.2

COPY requirements.txt /docs/requirements.txt
RUN pip install -U -r /docs/requirements.txt