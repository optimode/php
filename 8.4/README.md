# PHP 8.4 information

## Installation
```bash
docker pull ghcr.io/optimode/php:8.4-cli
docker pull ghcr.io/optimode/php:8.4-fpm
docker pull ghcr.io/optimode/php:8.4-apache
```

## Docker compose
```yaml
services:
  php84:
    image: ghcr.io/optimode/php:8.4-fpm
    container_name: php84
    hostname: php84
    restart: no
    #user: 1000:1000
    stdin_open: true
    tty: true
```

## Docker run
```bash
docker run -d --rm --name php84 ghcr.io/optimode/php:8.4-fpm
```

## Available tags
- 8.4-cli
- 8.4-fpm
- 8.4-apache

## Installed extensions
The following modules and extensions have been enabled:

```
[PHP Modules]
amqp
apcu
bcmath
bz2
calendar
Core
csv
ctype
curl
date
dba
dom
enchant
exif
fileinfo
filter
ftp
gd
gettext
gmp
gnupg
grpc
hash
http
iconv
igbinary
imagick
imap
intl
json
libxml
lz4
lzf
mbstring
memcache
memcached
mongodb
msgpack
mysqli
mysqlnd
OAuth
openssl
pcntl
pcre
PDO
pdo_dblib
pdo_mysql
pdo_pgsql
pdo_sqlite
pgsql
Phar
pkcs11
posix
protobuf
pspell
psr
random
raphf
readline
redis
Reflection
session
shmop
SimpleXML
snmp
soap
sockets
sodium
SPL
sqlite3
standard
sysvmsg
sysvsem
sysvshm
tidy
timezonedb
tokenizer
uploadprogress
uuid
xdebug
xhprof
xlswriter
xml
xmlreader
xmlrpc
xmlwriter
xsl
yaml
Zend OPcache
zip
zlib
zstd

[Zend Modules]
Xdebug
Zend OPcache
```
