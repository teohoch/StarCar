FROM ruby:latest

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

# for a JS runtime
RUN apt-get install -y nodejs
COPY id_rsa ~/.ssh/id_rsa
COPY id_rsa.pub ~/.ssh/id_rsa.pub
RUN eval $(ssh-agent -s) && ssh-add ~/.ssh/id_rsa

RUN git clone ssh://git@gitlab.hochfarber.com:10022/teohoch/StarCar.git

ENV APP_HOME /StarCar
WORKDIR $APP_HOME

RUN cd /StarCar

RUN bundle install --jobs 3 --quiet

RUN bundle update --jobs 3 --quiet

COPY docker-entrypoint.sh /usr/local/bin/
COPY database.yml /StarCar/database.yml
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]
