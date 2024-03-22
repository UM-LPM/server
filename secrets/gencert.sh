openssl req -x509 -newkey rsa:4096 -nodes -keyout cert.key -out cert.crt -sha256 -days 7200 -subj "/C=SI/O=LPM/CN=lpm.feri.um.si"
