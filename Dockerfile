FROM ghcr.io/ironicbadger/mkdocs-material-insiders:latest AS builder

WORKDIR /build
COPY requirements.txt .
RUN pip install --no-cache-dir -U -r requirements.txt

COPY . .
RUN mkdocs build

# Final stage
FROM nginx:alpine
COPY --from=builder /build/site /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
