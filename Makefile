project = lognalistics

build:
	docker image build -t $(project) .

dev: build
	docker run -v $(PWD)/app:/app --rm -it $(project) /bin/bash

test: build
	docker run -v $(PWD)/app:/app --rm -it $(project) bundle exec rspec spec

task: build
	docker run -v $(PWD)/app:/app --rm -it $(project) \
		/bin/bash -c 'bundle exec rake lognalistics:total_views:task && \
		bundle exec rake lognalistics:unique_views:task'


