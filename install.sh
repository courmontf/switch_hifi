SUDO="sudo"
GIT_REPOSITORY="https://github.com/courmontf/switch_hifi.git"
INSTALL_DIR="/opt/switch_hifi"

if ! which sudo >/dev/null; then
	SUDO=""

	if [ "$(id -u)" -ne 0 ]; then
		echo "\nInsufficient privileges:\n"
		echo "Please run this script as root."
		exit 1
	fi
fi

$SUDO su
git clone $REPO $INSTALL_DIR
python -m venv $INSTALL_DIR/venv
cd $INSTALL_DIR/switch_hifi
source venv/bin/activate
pip install uvicorn[standard] fastapi RPi.GPIO
cp switch_hifi.service /lib/systemd/system/switch_hifi.service
systemctl daemon-reload
systemctl enable switch_hifi.service
