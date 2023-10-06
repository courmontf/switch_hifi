#!/bin/bash
GIT_REPOSITORY="https://github.com/courmontf/switch_hifi.git"
INSTALL_DIR="/opt/switch_hifi"
SUDO="sudo"

if ! which sudo >/dev/null; then
	SUDO=""

	if [ "$(id -u)" -ne 0 ]; then
		echo "\nInsufficient privileges:\n"
		echo "Please run this script as root."
		exit 1
	fi
fi

git clone $GIT_REPOSITORY /tmp/switch_hifi
cd /tmp/switch_hifi
cd switch_hifi
python -m venv venv
source venv/bin/activate
pip install uvicorn[standard] fastapi RPi.GPIO
$SUDO cp -r /tmp/switch_hifi/switch_hifi /opt
$SUDO cp switch_hifi.service /lib/systemd/system/switch_hifi.service
$SUDO systemctl daemon-reload
$SUDO systemctl enable switch_hifi.service
$sudo rm -r /tmp/switch_hifi
