set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

image := "pms-wiki-mkdocs:local"
base_image := env_var_or_default("MKDOCS_BASE_IMAGE", "squidfunk/mkdocs-material:latest")
port := env_var_or_default("PORT", "8000")

default:
    @just --list

# Serve the MkDocs site locally with live reload.
serve:
    docker build --build-arg MKDOCS_BASE_IMAGE={{base_image}} --target dev -t {{image}} .
    docker run --rm -it \
        -p {{port}}:8000 \
        -v "{{justfile_directory()}}:/build" \
        -w /build \
        {{image}}
