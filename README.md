# Misleading name

This is closer to a portable user base than just a "dotfiles" folder. Not much here yet but we'll get there.

### Instructions (to self):

#### 1. Create a file named 'dot-shell.id' with the following secrets (plain key-values, no quoting):
```shell
# dot-shell.id
PSQL_STAGE_USERNAME=
PSQL_STAGE_PASSWORD=
PSQL_STAGE_HOST=
PSQL_STAGE_DB=
PSQL_PREPROD_USERNAME=
PSQL_PREPROD_PASSWORD=
PSQL_PREPROD_HOST=
PSQL_PREPROD_DB=
PSQL_PROD_USERNAME=
PSQL_PROD_PASSWORD=
PSQL_PROD_HOST=
PSQL_PROD_DB=
GIT_AUTHOR_FNAME=
GIT_AUTHOR_LNAME=
GIT_AUTHOR_EMAIL=
```
#### 2. Run ./install.sh
