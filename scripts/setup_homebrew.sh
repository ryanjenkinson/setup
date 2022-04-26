# Check if we have homebrew installed, if we do then update it, else install it
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

# Checking whether or not we should run the cask script
confirm "Installing apps in the brew bundle Brewfile ✨"
cd macos && brew bundle && cd ../