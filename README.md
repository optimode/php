# PHP Docker Images
## It is currently still a very rudimentary project, barely tested. 

## !!! Use at your own risk !!!

Docker images built on top of the [official PHP images](https://hub.docker.com/r/_/php/) with the addition of some common and useful extensions, installed with [mlocati/docker-php-extension-installer](https://github.com/mlocati/docker-php-extension-installer). 

The images are based on the current official php image. php-cli is built on, and apache and fpm are based on the cli. 
All available modules are installed in the cli, and fpm and apache add their own features.

## Available versions

- 8.4 [documentation](8.4/README.md)
- 8.3 [documentation](8.3/README.md)
- 8.2 [documentation](8.2/README.md)
- 8.1 [documentation](8.1/README.md)
- 8.0 [documentation](8.0/README.md)

## Installation
Install from the command line:

```bash
$ docker pull ghcr.io/optimode/php:TAG
```

Tags can be: VERSION-PHP_SAPI
where VERSION is the php version number and PHP_SAPI is the php mode. PHP_SAPI values can be: CLI, FPM, APACHE

Example: 8.4-cli, 8.4-fpm, 8.4-apache, 8.1-cli, 8.1-fpm, 8.1-apache,

You can find the specific installation image name in the documentation for the specific version.


## Composer
[Composer](https://getcomposer.org) is installed globally in all images. 
Both version 1 and 2 are installed, available through `composer1` and `composer` commands respectively.

## License
Docker PHP Images is released under the [MIT]
