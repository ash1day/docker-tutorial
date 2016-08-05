# Dockerfileは
# INSTRUCTION arguments で記述する(e.g. FROM ruby:2.3.1-slim)
# instructionは大文字で書くのが普通だが、絶対ではない

# FROM ベースイメージの設定
# DockerHubにある、オフィシャルのイメージを指定すると自動で落としてきてくれるので楽
# Rubyの公式リポジトリ https://hub.docker.com/r/_/ruby/
FROM ruby:2.3.1-slim

# RUN コマンドを実行する
# 普通にコマンドを実行できるので、極論なんでもできる。
RUN apt-get update && apt-get install -y \
      git \
      libyaml-dev \
      libssl-dev \
      libreadline-dev \
      libxml2-dev \
      libxslt1-dev \
      libffi-dev \
      build-essential \
    && rm -rf /var/lib/apt/lists/*

# WORKDIR ワークディレクトリを設定
# Dockerfileの途中で変更可能
WORKDIR /app

# COPY コンテナ内へファイルをコピーする
# 今回はこのDockerfileを含むすべてのファイルをコンテナ内の/appへコピー
COPY . /app

RUN bundle install

# EXPOSE ポート開放
EXPOSE 4567

# CMD docker run時に実行されるコマンド
# 1Dockerfileにつき1つだけ指定可能
# デフォルトの動作を指定するためのものなので、docker run時のオプションで上書きできる
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
