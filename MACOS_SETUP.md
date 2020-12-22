# MacOS Dev Setup

In this readme we will be recreating a Python Dec environment in MacOS.

The following resources are useful:
- https://medium.com/@cjolowicz/hypermodern-python-d44485d9d769

## Homebrew
We will use Homebrew as our package installer. See the [docs](https://brew.sh/) for more info. To install, go to terminal and run:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

It is handy to install things like:
```bash
brew install wget
```

## Zsh Shell
Zsh is a good shell. We can install it now we have Homebrew:
```shell
brew install zsh
```
And now we can install Oh-My-Zsh using:
```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

We need a good `~/.zshrc` file, for which you can download my preset file in `dotfiles`.
* TODO: Add preset `dotfiles`

## Python
Python packages are a nightmare, as are versions. We will use a setup involving
- [Pyenv](https://github.com/pyenv/pyenv)
- [Pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)

and we will use `direnv` to ensure we can autoenv nicely!
- [Direnv](https://direnv.net/)

We will create a nice base version of Python where we will keep our standard tools and a virtualenv for each project we do. For projects where we are doing more dev effort, we will be using a library called `poetry' (see later) but this will give us a good baseline for quick data science work!

Nowe we have `brew` we can install these easily:
```shell
brew install pyenv pyenv-virtualenv direnv
```shell
# Check if pyenv (Python) and direnv installed, add to the path
# - pyenv: https://github.com/pyenv/pyenv
# - pyenv-virtualenv: https://github.com/pyenv/pyenv-virtualenv
if [ -n "$(which pyenv)" ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi
# - direnv: https://direnv.net/
if [ -n "$(which direnv)" ]; then
  eval "$(direnv hook $(basename $SHELL))"
fi
# Nice magic to show the virtual environment for direnv and pyenv
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
PS1='$(show_virtual_env) '$PS1
```

We need to add the following files to our `~/.config/direnv` folder
- The `direnvrc` file from here
- The file below to `envrc`

```shell
# Default python version (based on global pyenv version) and virtualenv (basename)
[ -f ".python-version" ]    && pyversion=$(head .python-version) || pyversion=$$
[ -f ".python-virtualenv" ] && pvenv=$(head  .python-virtualenv) || pvenv=$(bas$

use python ${pyversion}
# Create the virtualenv if not yet done
layout virtualenv ${pyversion} ${pvenv}
# activate it
layout activate ${pvenv}
```

I then like to alias an env setup in my `~/.zshrc` to quickly setup a python environment (`setuppenv`):
```shell
alias setuppenv='cp ~/.config/direnv/envrc .envrc'
```

This simply ensures that, unless we overrite it explicitly with a `.python-version` file, or a `.python-virtualenv` file we can just use the base version of python (defined in globals below) and create a virtualenv. We might want to overrite this explicitly to recreate a certain project or to use a "standard" data science environment or so on

I have added a datascience virtualenv so if we just want to get started on a project we can create a folder and add a `.python-virtualenv` with `datascience` (this has Numpy, Pandas, Matplotlib, Seaborn, Altair, TF2.0)

Now we have pyenv we can install the latest version of Python we like using 
```shell
pyenv install --list
```
and picking the appropriate version (I'm going to pick >3.7) then `pyenv install <version>`

It's good to stick on a global version so we don't get confused. This global version should definitely be Python 3.x:
```shell
pyenv global <version>
```

We can see which pyenv versions we have by running `pyenv versions`

NOTE: Also use `poetry`

