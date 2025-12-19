#!/bin/bash
set -e

echo "🚀 Starting post-create setup..."

# 1. pnpmのセットアップ
if [ -f "package.json" ]; then
    echo "📦 Existing project detected. Installing dependencies..."
    pnpm install
else
    echo "🆕 New project detected. Initializing pnpm..."
    pnpm init
fi

# 2. Gitの初期化 (Lefthook等のために必要)
if [ ! -d ".git" ]; then
    echo "git init..."
    git init
    git branch -m main
fi

# 3. Lefthook (Git Hooks) のインストール
if [ -f "package.json" ]; then
    echo "🪝 Installing Lefthook..."う
    lefthook install || echo "⚠️ Lefthook install failed (maybe config missing?)"
fi

# 4. Hugo Modules (Go) の依存解決 (go.modがある場合)
if [ -f "go.mod" ]; then
    echo "Dependencies for Hugo Modules..."
    go mod tidy
fi

echo "✅ Post-create setup complete!"