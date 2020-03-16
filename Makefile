project = lognalistics

build:
	docker image build -t $(project) .

dev: build
	docker run -v $(PWD)/source:/app --rm -it $(project) /bin/bash

test: build
	docker run -v $(PWD)/source:/app --rm -it $(project) bundle exec rspec spec


