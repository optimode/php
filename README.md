# PHP Docker Images
## It is currently still a very rudimentary project, barely tested. 

## !!! Use at your own risk !!!

optimode/php container images built on top of the [official PHP images](https://hub.docker.com/r/_/php/) with the addition of some common and useful extensions, installed with [mlocati/docker-php-extension-installer](https://github.com/mlocati/docker-php-extension-installer). 

You may ask: what makes this image better/more useful?

I used devilbox/php-fpm images before.
I was happy with them, but unfortunately they stopped working. I looked for other images, but unfortunately I couldn't find a suitable one. However, I was inspired by php compiling, docker image build methods, and thus I developed the methodology shown here.

In the case of php, compiling php is the difficult task, especially because of the dependencies of older versions. I spent a lot of time on this before in a native linux environment (Arch Linux), so that all versions 5.2 - 8.3 could be compiled in a fresh linux environment. It's not a dream job, so if possible, I'd rather skip it. The colleagues working behind the official php image have already done this difficult and valuable work, I would like to thank them!

Using the results of their work, the official php images are the basis of optimode/php images, always. I just added many extensions, and a simple "docker and make build" methodology to it.

So I would say that the strength/differentiation of the optimode/php image is that it includes all the available and more commonly used php extensions and as an administrator you don't have to spend too much energy configuring an extension that is not included in most images by default.

I'm not saying that the optimode/php images are better. They are fine for me. You decide if these images are more useful for you.

The images are based on the current official php-cli image. So, optimode/php:X.X-cli is built on, and optimode/php:X.X-apache and optimode/php:X.X-fpm are based on the optimode/php:X.X-cli. 
All available modules are installed in the optimode/php:X.X-cli, and optimode/php:X.X-fpm and optimode/php:X.X-apache add their own features.

```
php:X.X-cli
|__ optimode/php:X.X-cli
   |____ optimode/php:X.X-fpm
   |____ optimode/php:X.X-apache
```

## Available versions

- 8.4 [documentation](8.4/README.md)
- 8.3 [documentation](8.3/README.md)
- 8.2 [documentation](8.2/README.md)
- 8.1 [documentation](8.1/README.md)
- 8.0 [documentation](8.0/README.md)
- 7.4 [documentation](7.4/README.md)
- 7.3 [documentation](7.3/README.md)
- 7.2 [documentation](7.2/README.md)
- 7.1 [documentation](7.1/README.md)
- 7.0 [documentation](7.0/README.md)
- 5.6 [documentation](5.6/README.md)

### Image variants
The structure of optimode/php image names and variants: 

```
<image_name>:<tag> 
```

Structure of \<tag> is: 
```
<version>-<sapi>
```

So in summary: 
```
<image_name>:<version>-<sapi>
```

VERSION is the php version number and PHP_SAPI is the php mode. PHP_SAPI values can be: cli, fpm, apache

Examples: 

* optimode/php:8.4-cli
* optimode/php:8.4-fpm
* optimode/php:8.4-apache

## Installation
I am constantly building the images and uploading them to ghcr.io, so you can even install the images directly from there.

[List of all container versions](pkgs/container/php/versions)

Install from the command line:

```bash
$ docker pull ghcr.io/optimode/php:TAG
```


You can find the specific installation image name in the documentation for the specific version, but you can also find it in the table here:

| Version | cli | fpm | apache |
| :-----------: |-----|-----|--------|
| 8.4 | ghcr.io/optimode/php:8.4-cli | ghcr.io/optimode/php:8.4-fpm | ghcr.io/optimode/php:8.4-apache |
| 8.3 | ghcr.io/optimode/php:8.3-cli | ghcr.io/optimode/php:8.3-fpm | ghcr.io/optimode/php:8.3-apache |
| 8.2 | ghcr.io/optimode/php:8.2-cli | ghcr.io/optimode/php:8.2-fpm | ghcr.io/optimode/php:8.2-apache |
| 8.1 | ghcr.io/optimode/php:8.1-cli | ghcr.io/optimode/php:8.1-fpm | ghcr.io/optimode/php:8.1-apache |
| 8.0 | ghcr.io/optimode/php:8.0-cli | ghcr.io/optimode/php:8.0-fpm | ghcr.io/optimode/php:8.0-apache |
| 7.4 | ghcr.io/optimode/php:7.4-cli | ghcr.io/optimode/php:7.4-fpm | ghcr.io/optimode/php:7.4-apache |
| 7.3 | ghcr.io/optimode/php:7.3-cli | ghcr.io/optimode/php:7.3-fpm | ghcr.io/optimode/php:7.3-apache |
| 7.2 | ghcr.io/optimode/php:7.2-cli | ghcr.io/optimode/php:7.2-fpm | ghcr.io/optimode/php:7.2-apache |
| 7.1 | ghcr.io/optimode/php:7.1-cli | ghcr.io/optimode/php:7.1-fpm | ghcr.io/optimode/php:7.1-apache |
| 7.0 | ghcr.io/optimode/php:7.0-cli | ghcr.io/optimode/php:7.0-fpm | ghcr.io/optimode/php:7.0-apache |
| 5.6 | ghcr.io/optimode/php:5.6-cli | ghcr.io/optimode/php:5.6-fpm | ghcr.io/optimode/php:5.6-apache |

## Docker run

```bash
$ docker run -it --rm --name php84-app optimode/php:8.4-fpm
# or
$ docker run -it --rm --name php84-app -v "$PWD":/usr/src/myapp optimode/php:8.4-fpm
```

## Docker compose
Minimal configuration: 

```yaml
services:
  php84:
    image: ghcr.io/optimode/php:8.4-fpm
    container_name: php84
    hostname: php84
    restart: unless-stopped
    #user: 1000:1000
    stdin_open: true
    tty: true
```

## Configuration
Since the official php images are in the background, the setup methodology is the same. Basically, the images can be used without configuration.

The cli is accessible simply with the php command, the fpm starts a pool on tcp port 9000.

If you want to configure it yourself, the best thing to do is copy the entire configuration directory from the container and then mount it back from the docker host. 

The path to the configuration directory in the container: /usr/local/etc

```sh
docker pull ghcr.io/optimode/php:8.4-fpm
docker create --name php84conf optimode/php:8.4-fpm
docker cp php84conf:/usr/local/etc <your_save_path>
```

You can then modify the configuration as you wish.
You can find the php.ini file here: <your_save_path>/etc/php/conf.d/xxx-optimode-default-php.ini

To make your work easier, you can download it from here:

- [8.4 configuration files](https://raw.githubusercontent.com/optimode/php/refs/heads/main/8.4/8.4-config.zip)  
`curl https://raw.githubusercontent.com/optimode/php/refs/heads/main/8.4/8.4-config.zip`
- [8.3 configuration files](https://raw.githubusercontent.com/optimode/php/refs/heads/main/8.3/8.3-config.zip)  
`curl https://raw.githubusercontent.com/optimode/php/refs/heads/main/8.3/8.3-config.zip`
- [8.2 configuration files](https://raw.githubusercontent.com/optimode/php/refs/heads/main/8.2/8.2-config.zip)  
`curl https://raw.githubusercontent.com/optimode/php/refs/heads/main/8.2/8.2-config.zip`
- [8.1 configuration files](https://raw.githubusercontent.com/optimode/php/refs/heads/main/8.1/8.1-config.zip)  
`curl https://raw.githubusercontent.com/optimode/php/refs/heads/main/8.1/8.1-config.zip`
- [8.0 configuration files](https://raw.githubusercontent.com/optimode/php/refs/heads/main/8.0/8.0-config.zip)  
`curl https://raw.githubusercontent.com/optimode/php/refs/heads/main/8.0/8.0-config.zip`
- [7.4 configuration files](https://raw.githubusercontent.com/optimode/php/refs/heads/main/7.4/7.4-config.zip)  
`curl https://raw.githubusercontent.com/optimode/php/refs/heads/main/7.4/7.4-config.zip`
- [7.3 configuration files](https://raw.githubusercontent.com/optimode/php/refs/heads/main/7.3/7.3-config.zip)  
`curl https://raw.githubusercontent.com/optimode/php/refs/heads/main/7.3/7.3-config.zip`
- [7.2 configuration files](https://raw.githubusercontent.com/optimode/php/refs/heads/main/7.2/7.2-config.zip)  
`curl https://raw.githubusercontent.com/optimode/php/refs/heads/main/7.2/7.2-config.zip`
- [7.1 configuration files](https://raw.githubusercontent.com/optimode/php/refs/heads/main/7.1/7.1-config.zip)  
`curl https://raw.githubusercontent.com/optimode/php/refs/heads/main/7.1/7.1-config.zip`
- [7.0 configuration files](https://raw.githubusercontent.com/optimode/php/refs/heads/main/7.0/7.0-config.zip)  
`curl https://raw.githubusercontent.com/optimode/php/refs/heads/main/7.0/7.0-config.zip`
- [5.6 configuration files](https://raw.githubusercontent.com/optimode/php/refs/heads/main/5.6/5.6-config.zip)  
`curl https://raw.githubusercontent.com/optimode/php/refs/heads/main/5.6/5.6-config.zip`

## List of installed extensions

| Extension | 8.4 | 8.3 | 8.2 | 8.1 | 8.0 | 7.4 | 7.3 | 7.2 | 7.1 | 7.0 | 5.6 |
|-----------| :--: |:--: |:--: |:--: |:--: |:--: |:--: | :--: | :--: | :--: | :--: |
|amqp | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|apcu | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|bcmath | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|bz2 | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|calendar | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|Core | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|csv | :white_check_mark: | :white_check_mark: |:white_check_mark: |:white_check_mark: |:white_check_mark: |:white_check_mark: |:white_check_mark: |:x: | :x: | :x: | :x: |
|ctype | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|curl | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|date | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|dba | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|dom | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|enchant | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|exif | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|fileinfo | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|filter | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|ftp | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|gd | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|gettext | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|gmp | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|gnupg | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|grpc | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|hash | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|http | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|iconv | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|igbinary | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|imagick | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|imap | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|intl | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|json | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|libxml | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|lz4 | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|lzf | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|mbstring | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|memcache | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|memcached | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|mongodb | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|msgpack | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|mysqli | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|mysqlnd | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|OAuth | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|openssl | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|pcntl | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|pcre | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|PDO | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|pdo_dblib | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|pdo_mysql | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|pdo_pgsql | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|pdo_sqlite | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|pgsql | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|Phar | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|pkcs11 | :white_check_mark: | :white_check_mark: |:white_check_mark: |:white_check_mark: |:white_check_mark: |:white_check_mark: | :x: | :x: | :x: | :x: | :x: |
|posix | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|protobuf | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|pspell | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|psr | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|random | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|raphf | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|readline | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|redis | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|Reflection | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|session | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|shmop | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|SimpleXML | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|snmp | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|soap | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|sockets | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|sodium | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|SPL | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|sqlite3 | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|standard | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|sysvmsg | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|sysvsem | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|sysvshm | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|tidy | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|timezonedb | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|tokenizer | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|uploadprogress | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|uuid | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|xdebug | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|xhprof | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|xlswriter | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x: |
|xml | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|xmlreader | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|xmlrpc | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|xmlwriter | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|xsl | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|yaml | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|Zend OPcache | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|zip | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|zlib | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|zstd | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|Xdebug | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|Zend OPcache | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |:white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |


## Composer
[Composer](https://getcomposer.org) is installed globally in all images. 
Both version 1 and 2 are installed, available through `composer1` and `composer` commands respectively.


## Testing
As a programmer, it is obviously heresy to say that I don't need to test. But I don't program in PHP anymore and I can't devote time to testing, so I don't test optimode/php images before use.

But I'm not afraid, because what should I test on PHP extensions compiled with a program that has also been tested for an already tested PHP image? If the extension has been compiled, then the only problem that can be solved is the one that can't be solved by building.

The proof of the pudding is in the eating, so use it. This is what I do, without any problems: I set it up and use it for my clients, for years.

Regardless, there may be segments, moon positions that I haven't encountered yet, but are problematic. If you encounter such a thing, please let me know and I will solve it.

## License
optimode/php images are released under the [MIT]
