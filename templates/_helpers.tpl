{{/*
Expand the name of the chart.
*/}}
{{- define "zs-postgres-local.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "zs-postgres-local.fullname" -}}
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
  An alias for the postgres port so that we can use it upstream 
*/}}
{{- define "zs-postgres-local.port" -}}
{{ .Values.service.port }}
{{- end }}

{{/*
  An alias for the postgres user so that we can use it upstream 
*/}}
{{- define "zs-postgres-local.user" -}}
{{ .Values.username }}
{{- end }}

{{/*
  An alias for the postgres password so that we can use it upstream 
*/}}
{{- define "zs-postgres-local.password" -}}
{{ .Values.password }}
{{- end }}



{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "zs-postgres-local.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "zs-postgres-local.labels" -}}
helm.sh/chart: {{ include "zs-postgres-local.chart" . }}
{{ include "zs-postgres-local.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "zs-postgres-local.selectorLabels" -}}
app.kubernetes.io/name: {{ include "zs-postgres-local.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "zs-postgres-local.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "zs-postgres-local.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
