FROM ruby:2.3
MAINTAINER Andrey Rogachevich <andrey.rogachevich@azati.com>
LABEL Description="Demo project for second technical interview at Toptal"

# Install nginx & node.js
RUN apt-get update && apt-get install -y nginx nodejs \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*

# Install gems
WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --without test development

# Prepare dir for project & copy it
RUN mkdir -p /var/www/rails
WORKDIR /var/www/rails
COPY . /var/www/rails

RUN DEVISE_SECRET=temp123 RAILS_ENV=production bundle exec rake assets:precompile db:setup

COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/rails.conf /etc/nginx/sites-enabled/rails.conf
RUN rm /etc/nginx/sites-enabled/default

CMD docker/start.sh
