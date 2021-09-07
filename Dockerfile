FROM ruby:3.0.1

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

ENV APP_ROOT /TopScoreRanking
WORKDIR $APP_ROOT
COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock
COPY package.json $APP_ROOT/package.json
COPY yarn.lock $APP_ROOT/yarn.lock
COPY . $APP_ROOT

RUN apt-get update && apt-get install -y nodejs \
	yarn \
	build-essential libpq-dev postgresql-client

RUN gem install bundler -v 2.2.16
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install

RUN chmod +x init.sql

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]


EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]