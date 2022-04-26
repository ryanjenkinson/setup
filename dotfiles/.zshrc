# Example aliases
alias zshconfig="pico ~/.zshrc"
alias ohmyzsh="pico ~/.oh-my-zsh"
alias c='clear'

# Git aliases
alias gi="git init"
alias gs="git status -sbu"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gp="git push"
alias gm="git merge"
alias ga="git add"
alias gaall="git add ."
alias gcm="git commit -m"
alias gpl="git pull"
alias gst="git stash"
alias gstl="git stash list"
alias gstp="git stash pop"
alias glg='git log --graph --oneline --decorate --all'
gclonecd() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

# Docker aliases
alias dpsa="docker ps -a"
alias dcup="docker-compose up"
alias dcupd="docker-compose up -d"

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

# Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# We use poetry for virtualenv, so add it to the path
PATH="$HOME/.poetry/bin:$PATH"

# Direnv for autoenv hooks
eval "$(direnv hook zsh)"

# Add Visual Studio Code (code) for code editing
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

# Starship prompt
eval "$(starship init zsh)"
