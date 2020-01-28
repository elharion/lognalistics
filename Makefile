project = lognalistics

build:
	docker image build \
  	-t $(project) \
  	.

dev: build
	docker run \
		-v $(PWD)/app:/app \
		--rm \
		-it \
		$(project) \
		/bin/bash
