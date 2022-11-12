{{- $data := index .Site.Data.currentThsVersion -}}
{{- range .Params -}}
{{- $data = index $data . -}}
{{- end -}}
{{- $data -}}
