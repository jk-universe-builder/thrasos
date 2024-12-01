{{/* Generate basic labels */}}
{{- define "default-k8-labels" }}
    app.kubernetes.io/name: {{ .Values.APP_DEVELOPMENT_NAME }}
    app.kubernetes.io/instance: {{ .Values.APP_DEVELOPMENT_NAME }}
    app.kubernetes.io/version: {{ .Values.APP_VERSION }}
    app.kubernetes.io/component: {{ .Values.APP_DEVELOPMENT_NAME }}
    app.kubernetes.io/part-of: {{ .Values.APP_DEVELOPMENT_NAME }}
    app.kubernetes.io/managed-by: helm
{{- end }}