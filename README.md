# Dev Setup

This repo recreates my current dev setup. You can find out about the tech I use on my website [here](https://ryan.eco/tech).

## Usage
Ensuring you are in the root folder, run
```shell
sh ./setup.sh
```

You can run specific setup scripts using `sh ./scripts/<some_script>.sh`

In general this will:
- Setup [homebrew](https://brew.sh/), our os package manager
- Copy across all of our dotfiles
- Setup [Poetry](https://github.com/python-poetry/poetry), our Python Package manager

We install `poetry>1.2.0` with the `dotenv` plugin, so it also sources any `.env` file.

To use `pyenv` you can follow the [docs](https://github.com/pyenv/pyenv) but in a nutshell:
```shell
# List packages
pyenv versions --list

# Pick the one that you want
pyenv install 3.11.1

# Use that one globally
pyenv global 3.11.1

# If you need a different version for a local project, you can after cd-ing into the project:
pyenv install 3.10.5; pyenv local 3.10.5

```

I'm a fan of [Rye](https://rye-up.com/), actively being [developed on Github](https://github.com/mitsuhiko/rye), which replaces all of the above Python management. When it is no longer experimental I will likely use that as my Python manager as it replaces `pyenv + poetry` very well.

## Signed Commits
Follow [this guide](https://github.com/microsoft/vscode/wiki/Commit-Signing) for Github Signed Commits
