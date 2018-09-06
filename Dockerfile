FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libxml2-dev libxslt1-dev  libqtwebkit4 libqt4-dev xvfb nodejs mupdf mupdf-tools
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true
ENV APP_HOME /StarCar

WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/
COPY Gemfile.lock $APP_HOME/
#RUN bundle config --global frozen 1
RUN bundle install --without development test

COPY . $APP_HOME/

#RUN bundle install --without development test --jobs 3 && bundle update --jobs 3 --without development test

RUN bundle exec rake DATABASE_URL=postgres:does_not_exist assets:precompile


CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]
