NAME=project
SHELL := /bin/bash
VERSION=0.0.1
REPO=ruanbekker/fluentd-elasticsearch
CURRENT_DATE=$(date +%F)

echo:
	echo "Building image for ${REPO}"

build:
	docker build -t ${REPO} --build-arg date=${CURRENT_DATE} .

push:
	docker push ${REPO}

#.PHONY: echo build push all
