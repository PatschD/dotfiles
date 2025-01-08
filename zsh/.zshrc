# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin

export EDITOR=/opt/homebrew/bin/nvim

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export LC_ALL="en_US.UTF-8"

alias vim="nvim" 
alias zz="zellij" 
alias cd="z" 

tt () {
  ~/dotfiles/scripts/manage_tmux "$@"
}

s () {
    # The first argument to the function is stored in $1
  local input="$1"
  # Match the input against different patterns and execute SSH commands accordingly
  case "$input" in
    p*)
      # Matches any input starting with 'dev'
      echo "Connecting to the phobos server..."
      ssh -X dpatsch@10.65.250.104
      ;;
    d*)
      # Matches any input starting with 'dev'
      echo "Connecting to the deimos server..."
      ssh -X dpatsch@10.65.250.105
      ;;
    g*)
      # Matches any input starting with 'prod'
      echo "Connecting to the gaia server..."
      ssh -Y dpatsch@10.65.250.106
      ;;
    a*)
      # Matches any input starting with 'test'
      echo "Connecting to the atlas server..."
      ssh -X dpatsch@10.65.250.107
      ;;
    h*)
      # Matches any input starting with 'test'
      echo "Connecting to the hetzner server..."
      ssh -X dpatsch@95.217.108.113
      ;;
    *)
      # Default case if no pattern matches
      echo "Unknown environment. Please specify 'g', 'a', or 'p'."
      ;;
  esac
}

plugins=(git zsh-autosuggestions zsh-syntax-highlighting vi-mode)

source $ZSH/oh-my-zsh.sh
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^Y' end-of-line
VI_MODE_SET_CURSOR=true

bindkey -v
source <(fzf --zsh)
export NVM_DIR="$HOME/.nvm"

[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dapats/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dapats/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/dapats/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dapats/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dapats/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dapats/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dapats/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dapats/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
