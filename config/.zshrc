export ZSH="$HOME/.oh-my-zsh"

# THEME
ZSH_THEME="robbyrussell"

zstyle ':omz:update' frequency 7

plugins=(git)

source $ZSH/oh-my-zsh.sh

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ------------ALIASES------------ #|
alias gpl='git pull'              #|
alias gc='git checkout'           #|
alias gcs='git checkout staging'  #|
alias gcst='git checkout stable'  #|
alias gcb='git checkout -b'       #|
alias gcm='git commit -m'         #|
alias gaa='git add .'             #|
alias gml='git merge -'           #|
alias gstm='git stash -u -m'      #|
alias gsp='git stash -pop'        #|
alias gsl='git stash list'        #|
#---------------------------------#|
alias pi='pnpm install'           #|
alias ptb='pnpm tsc --build'      #|
alias pdev='pnpm run dev'         #|
# --------------END---------------#|

