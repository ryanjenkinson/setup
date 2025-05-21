# Example aliases
alias zshconfig="vim ~/.zshrc"
alias c='clear'

# Git aliases
alias gbrm="git branch | grep -vE 'master|main' | xargs git branch -D"
alias grb='git rebase -i `git rev-list origin/master.. | tail -1`^'
alias gca='git commit --amend --no-edit'
alias glg='git log --graph --oneline --decorate --all'
gclonecd() {
  git clone "$1" && cd "$(basename "$1" .git)"
}
git-checkout() {
    local current_dir=$(basename "$PWD")
    local branch_suffix=$1
    local branch_name="rj/${current_dir}/${branch_suffix}"
    git checkout -b "$branch_name"
}
alias gc='git-checkout'

# Docker aliases
alias dpsa="docker ps -a"
alias dcup="docker-compose up"
alias dcupd="docker-compose up -d"

# Python project aliases
# Note: make sure have set up direnvrc with uv
alias autoenv="echo 'layout uv' > .envrc && direnv allow"

# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$_";
}
# Go up [n] directories
function up() {
    local cdir="$(pwd)"
    if [[ "${1}" == "" ]]; then
        cdir="$(dirname "${cdir}")"
    elif ! [[ "${1}" =~ ^[0-9]+$ ]]; then
        echo "Error: argument must be a number"
    elif ! [[ "${1}" -gt "0" ]]; then
        echo "Error: argument must be positive"
    else
        for i in {1..${1}}; do
            local ncdir="$(dirname "${cdir}")"
            if [[ "${cdir}" == "${ncdir}" ]]; then
                break
            else
                cdir="${ncdir}"
            fi
        done
    fi
    cd "${cdir}"
}

# Add Homebrew's executable directory to the front of the PATH
export PATH=/usr/local/bin:$PATH

# Direnv for autoenv hooks
eval "$(direnv hook zsh)"

# Add Visual Studio Code (code) for code editing
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

# Starship prompt
eval "$(starship init zsh)"

# Signing key for Github (see: https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)
export GPG_TTY=$(tty)

# Any local config
source ~/.zshrc.local

# Local binaries
export PATH=".local/bin:$PATH"

# nvm - manage multiple node versions
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# zoxide- smarter cd
eval "$(zoxide init zsh)"

fpath+=/opt/homebrew/share/zsh/site-functions
autoload -Uz compinit && compinit
