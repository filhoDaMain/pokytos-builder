image_name := pokytos-builder
UID := $(shell id -u)
GID := $(shell id -g)

.PHONY: build run

build:
	docker build \
		--build-arg UNAME=$(USER) \
		--build-arg UID=$(UID) \
		--build-arg GID=$(GID) \
		-t $(image_name) -f ./Dockerfile .;

run:
	docker run -it \
	-v $(HOST_POKYTOS_DIR):$(HOST_POKYTOS_DIR) \
	-w $(HOST_POKYTOS_DIR) \
	-h $(image_name) \
	$(image_name)
