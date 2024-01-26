FROM ruby:3.0.2

RUN apt-get update -qq && apt-get install -y nodejs yarn sqlite3 libsqlite3-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN bundle install --without development test

COPY . /app/

RUN bundle exec rails assets:precompile

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
