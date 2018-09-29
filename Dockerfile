FROM stackalert/base:3
MAINTAINER stackalert "anthony@laibe.cc"

RUN mkdir /web
WORKDIR /web

ADD Gemfile /web/Gemfile
ADD Gemfile.lock /web/Gemfile.lock
RUN bundle install

ADD package.json /web/package.json
ADD yarn.lock /web/yarn.lock
RUN yarn install

ADD . /web
RUN bundle exec rake assets:precompile
