# PHP Docker Images
## It is currently still a very rudimentary project.

Docker images built on top of the [official PHP images](https://hub.docker.com/r/_/php/) with the addition of some common and useful extensions, installed with [mlocati/docker-php-extension-installer](https://github.com/mlocati/docker-php-extension-installer). 

The images are based on the current official php image. php-cli is built on, and apache and fpm are based on the cli. 
All available modules are installed in the cli, and fpm and apache add their own features.

## Available versions

- 8.4 [Documentation](8.4/README.md)

## Composer
[Composer](https://getcomposer.org) is installed globally in all images. 
Both version 1 and 2 are installed, available through `composer1` and `composer2` commands respectively (`composer` in now a symlink to `composer2`).

## License

Docker PHP Images is released under the [MIT]
