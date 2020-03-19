FROM ruby:2.7.0
# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
# Debian Jessie mirrors were removed
RUN echo "deb http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.listRUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list

# Debian Jessie mirrors were removedRUN set -eux; \# Jessie's apt doesn't support [check-valid-until=no] so we have to use this insteadapt-get -o Acquire::Check-Valid-Until=false update;RUN apt-get install -y python-dev python-pip zip && apt-get clean
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install --jobs 4
COPY . /myapp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
