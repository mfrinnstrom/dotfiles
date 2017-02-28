#!/bin/bash -e
VERSION="1.8"
DOWNLOAD_FILE="go$VERSION.linux-amd64.tar.gz"

echo "About to install Go version $VERSION"

echo "Downloading $DOWNLOAD_FILE..."
curl -o /tmp/go.tar.gz https://storage.googleapis.com/golang/$DOWNLOAD_FILE
if [ $? -ne 0 ]; then
    echo "Download failed! Exiting."
    exit 1
fi

echo "File downloaded. Extracting ..."
tar -C "$HOME" -xzf /tmp/go.tar.gz
mv "$HOME/go" "$HOME/.go"
mkdir -p $HOME/Go/{src,pkg,bin}

echo "Go $VERSION installed."
rm -f /tmp/go.tar.gz
