ARG MKDOCS_BASE_IMAGE=squidfunk/mkdocs-material:latest
FROM ${MKDOCS_BASE_IMAGE} AS dev

WORKDIR /build
COPY requirements.txt .
RUN pip install --no-cache-dir -U -r requirements.txt

EXPOSE 8000
CMD ["serve", "--dev-addr=0.0.0.0:8000"]

FROM dev AS builder

COPY . .
RUN mkdocs build

# Final stage
FROM nginx:alpine
COPY --from=builder /build/site /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
