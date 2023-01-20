{{- $data := index site.Data.currentThsVersion -}}
{{- $previousVersion := index $data.Base.PreviousVersionNumber -}}
{{- $params := slice "Base" ( print "From" $previousVersion ) "Win" "UpdatePack" -}}
{{- range $params -}}
{{- $data = index $data . -}}
{{- end -}}
{{- $data -}}
