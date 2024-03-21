{{/*
Expand the name of the chart.
*/}}
{{- define "spotify-auth-proxy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spotify-auth-proxy.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "spotify-auth-proxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "spotify-auth-proxy.labels" -}}
helm.sh/chart: {{ include "spotify-auth-proxy.chart" . }}
{{ include "spotify-auth-proxy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spotify-auth-proxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spotify-auth-proxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "spotify-auth-proxy.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "spotify-auth-proxy.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the client credentials secret to use
*/}}
{{- define "spotify-auth-proxy.clientCredentialsSecretName" -}}
{{- if .Values.clientCredentialsSecret.name -}}
    {{ .Values.clientCredentialsSecret.name }}
{{- else -}}
    {{ template "spotify-auth-proxy.fullname" . }}-credentials
{{- end -}}
{{- end -}}

{{/*
Create the name of the proxy API Key secret to use
*/}}
{{- define "spotify-auth-proxy.proxyAPIKeySecretName" -}}
{{- if .Values.proxyAPIKeySecret.name -}}
    {{ .Values.proxyAPIKeySecret.name }}
{{- else -}}
    {{ template "spotify-auth-proxy.fullname" . }}-api-key
{{- end -}}
{{- end -}}
