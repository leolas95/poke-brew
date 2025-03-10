#!/bin/bash

# Script to package and install the poke CLI tool

VERSION="0.4"
PACKAGE_NAME="poke-${VERSION}.tar.gz"
USERNAME="leonardo"
TAP_NAME="poke"
TAP_DIR="$(brew --prefix)/Library/Taps/${USERNAME}/homebrew-${TAP_NAME}"

echo "Creating tarball..."
# Create tarball with the correct structure
tar -czf "${PACKAGE_NAME}" --directory=. bin/

echo "Verifying tarball contents..."
tar -tvf "${PACKAGE_NAME}"

echo "Calculating SHA256 hash..."
HASH=$(shasum -a 256 "${PACKAGE_NAME}" | cut -d ' ' -f 1)
echo "SHA256: ${HASH}"

echo "Updating formula with new hash..."
# Create a temporary file with the updated formula
cat > Formula/poke.rb << EOF
class Poke < Formula
  desc "A simple CLI poke tool"
  homepage ""
  version "${VERSION}"
  
  url "file://#{ENV['HOME']}/poke/${PACKAGE_NAME}"
  sha256 "${HASH}"
  
  def install
    bin.install "poke"
  end
  
  test do
    system "poke", "version"
  end
end
EOF

echo "Creating tap directory if it doesn't exist..."
mkdir -p "${TAP_DIR}"

echo "Copying formula to tap..."
cp Formula/poke.rb "${TAP_DIR}/"

echo "Package and formula updated successfully!"
echo "You can now run: brew install ${USERNAME}/${TAP_NAME}/poke"
echo "Or if already installed: brew reinstall ${USERNAME}/${TAP_NAME}/poke" 