#!/bin/sh

set -eo pipefail

cwd=$(dirname "$0")
cd "$cwd"

if [ $(id -u) -ne 0 ]; then :; else
	echo "Do NOT run this as root"
	exit 1
fi

read -p "Stow all to ~/.config? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	stow .
else
	echo "Skipping..."
fi

read -p "Stow uncool configs? " -n 1 -r 
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	(
		cd uncool;
		stow .
	)
else
	echo "Skipping..."
fi

read -p "Populate /etc files? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	set -- "security/pam_env.conf" "sudoers.d/danilo"
	for it in "$@"; do
		if [ -e "/etc/${it}" ]; then
			echo "/etc/${it} already exists"

			if [ ! -e "/etc/${it}.bak" ]; then
				read -p "Back up the existing ${it}? " -n 1 -r
				echo
				if [[ $REPLY =~ ^[Yy]$ ]]; then
					sudo cp "/etc/${it}" "/etc/${it}.bak"
				fi
			else
				echo "Back up already exist, will not override"
			fi

		fi
		read -p "Copy the custom config to ${it}? " -n 1 -r
		echo
 		if [[ $REPLY =~ ^[Yy]$ ]]; then
			sudo cp "${cwd}/etc/${it}" "/etc/${it}"
		fi

	done
else
	echo "Skipping..."
fi


read -p "Do the thingy with KeepassXC ssh keys? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	kdbx="${HOME}/Sync/Secrets/Workstation.kdbx"
	keys=( edge blaze deploy )

	read -p "Input your password: " -n 12 -r
	echo
	for key in "${keys[@]}"; do
		keyfile="${HOME}/.ssh/${key}.pub"
		keepassxc-cli show -a Notes $kdbx $key > $keyfile <<< "$REPLY"
		chmod 644 $keyfile
	done
else
	echo "Skipping..."
fi


echo "Done."
