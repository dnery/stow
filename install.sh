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

echo "Doing the thingy with KeepassXC ssh keys"

kdbx="${HOME}/Sync/Secrets/Workstation.kdbx"
keys=( edge blaze deploy )

for key in "${keys[@]}"; do
	keyfile="${HOME}/.ssh/${key}.pub"
	if [[ ! -f $keyfile || ! -r $keyfile ]]; then
		keepassxc-cli show -a Notes $kdbx $key > $keyfile
		chmod 644 $keyfile
	fi
done

echo "Done."
