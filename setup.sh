#!/bin/bash

echo "🚀 Setting up Nuxt.js development environment..."

# Update npm to latest version (skip if permission error)
echo "📦 Checking npm version..."
if npm install -g npm@latest 2>/dev/null; then
    echo "npm updated successfully"
else
    echo "npm update skipped due to permissions (current version works fine)"
fi

# Install global packages safely
echo "📦 Installing global packages..."

# Check and install @nuxt/cli
if ! command -v nuxi &> /dev/null; then
    echo "Installing @nuxt/cli..."
    npm install -g @nuxt/cli
else
    echo "@nuxt/cli is already installed"
fi

# Check and install pnpm
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    npm install -g pnpm
else
    echo "pnpm is already installed"
fi

# Check and install yarn (or update if needed)
if ! command -v yarn &> /dev/null; then
    echo "Installing yarn..."
    npm install -g yarn
else
    echo "yarn is already installed, updating..."
    npm install -g yarn@latest --force
fi

# Verify installations
echo "📋 Verifying installations..."
echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"
echo "pnpm version: $(pnpm --version)"
echo "yarn version: $(yarn --version)"
echo "Nuxt CLI: $(nuxi --version)"

# Set up npm cache directory with correct permissions
mkdir -p ~/.npm
sudo chown -R devuser:devuser ~/.npm

echo "✅ Nuxt.js development environment is ready!"
echo "🎉 You can now create a new Nuxt project with: npx nuxi@latest init my-project"