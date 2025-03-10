#!/bin/bash

# Script to package and update the poke CLI tool formula

VERSION="0.6"
PACKAGE_NAME="v${VERSION}.tar.gz"
USERNAME="leolas95"
REPO_NAME="poke-brew"
TAP_NAME="poke"
TAP_DIR="$(brew --prefix)/Library/Taps/${USERNAME}/homebrew-${TAP_NAME}"

# GitHub release URL
GITHUB_URL="https://github.com/${USERNAME}/${REPO_NAME}/archive/refs/tags/${PACKAGE_NAME}"

echo "Downloading tarball from GitHub..."
curl -L -o "${PACKAGE_NAME}" "${GITHUB_URL}"

echo "Calculating SHA256 hash..."
HASH=$(shasum -a 256 "v${VERSION}.tar.gz" | cut -d ' ' -f 1)
echo "SHA256: ${HASH}"

echo "Updating formula with new hash..."
# Create a temporary file with the updated formula
cat > Formula/poke.rb << EOF
class Poke < Formula
  desc "A simple CLI tool"
  homepage "https://github.com/${USERNAME}/${REPO_NAME}"
  url "${GITHUB_URL}"
  sha256 "${HASH}"
  
  def install
    bin.install "bin/poke"
  end
  
  test do
    system "#{bin}/poke", "version"
  end
end
EOF

echo "Creating tap directory if it doesn't exist..."
mkdir -p "${TAP_DIR}"

echo "Copying formula to tap..."
cp Formula/poke.rb "${TAP_DIR}/"

echo "Formula updated successfully!"
echo "You can now run: brew install ${USERNAME}/${TAP_NAME}/poke"
echo "Or if already installed: brew reinstall ${USERNAME}/${TAP_NAME}/poke" 