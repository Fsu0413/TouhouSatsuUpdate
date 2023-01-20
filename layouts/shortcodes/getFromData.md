{{- $data := index site.Data.currentThsVersion -}}
{{- range .Params -}}
{{- $data = index $data . -}}
{{- end -}}
{{- $data -}}
