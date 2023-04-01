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

registry:
	minikube addons enable registry && kubectl port-forward -n kube-system service/registry 5000:80 &
	docker-compose build prod
	docker tag fastapi_k8s_app_prod localhost:5000/fastapi_k8s_app_prod
	docker push localhost:5000/fastapi_k8s_app_prod