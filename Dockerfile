FROM ruby:2.6.5

ENV RUBY_VERSION=2.6.5
ENV BUNDLER_VERSION=2.0.2

RUN mkdir /app
COPY ./app /app/

RUN cd /app && ls -la

RUN gem install bundler --version "$BUNDLER_VERSION"

RUN set -ex \
    && cd /app \
    && mkdir -p /var/bundle \
    && bundle install --path /var/bundle

WORKDIR /app
