# Load zplug config if available
[ -f ~/.zplugrc ] && source ~/.zplugrc

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt AUTOCD                    # CD using folder name only
setopt AUTO_MENU                 # Show completion menu on successive tab press

export HISTSIZE=11000
export SAVEHIST=10000
export HISTFILE=~/.zhistory

autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit

# Do menu-driven completion.
zstyle ':completion:*' menu select

# Color completion for some things.
# http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Case insensitivity
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

# Source additional config files
[ -f ~/.zprofile ] && source ~/.zprofile
[ -f ~/.zalias ] && source ~/.zalias
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /etc/bash_completion.d/azure-cli ] && source /etc/bash_completion.d/azure-cli

# Key bindings
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
bindkey  "^H"     backward-kill-word

# Configure environment variables
export GOROOT=/usr/lib/go
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$HOME/.local/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$PATH:$HOME/.dotnet/tools"
export FLYCTL_INSTALL="/home/mattias/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# Configure AWS
export AWS_DEFAULT_REGION=eu-west-1
export AWS_SDK_LOAD_CONFIG=true
export AWS_CBOR_DISABLE=1

# Configure gradle
export GRADLE_USER_HOME=$HOME/.gradle

# Source completions
#source /usr/local/bin/aws_completer

# Scripts
function upfind() {
  dir=`pwd`
  while [ "$dir" != "/" ]; do
    p=`find "$dir" -maxdepth 1 -name $1`
    if [ ! -z $p ]; then
      echo "$p"
      return
    fi
    dir=`dirname "$dir"`
  done
}

# Find closest Gradle wrapper
export GRADLE_DEFAULT_OPTS=''
function gw() {
  GW="$(upfind gradlew)"
  if [ -z "$GW" ]; then
    echo "Gradle wrapper not found."
  else
    dir=`dirname "$GW"`
    $GW $GRADLE_DEFAULT_OPTS --project-dir $dir $@
  fi
}

function bamboo-variables-export() {
    if [ -z $1 ]; then echo "File name is missing"; return; else echo "Using file: $1"; fi
    echo ""

    while read line; do
        name=$(echo $line | cut -f1 -d"=")
        value=$(echo $line | cut -f2 -d"=")
        variable="bamboo_pipeline_${name//./_}=$value"
        echo $variable
        export $variable
    done < $1
}


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
