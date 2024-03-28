# Helm Charts <!-- omit in toc -->

[![Lint Code Base](https://github.com/tampakrap/spotify-auth-proxy-helm-charts/actions/workflows/linter.yaml/badge.svg)](https://github.com/tampakrap/spotify-auth-charts-helm-charts/actions/workflows/linter.yaml)
[![Lint and Test Charts](https://github.com/tampakrap/spotify-auth-proxy-helm-charts/actions/workflows/lint-test.yaml/badge.svg)](https://github.com/tampakrap/spotify-auth-helm-charts/actions/workflows/lint-test.yaml)
[![Release Charts](https://github.com/tampakrap/spotify-auth-proxy-helm-charts/actions/workflows/release.yaml/badge.svg)](https://github.com/tampakrap/spotify-auth-proxy-helm-charts/actions/workflows/release.yaml)
[![pages-build-deployment](https://github.com/tampakrap/spotify-auth-proxy-helm-charts/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/tampakrap/spotify-auth-proxy-helm-charts/actions/workflows/pages/pages-build-deployment)

Various helm charts of applications that I use.

# Table of contents
- [Installation](#installation)
- Available Helm Charts
  - [spotify-auth-proxy](#spotify-auth-proxy)

## Installation

```
helm repo add tampakrap https://tampakrap.github.io/helm-charts
helm search repo tampakrap
```

Check the individual README of the available Helm charts in order to further
configure and install any of them.

## Available Helm Charts

### spotify-auth-proxy

- [Upstream repository](https://github.com/conradludgate/terraform-provider-spotify/tree/main/spotify_auth_proxy)
- [Helm Chart](charts/spotify-auth-proxy)
