FROM node:20-bullseye

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    curl \
    wget \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 開発用ユーザーを作成（より確実な方法）
ARG USERNAME=devuser
ARG USER_UID=1100
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Node.jsの権限を設定
RUN mkdir -p /usr/local/share/man/man{1,7} \
    && chown -R $USERNAME:$USERNAME /usr/local/lib/node_modules \
    && chown -R $USERNAME:$USERNAME /usr/local/bin \
    && chown -R $USERNAME:$USERNAME /usr/local/share

# 作業ディレクトリを設定
WORKDIR /workspace

# ユーザーを切り替え
USER $USERNAME

# Node.jsとnpmのバージョンを確認
RUN node --version && npm --version

# デフォルトシェルを bash に設定
SHELL ["/bin/bash", "-c"]