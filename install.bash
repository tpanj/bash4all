# Install and update script
INSTALLED_FROM=https://raw.githubusercontent.com/tpanj/bash4all/master/modes/pkg.mode.bash
OS=$(uname -s)
shopt -s expand_aliases
unset _FILE_EXSISTS _PROFILE

[ -d ~/.bash4all ] && {
  echo "Alreary installed. Proceed with update? [Y/n]"
  read yn
  if [[ $yn != [Nn]* ]]; then
    cd ~/.bash4all; git pull
  fi
  exit 0
}

nyi_contribute() {
  echo "Not yet implemented for that your $1"
  echo "Have you thought to https://github.com/tpanj/bash4all/wiki/Contribute"
  exit 2
}

cmd_exists() {
  command -v "$@" >/dev/null 2>&1
}

get_install_cmd() {
  cmd_exists curl && BASED="$1" . <(curl -fsSL $INSTALLED_FROM)
  cmd_exists curl || {
    cmd_exists wget && BASED="$1" . <(wget -O- $INSTALLED_FROM)
  }
  echo "$(alias I); export BASED=$1" # export from f.
}

case $OS in
  Linux)
    DISTRIB=$(LC_ALL=C lsb_release --id | sed -n 's/^Distributor ID:\t//p')
    case "$DISTRIB" in
      Ubuntu | LinuxMint | Debian | MX)
        . <(get_install_cmd DEBIAN)
        ;;
      Arch | ManjaroLinux )
        . <(get_install_cmd ARCH)
        ;;
      CentOS | Redhat | Fedora | Scientific)
        . <(get_install_cmd REDHAT)
        ;;
      Fedora | Scientific)
        . <(get_install_cmd FEDORA)
        ;;
      Mageia | Mandriva | PCLinuxOS)
        . <(get_install_cmd MAGEIA)
        ;;
      "openSUSE project")
        . <(get_install_cmd SUSE)
        ;;
      PC)
        ;;
      *)
        nyi_contribute DISTRIBUTION
    esac
    ;;
# not linuxes
  Haiku)
    . <(get_install_cmd BEOS)
    ;;
  Darwin*)
    . <(get_install_cmd MAC)
    ;;
  FreeBSD)
    . <(get_install_cmd BSD)
    ;;
  *)
    nyi_contribute OS
esac

echo "This script will backup necessary files and install per user config"
cmd_exists git || {
  echo -n "Do you want to install needed git using \""
  echo $(alias I | sed -n 's/^alias I=.//p'|sed -n 's/.$//p' ) git\" ?
}
echo "[Y/n]"
read yn
[[ $yn != [Nn]* ]] && {
  cmd_exists git || I git
  git clone https://github.com/tpanj/bash4all ~/.bash4all
}

if [ -w ~/.bashrc ]; then
  _PROFILE=~/.bashrc; _FILE_EXSISTS="end of "
else
  _PROFILE=~/.bashrc
fi

# special cases of locations
[[ ${BASED} == 'BEOS' ]] && _PROFILE=~/config/settings/profile

[ "$_FILE_EXSISTS" ] && {
  cp $_PROFILE{,.bash4all};
  echo "Backups of existing files will be created with .bash4all extensions"
}

cat >>$_PROFILE <<EOF

# call bash4all scripts to change environment
BASED=$BASED
for i in ~/.bash4all/core/*.bash ; do
  . \$i
done
[ -f ~/.bash4allrc ] && . ~/.bash4allrc
EOF

echo "Installed call of main script to $_FILE_EXSISTS \"$_PROFILE\"."

# normalization outside repo
_lc_BASED="${BASED,,}"
[ -d ~/.bash4all/based/$_lc_BASED ] && bash ~/.bash4all/based/$_lc_BASED/index.bash

# user defined post install
[ -f ~/.bash4all_install ] && . ~/.bash4all_install
exit 0