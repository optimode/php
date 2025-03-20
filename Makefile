.ONESHELL:
ifneq (,)
.error This Makefile requires GNU Make.
endif

ifndef VERBOSE
MAKEFLAGS += --no-print-directory
endif

# -------------------------------------------------------------------------------------------------
# Make required Variables
# -------------------------------------------------------------------------------------------------
VERSION =

# -------------------------------------------------------------------------------------------------
# Make optional Variables
# -------------------------------------------------------------------------------------------------
ENABLE_CACHE ?= 1
USE_BUILDKIT ?= 1

# -------------------------------------------------------------------------------------------------
# Docker required Variables
# -------------------------------------------------------------------------------------------------
DIR        = .
FILE       = Dockerfile
ARCH	   = linux/amd64

# -------------------------------------------------------------------------------------------------
# Docker optional Variables
# -------------------------------------------------------------------------------------------------
CACHE_FLAGS   =
BUILDKIT_FLAGS =
ARGS    =
AUTHORS	= Laszlo Malina <laszlo@malina.hu>
VENDOR	= optimode
URL		= https://github.com/optimode/php
REVISION=$(shell git rev-parse --short HEAD)
BUILD_DATE=$(shell date --rfc-3339=s)
DATE=$(shell date +'%Y%m%d%H%M%S')
IMAGE = $(VENDOR)/php
VERSIONS=8.4-cli 8.4-fpm 8.4-apache

# Auto-detect current platform and use it as default to build for
_PLATFORM = $(shell uname -m)
ifeq ($(strip $(_PLATFORM)),x86_64)
	ARCH = linux/amd64
else
	ifeq ($(strip $(_PLATFORM)),arm64)
		ARCH = linux/arm64
	endif
endif


ifeq ($(ENABLE_CACHE),0)
    CACHE_FLAGS+=--no-cache
endif

BUILDKIT_FLAGS=
ifeq ($(USE_BUILDKIT),1)
    BUILDKIT_FLAGS+=--progress=plain
endif

# -------------------------------------------------------------------------------------------------
# Targets
# -------------------------------------------------------------------------------------------------
.PHONY: build
build: ## Build for a specific version. (Usage: make build VERSION=8.4-cli)

	@if [ "$(VERSION)" = "" ]; then \
		echo "This make target requires the PHP_VERSION variable to be set."; \
		echo "make build VERSION="; \
		echo "Exiting."; \
		false; \
	fi

	PHP_VERSION=$(shell echo $(VERSION) | cut -d '-' -f1)
	SAPI=$(shell echo $(VERSION) | cut -d '-' -f2)
	TAG=$$PHP_VERSION-$$SAPI
	DIR=$$PHP_VERSION/$$SAPI

	@echo "################################################################################"
	@echo "# Building $(IMAGE):$$TAG (platform: $(ARCH))"
	@echo "################################################################################"
	DOCKER_BUILDKIT=$(USE_BUILDKIT) docker build \
		$(CACHE_FLAGS) \
		$(BUILDKIT_FLAGS) \
		$(ARGS) \
		--network host \
		--platform $(ARCH) \
		--build-arg "AUTHORS=$(AUTHORS)" \
		--build-arg "VENDOR=$(VENDOR)" \
		--build-arg "URL=$(URL)" \
		--build-arg "REVISION=$(REVISION)" \
		--build-arg "BUILD_DATE=$(BUILD_DATE)" \
		--tag $(IMAGE):$$TAG \
		--tag $(IMAGE):$$TAG-$(DATE) \
		--tag $(IMAGE):$$TAG-$(REVISION) \
		--file $$DIR/$(FILE) $$DIR

$(foreach ver,$(VERSIONS),$(eval build-$(ver):; make build VERSION=$(ver) ## Build $(ver)))
#$(foreach ver,$(VERSIONS),$(eval push-$(ver):; make push VERSION=$(ver) ## Push $(ver)))
# $(foreach ver,$(VERSIONS),$(eval release-$(ver):; make build-$(ver) && make push-$(ver) ## Build and push $(ver)))


.PHONY: push
push:  ## Push the given version to the container registry
	docker push $(IMAGE_NAME)

.PHONY: help
help:  ## List all available make targets
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@$(foreach ver, $(VERSIONS), printf "  \033[36m%-20s\033[0m %s\n" "build-$(ver)" "Build $(ver)";)
#	@$(foreach ver, $(VERSIONS), printf "  \033[36m%-20s\033[0m %s\n" "push-$(ver)" "Push $(ver)";)
#	@$(foreach ver, $(VERSIONS), printf "  \033[36m%-20s\033[0m %s\n" "release-$(ver)" "Build and push $(ver)";)
	@echo ""
	@grep -E '^[a-zA-Z0-9_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Required environment variables:"
	@echo ""
	@echo "  VERSION               PHP version to build (e.g. 8.4-cli, 8.4-fpm, 8.4-apache)"
	@echo ""
	@echo " Optional environment variables:"
	@echo ""
	@echo "  ENABLE_CACHE=0        Disable cache during build (default: 1)"
	@echo "  USE_BUILDKIT=0        Disable buildkit during build (default: 1)"
	
	@echo ""
	@echo "Examples:"
	@echo "  make build VERSION=8.4-cli"
	@echo "  make build VERSION=8.4-cli ENABLE_CACHE=0 USE_BUILDKIT=0"
