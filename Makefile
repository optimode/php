ifneq (,)
.error This Makefile requires GNU Make.
endif

ifndef VERBOSE
MAKEFLAGS += --no-print-directory
endif


# -------------------------------------------------------------------------------------------------
# Docker required Variables
# -------------------------------------------------------------------------------------------------
IMAGE   =

# -------------------------------------------------------------------------------------------------
# Docker optional Variables
# -------------------------------------------------------------------------------------------------
NO_CACHE   =
ARGS       =
DOCKER_TAG = latest
DIR        = .
FILE       = Dockerfile


# Auto-detect current platform and use it as default to build for
_PLATFORM = $(shell uname -m)
ifeq ($(strip $(_PLATFORM)),x86_64)
	ARCH = linux/amd64
else
	ifeq ($(strip $(_PLATFORM)),arm64)
		ARCH = linux/arm64
	endif
endif

# -------------------------------------------------------------------------------------------------
# Targets
# -------------------------------------------------------------------------------------------------
.PHONY: docker-help
docker-help:
	@echo "make build-8.4              # Build all PHP 8.4 Docker images"
	@echo "make build-8.4-cli          # Build PHP 8.4 CLI Docker image"
	@echo "make build-8.4-fpm          # Build PHP 8.4 FPM Docker image"
	@echo "make build-8.4-apache       # Build PHP 8.4 Apache Docker image"
	@echo ""
	@echo "make docker-arch-build      # Build Docker image"
	@echo "    IMAGE=                  # (req) Set Docker image name"
	@echo "    DOCKER_TAG=             # (req) Set Docker image tag"
	@echo "    ARCH=                   # (opt) Specify Docker platform to build against"
	@echo "    DIR=                    # (opt) Specify directory of Docker file"
	@echo "    FILE=                   # (opt) Specify filename of Docker file"
	@echo "    ARGS=                   # (opt) Add additional docker build arguments"


.PHONY: build-8.4
build-8.4:
	$(MAKE) build-8.4-cli
	$(MAKE) build-8.4-fpm
	$(MAKE) build-8.4-apache

.PHONY: build-8.4-cli
build-8.4-cli:
	$(MAKE) docker-arch-build DIR=./8.4/cli IMAGE=optimode/php DOCKER_TAG=8.4-cli ARCH=linux/amd64

.PHONY: build-8.4-fpm
build-8.4-fpm:
	$(MAKE) docker-arch-build DIR=./8.4/fpm IMAGE=optimode/php DOCKER_TAG=8.4-fpm ARCH=linux/amd64

.PHONY: build-8.4-apache
build-8.4-apache:
	$(MAKE) docker-arch-build DIR=./8.4/apache IMAGE=optimode/php DOCKER_TAG=8.4-apache ARCH=linux/amd64

# -------------------------------------------------------------------------------------------------
# Docker Architecture targets
# -------------------------------------------------------------------------------------------------
.PHONY: docker-arch-build
docker-arch-build:
	@if [ "$(DOCKER_TAG)" = "" ]; then \
		echo "This make target requires the DOCKER_TAG variable to be set."; \
		echo "make docker-arch-build DOCKER_TAG="; \
		echo "Exiting."; \
		false; \
	fi
	@if [ "$(IMAGE)" = "" ]; then \
		echo "This make target requires the IMAGE variable to be set."; \
		echo "make docker-arch-build IMAGE="; \
		echo "Exiting."; \
		false; \
	fi
	@echo "################################################################################"
	@echo "# Building $(IMAGE):$(DOCKER_TAG) (platform: $(ARCH))"
	@echo "################################################################################"
	docker build \
		$(NO_CACHE) \
		$(ARGS) \
		$$( if [ -n "$(DOCKER_TARGET)" ]; then echo "--target $(DOCKER_TARGET)"; fi; ) \
		--network host \
		--platform $(ARCH) \
		--label "org.opencontainers.image.created"="$$(date --rfc-3339=s)" \
		--tag $(IMAGE):$(DOCKER_TAG) \
		--file $(DIR)/$(FILE) $(DIR)


.PHONY: docker-arch-rebuild
docker-arch-rebuild: NO_CACHE=--no-cache
docker-arch-rebuild: docker-arch-build
