#!/bin/bash -e

if [ -z "$1" ]; then
  echo "You need to supply the path to an Eclipse installation"
  exit
fi

echo "Using Eclipse path: $1"

echo "Creating Eclipse.desktop file"
cat > Eclipse.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Eclipse
Comment=Eclipse IDE
Exec=$1/eclipse 
Icon=$1/icon.xpm
Categories=Application;Development;Java;IDE
Type=Application
Terminal=0
EOF

mv Eclipse.desktop $HOME/.local/share/applications/

