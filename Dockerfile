FROM alpine:3.2 

RUN apk update && \
    apk add git make libffi-dev build-base \
    ruby-irb ruby-json ruby-rake nodejs  \
    ruby ruby-dev ruby-io-console ruby-bundler
RUN gem install --no-ri --no-rdoc bundler
WORKDIR /app
RUN cd /app; git clone --branch v1.2 https://github.com/lord/slate.git
ADD Gemfile /app/slate
ADD Gemfile.lock /app/slate
RUN cd /app/slate; bundle install
ADD source/ /app/slate/source
RUN rm -rf /var/cache/apk/*
EXPOSE 4567
WORKDIR /app/slate
CMD ["bundle", "exec", "middleman", "server"]
