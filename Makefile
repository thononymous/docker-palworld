.PHONY: build start stop defconfig .env

build:
	docker buildx build --build-arg=username=pal -f Dockerfile.steamcmd -t steamcmd:ubuntu2204 .
	docker buildx build --build-arg=username=pal -f Dockerfile -t palworld .

saves:
	mkdir saves

GID := $(shell id -g)
UID := $(shell id -u)

.env: 
	echo "GID=${GID}" >.env
	echo "UID=${UID}" >>.env

start: saves .env
	docker-compose up -d

defconfig: .env
	docker-compose run --rm -v ./saves:/saves palworld defconfig

stop:
	docker-compose down

# vim: set ts=4 sw=4 noexpandtab:
