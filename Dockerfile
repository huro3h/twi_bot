# FROM ruby:2.6.3
# ENV LANG C.UTF-8
# RUN apt-get update -qq && apt-get install -y build-essential mysql-client nodejs
# libpq-dev

# WORKDIR /tmp

# RUN mkdir /rails_app


# ADD Gemfile /rails_app/Gemfile
# ADD Gemfile.lock /rails-app/Gemfile.lock

# EXPOSE 3000
# CMD ["/bin/bash"]

# RUN bundle install

# ADD . /rails-app

