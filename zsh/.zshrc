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

# Source completions
source <(kubectl completion zsh)

# Key bindings
#bindkey "${terminfo[khome]}" beginning-of-line
#bindkey "${terminfo[kend]}" end-of-line
#bindkey "\033[1~" beginning-of-line
#bindkey "\033[4~" end-of-line
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"   delete-char

# Configure environment variables
#export GOROOT=$HOME/.go
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

export PATH="$HOME/.yarn/bin:$PATH"
