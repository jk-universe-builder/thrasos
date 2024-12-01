{{/* Generate basic labels */}}
{{- define "helm-labels" }}
    generator: helm
    generation-date: {{ now | htmlDate }}
    chart: {{ .Chart.Name }}
    version: {{ .Chart.Version }}
{{- end }}