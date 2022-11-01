ifneq ("$(DEBUG)", "")
DEBUG=--debug
endif

PACKAGES?=--all
REPO?=frelon
REPO_URL?=ghcr.io/frelon/packages
LUET?=$(shell which luet 2> /dev/null)

.PHONY: all
all: build

.PHONY: build
build:
	# $(LUET) $(DEBUG) build --backend-args=\"--platform=linux/amd64,linux/arm64\" --backend-args=--push --image-repository $(REPO_URL) --push-final-images $(PACKAGES)
	$(LUET) $(DEBUG) build --backend-args=\"--platform=linux/arm64\" --backend-args=--load --backend-args=--no-cache --image-repository $(REPO_URL) --push-final-images $(PACKAGES)

.PHONY: publish
publish:
	$(LUET) $(DEBUG) create-repo --name $(REPO) --type=docker --force-push --from-metadata --push-images --output $(REPO_URL)
