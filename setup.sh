confirm() {
    # call with a prompt string or use a default
    read -r -p "${1} Are you sure? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            echo "You entered No for this command. Skipping..."
            false
            ;;
    esac
}

setup_dotfiles() {
    # Move the dotfiles to the home directory
    echo "Moving dotfiles to home directory..."
    cp -r dotfiles ~
    source ~/.zshrc
}

# Set up scripts for each operating system
setup_macos() {
    # Check if we have homebrew installed, if we do then update it, else install it
    which -s brew
    if [[ $? != 0 ]] ; then
        # Install Homebrew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Add homebrew to the path
        export PATH=/usr/local/bin:$PATH
    else
        brew update
    fi
    # Checking whether or not we should run the cask script
    confirm "(Re)install apps using Homebrew?" && cd macos && brew bundle && cd ../

    # Setup the dotfiles
    setup_dotfiles
}

setup_linux() {
    setup_dotfiles
}

# The main function, which detects the operating system and runs the setup function
case "$OSTYPE" in
  solaris*) echo "Detected Operating System: SOLARIS. No setup defined." ;;
  darwin*)  echo "Detected Operating System: MacOS. Running setup..." && setup_macos ;; 
  linux*)   echo "Detected Operating System: Linux. Running setup..." && setup_linux ;;
  bsd*)     echo "Detected Operating System: BSD. No setup defined." ;;
  msys*)    echo "Detected Operating System: Windows. No setup defined." ;;
  *)        echo "Could not detect Operating System: $OSTYPE. No setup defined." ;;
esac

echo "Setup script completed! ✨"
