# rails newをしたいためだけのDockerfile
# でもこれを開発用で使ってもいいのかもしれない
# src/Dockerfileは本番用なので

FROM ruby:4

ENV HISTFILE=/usr/src/.bash_history

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl default-mysql-client libjemalloc2 libvips vim && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

RUN gem install bundler
RUN gem install rails

EXPOSE 3000
# rails sでbindするIPのデフォルトを0.0.0.0に
ENV BINDING=0.0.0.0
