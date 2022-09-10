# Setup in project .venv's
poetry config virtualenvs.in-project true
# In poetry 1.2.0 we have plugin support
poetry self add poetry-dotenv-plugin
