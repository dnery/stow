#!/bin/sh

cwd=$(dirname "$0")
cd "$cwd"

stow .

set -- "security/pam_env.conf" "sudoers.d/danilo"

for it in "$@"; do
	if [ -e "/etc/${it}" ]; then
		echo "/etc/${it} already exists, skipping"
	else
		if [ $(id -u) -ne 0 ]; then
			sudo ln -s "${cwd}/${it}" "/etc/${it}"
		else
			ln -s "${cwd}/${it}" "/etc/${it}"
		fi
	fi
done

echo "Done."
