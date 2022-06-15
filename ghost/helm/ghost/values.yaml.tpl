
{{ $dbPwd := dedupe . "ghost.db.password" (randAlphaNum 26) }}

global:
  application:
    links:
    - description: ghost web address
      url: {{ .Values.ghostDomain }}
    - description: ghost admin interface
      url: {{ .Values.ghostDomain }}/ghost

ghost:
  domain: {{ .Values.ghostDomain }}
  env:
    url: https://{{ .Values.ghostDomain }}/
    database__connection__password: {{ $dbPwd }}
    mail__from: {{ .Values.ghostEmail }}

ingress:
  hosts:
    - host: {{ .Values.ghostDomain }}
      paths:
        - path: /
          pathType: ImplementationSpecific
  tls:
   - secretName: ghost-tls
     hosts:
       - {{ .Values.ghostDomain }}

db:
  password: {{ $dbPwd }}
  rootPassword: {{ dedupe . "ghost.db.rootPassword" (randAlphaNum 26) }}
