image_name := pokytos-builder
UID := $(shell id -u)
GID := $(shell id -g)

.PHONY: build run bitbake

build:
	docker build \
		--build-arg UNAME=$(USER) \
		--build-arg UID=$(UID) \
		--build-arg GID=$(GID) \
		-t $(image_name) -f ./Dockerfile .;

run:
	docker run -it --rm \
	-v $(HOST_POKYTOS_DIR):$(HOST_POKYTOS_DIR) \
	-v $(HOST_SSH_CONF_DIR):$(HOST_SSH_CONF_DIR) \
	-w $(HOST_POKYTOS_DIR) \
	-h $(image_name) \
	$(image_name)

bitbake:
	docker run --rm \
	-v $(HOST_POKYTOS_DIR):$(HOST_POKYTOS_DIR) \
	-w $(HOST_POKYTOS_DIR)/pokytos \
	$(image_name) \
	/bin/bash -c "source pokytos-env; bitbake $(ARGS)"

