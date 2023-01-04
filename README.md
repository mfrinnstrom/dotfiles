# dotfiles
My dotfiles

## Clone repo
```
git clone git@github.com:mfrinnstrom/dotfiles.git .dotfiles
```

## Install tools
```
sudo apt update
sudo apt install zsh stow keychain
```

## Install zplug
```
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```

## Enable dotfiles
```
cd .dotfiles
stow git zsh nvim
```

## Switch to zsh
```
chsh -s /bin/zsh
```

## Install homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sudo apt-get install build-essential
brew install gcc
```

## Install brew packages
```
brew install fzf
```

## Install kubectl krew (package manager)
```
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
```

## Install kubectl plugins
```
kubectl krew install ctx
kubectl krew install ns
```
