FROM node:20-bullseye

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    curl \
    wget \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 開発用ユーザーを作成
RUN groupadd -r devuser && useradd -r -g devuser -m -s /bin/bash devuser \
    && echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Node.jsの権限を設定
RUN chown -R devuser:devuser /usr/local/lib/node_modules \
    && chown -R devuser:devuser /usr/local/bin \
    && chown -R devuser:devuser /usr/local/share \
    && mkdir -p /usr/local/share/man/man{1,7} \
    && chown -R devuser:devuser /usr/local/share/man

# 作業ディレクトリを設定
WORKDIR /workspace

# ユーザーを切り替え
USER devuser

# Node.jsとnpmのバージョンを確認
RUN node --version && npm --version

# デフォルトシェルを bash に設定
SHELL ["/bin/bash", "-c"]