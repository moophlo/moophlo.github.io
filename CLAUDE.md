# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository is a **Helm chart repository** hosted on GitHub Pages at `moophlo.github.io`. It contains custom and forked Helm charts for deploying various services on Kubernetes clusters.

## Chart Inventory

The `charts/` directory contains the following charts:

| Chart | Description | Notes |
|-------|-------------|-------|
| `collabora-muflo` | Collabora Online (ONLYOFFICE alternative) | Custom chart with Deployment, HPA, Ingress, Service |
| `rainloop` | Rainloop webmail client | Custom chart with custom Dockerfile, nginx.conf, php.ini |
| `stable-diffusion` | Stable Diffusion AI image generation | Minimal custom chart |
| `mastodon` | Mastodon social network | Forked chart, has `Chart.lock` with dependencies |
| `wordpress` | WordPress with Apache/PHP-FPM | Forked from bitnami, extensive templates (PDB, HPA, ServiceMonitor, NetworkPolicies), has CI test values |
| `metrics-server` | Kubernetes metrics server | Forked chart with RBAC, PDB support |
| `n8n` | n8n workflow automation | Forked chart with schema validation, has `values-kind.yaml` for Kind cluster testing |

## Chart Types

- **Custom charts** (`collabora-muflo`, `rainloop`, `stable-diffusion`): Original charts authored for this repository.
- **Forked/maintained charts** (`wordpress`, `mastodon`, `metrics-server`, `n8n`): Forked from upstream (often bitnami or official charts), with local modifications. These have `Chart.lock` files and sometimes `ci/` directories with test values.

## Release Process

Managed via `.github/workflows/release.yml` (typically `chart-releaser` or similar GitHub Action that publishes chart packages on release tags).

## Common Development Tasks

### Lint a chart
```bash
helm lint charts/<chart-name>
```

### Lint with custom values (e.g., WordPress CI scenarios)
```bash
helm lint charts/wordpress -f charts/wordpress/ci/values-metrics-and-ingress.yaml
```

### Package a chart
```bash
helm package charts/<chart-name>
```

### Template render (dry-run preview)
```bash
helm template my-release charts/<chart-name>
helm template my-release charts/<chart-name> -f charts/<chart-name>/values.yaml
```

### Template render with custom values
```bash
helm template my-release charts/wordpress -f charts/wordpress/ci/values-hpa-pdb.yaml
```

### Run chart-testing (if `ct` is available)
```bash
ct lint charts/<chart-name>
```

### Rainloop: build custom Docker image
```bash
docker build -t rainloop-custom charts/rainloop
```

## Key Patterns

- **Forked charts** have `Chart.lock` files — run `helm dependency update charts/<chart-name>` after modifying `Chart.yaml` dependencies.
- **WordPress** has `values.schema.json` for value validation — update it when adding/removing values.
- **n8n** has `values.schema.json` and a `README.md.gotmpl` template — update both when changing values.
- **CI values** for WordPress live in `charts/wordpress/ci/` — use them for linting specific configurations.
- Chart versions follow **SemVer** (`version` in `Chart.yaml`); app versions (`appVersion`) reflect the underlying service version.
