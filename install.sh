#!/bin/sh

cwd=$(dirname "$0")
cd "$cwd"

echo "Stowing on ~/.config"

stow .


echo "Stowing uncool app configs"
(
	cd uncool;
	stow .
)

echo "Populating global linux box configs"

set -- "security/pam_env.conf" "sudoers.d/danilo"

for it in "$@"; do
	if [ -e "/etc/${it}" ]; then
		echo "/etc/${it} already exists"
	fi
	if [ $(id -u) -ne 0 ]; then
		sudo cp -i "${cwd}/etc/${it}" "/etc/${it}"
	else
		cp -i "${cwd}/etc/${it}" "/etc/${it}"
	fi
done

echo "Done."
