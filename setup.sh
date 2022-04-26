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

# Set up scripts for each operating system
setup_macos() {
    echo "🚧 Setting up Homebrew 🚧"
    sh scripts/setup_homebrew.sh
    echo "🚧 Setting up dotfiles 🚧"
    sh scripts/setup_dotfiles.sh
    echo "🚧 Setting up poetry 🚧"
    sh scripts/setup_poetry.sh
}

setup_linux() {
    echo "🚧 Setting up Homebrew 🚧"
    sh scripts/setup_homebrew.sh
    echo "🚧 Setting up dotfiles 🚧"
    sh scripts/setup_dotfiles.sh
    echo "🚧 Setting up poetry 🚧"
    sh scripts/setup_poetry.sh
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
