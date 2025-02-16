{{/*
Expand the name of the chart.
*/}}
{{- define "rainloop.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "rainloop.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Chart name and version.
*/}}
{{- define "rainloop.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}

