# -----------------------------------------------------------------------------
# 1. Base Image & Go Lang Setup
# -----------------------------------------------------------------------------
FROM node:22-bookworm-slim

COPY --from=golang:bookworm /usr/local/go /usr/local/go
ENV PATH=$PATH:/usr/local/go/bin

# -----------------------------------------------------------------------------
# 2. System Dependencies & Hugo Setup
# -----------------------------------------------------------------------------
ARG HUGO_VERSION=0.152.2

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
       git \
       curl \
       ca-certificates \
    && ARCH=$(dpkg --print-architecture) \
    && echo "Installing Hugo ${HUGO_VERSION} for ${ARCH}..." \
    && HUGO_URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${ARCH}.deb" \
    && curl -fL -o hugo.deb ${HUGO_URL} \
    && apt-get -y install ./hugo.deb \
    && rm hugo.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------------
# 3. Setup pnpm & Node Tools
# -----------------------------------------------------------------------------
# pnpmのグローバルインストール先を設定し、PATHを通す
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

# 1. corepack enable: Node標準機能でpnpmを有効化
# 2. pnpm add -g: ツール群をインストール
RUN corepack enable \
    && pnpm add -g \
       sass-embedded \
       typescript \
       lefthook \
       @commitlint/cli \
       @commitlint/config-conventional

# -----------------------------------------------------------------------------
# 4. User Configuration
# -----------------------------------------------------------------------------
USER node
WORKDIR /workspaces/project