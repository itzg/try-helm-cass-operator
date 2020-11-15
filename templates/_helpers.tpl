{{/*
Expand the name of the chart.
*/}}
{{- define "deploy-ceres-gke.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "deploy-ceres-gke.fullname" -}}
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
{{- define "deploy-ceres-gke.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "deploy-ceres-gke.labels" -}}
helm.sh/chart: {{ include "deploy-ceres-gke.chart" . }}
{{ include "deploy-ceres-gke.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "deploy-ceres-gke.selectorLabels" -}}
app.kubernetes.io/name: {{ include "deploy-ceres-gke.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "deploy-ceres-gke.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "deploy-ceres-gke.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "deploy-ceres-gke.cassandraStorageClassName" -}}
{{- printf "%s-%s" .Release.Name .Values.cassandra.storageClassName | trunc 63 | trimSuffix "-" }}
{{- end}}

{{- define "deploy-ceres-gke.cassandraClusterName" -}}
{{- .Release.Name }}
{{- end}}
