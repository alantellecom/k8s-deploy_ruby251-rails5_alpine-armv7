FROM ruby:2.5.1-alpine

ENV RAILS_ENV production
ENV SECRET_KEY_BASE 123456789 

# Install important dependencies
RUN apk add build-base nodejs yarn tzdata sqlite-dev postgresql-client postgresql-dev imagemagick zlib-dev --no-cache bash

RUN gem install bundler
RUN gem install rails -v '5.2.3'

RUN mkdir -p /myapp
RUN chmod -R 777 /myapp
WORKDIR /myapp

COPY Gemfile* /myapp/

RUN bundle install

COPY . /myapp/

RUN chmod -R 777 /myapp

RUN bin/rails assets:precompile

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
