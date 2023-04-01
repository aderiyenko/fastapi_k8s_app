#!/usr/bin/make

SHELL = /bin/sh

MY_UID := $(shell id -u)
MY_GID := $(shell id -g)

export MY_UID
export MY_GID

test:
	docker-compose run --rm test

run:
	docker-compose up -d dev

stop:
	docker-compose down