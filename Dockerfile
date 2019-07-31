FROM ruby:2.6.3
RUN echo "deb http://deb.debian.org/debian jessie main" > /etc/apt/sources.list && \
    apt-get update -qq && \
    apt-get install -y build-essential libmysqlclient-dev && \
    gem install bundler
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
ADD entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]