#!/bin/sh
#put your tor password in this file and then copy this file to "newnode.sh" and remove this comment
# also this depends on netcat
echo -e 'AUTHENTICATE "ENTERPASSWORDHERE"\r\nsignal NEWNYM\r\nQUIT' | nc 127.0.0.1 9051
