# Spotify-Auth-Proxy <!-- omit in toc -->

[![Lint Code Base](https://github.com/tampakrap/spotify-auth-proxy-helm-charts/actions/workflows/linter.yaml/badge.svg)](https://github.com/tampakrap/spotify-auth-charts-helm-charts/actions/workflows/linter.yaml)
[![Lint and Test Charts](https://github.com/tampakrap/spotify-auth-proxy-helm-charts/actions/workflows/lint-test.yaml/badge.svg)](https://github.com/tampakrap/spotify-auth-helm-charts/actions/workflows/lint-test.yaml)
[![Release Charts](https://github.com/tampakrap/spotify-auth-proxy-helm-charts/actions/workflows/release.yaml/badge.svg)](https://github.com/tampakrap/spotify-auth-proxy-helm-charts/actions/workflows/release.yaml)
[![pages-build-deployment](https://github.com/tampakrap/spotify-auth-proxy-helm-charts/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/tampakrap/spotify-auth-proxy-helm-charts/actions/workflows/pages/pages-build-deployment)

[Spotify-Auth-Proxy](https://github.com/conradludgate/terraform-provider-spotify/tree/main/spotify_auth_proxy)
is an instance of a 'Spotify auth server' which acts as an interface between a
client and the Spotify OAuth API.

# Table of contents
- [Introduction](#introduction)
- [Prerequisities](#prerequisities)
- [Configuration](#configuration)
- [Usage](#usage)

## Introduction

This chart creates a single pod in a Deployment running spotify-auth-proxy,
along with the required Service. Optionally it can create Secrets.

## Prerequisities

Login to the [Spotify developer
dashboard](https://developer.spotify.com/dashboard/login) and create a new app.
Inside that new app you will find the Client ID and Client Secret, which you
will to set later to spotify-auth-proxy.

See also [this post for more detailed
instructions](https://developer.hashicorp.com/terraform/tutorials/community-providers/spotify-playlist)
on how to create the app and how to get the Client ID/Secret.

## Configuration

Spotify-Auth-Proxy configuration is done via the following environment
variables:

Environment Variable | Required/Optional | Default value
---------------------|-------------------|--------------
SPOTIFY_CLIENT_ID | Required |
SPOTIFY_CLIENT_SECRET | Required |
SPOTIFY_PROXY_API_KEY | Optional |
SPOTIFY_PROXY_BASE_URI | Optional | http://localhost:27228

See the
[README](https://github.com/conradludgate/terraform-provider-spotify/blob/main/spotify_auth_proxy/README.md)
of `Spotify-Auth-Proxy` for more details on them.

In the helm chart, the first three are set up via secrets, while the fourth via
a plain text variable.

The `SPOTIFY_CLIENT_ID` and `SPOTIFY_CLIENT_SECRET` credentials are set up via
a kubernetes secret, which can either be created by the helm chart or it can be
manually created. Search for the variable `clientCredentialsSecret` in
`values.yaml` and read the comments for more details.

Similarly, the `SPOTIFY_PROXY_API_KEY` is set via another kubernetes secret,
which can also be either created by the helm chart or it can be manually
created. Search for the variable `proxyAPIKeySecret` in `values.yaml` and read
the comments for more details.

The `SPOTIFY_PROXY_BASE_URI` is not a secret, it can be set via a variable,
which is named `spotifyProxyBaseURI`.

Example values.yaml files:
- [with the secrets managed by this helm chart](charts/spotify-auth-proxy/ci/ci-create-secrets-values.yaml)
- [with external secrets](charts/spotify-auth-proxy/ci/ci-external-secrets-values.yaml)

## Usage

After setting up the environment variables as described above, and after
installing the helm chart, you should have one StatefulSet with one replica
running. Check the logs of that pod, it should output something like the
following (replace `spotify-auth-proxy` in case you have set different name):

```
➜ kubectl -n spotify-auth-proxy logs spotify-auth-proxy-0
APIKey:   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Auth URL: ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
```

If the `SPOTIFY_PROXY_API_KEY` is set, then the log will output only the Auth
URL.

Open the Auth URL on your browser in order to log in. In case the Auth URL is
only accessible for localhost, then you can set a port forward:

```
➜ kubectl -n spotify-auth-proxy port-forward svc/spotify-auth-proxy 27228
Forwarding from 127.0.0.1:27228 -> 27228
Forwarding from [::1]:27228 -> 27228
```

Open the URL with a browser in order to login. As soon as the Authentication is
successful, then you can use the API Key either in the [Terraform Spotify
provider](https://github.com/conradludgate/terraform-provider-spotify) or in
the [Crossplane Spotify
provider](https://github.com/tampakrap/provider-spotify).
