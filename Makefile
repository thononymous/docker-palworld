.PHONY: build start stop

build:
	docker buildx build --build-arg=username=pal -f Dockerfile.steamcmd -t steamcmd:ubuntu2204 .
	docker buildx build --build-arg=username=pal -f Dockerfile -t palworld .

saves:
	mkdir saves

## run style 
# docker run -e UID=${UID} -e GID=${GID} --name=palworld --net=host -ti palworld

GID := $(shell id -g)
UID := $(shell id -u)

start: saves 
	echo "GID=${GID}" >.env
	echo "UID=${UID}" >>.env
	docker-compose up -d

stop:
	docker-compose down

# vim: set ts=4 sw=4 noexpandtab:
