# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export LC_ALL="en_US.UTF-8"

alias vim="nvim" 
alias zz="zellij" 

tt () {
  ~/dotfiles/scripts/manage_tmux "$@"
}

plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting vi-mode)

source $ZSH/oh-my-zsh.sh
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^Y' end-of-line
VI_MODE_SET_CURSOR=true

bindkey -v
source <(fzf --zsh)


