openssl req -x509 -newkey rsa:4096 -nodes -keyout prometheus.key -out prometheus.crt -sha256 -days 1 -subj "/C=SI/O=LPM/CN=lpm.feri.um.si"
