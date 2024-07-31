export $(envsubst < $XDG_CONFIG_HOME/.shell.id | awk 'NF && !/^#/') > /dev/null
export $(envsubst < $XDG_CONFIG_HOME/.shell.env | awk 'NF && !/^#/') > /dev/null
