# Install and update script
INSTALLED_FROM=https://raw.githubusercontent.com/tpanj/bash4all/master/modes/pkg.mode.bash
OS=$(uname -o)
shopt -s expand_aliases
unset _FILE_EXSISTS _PROFILE

Echo () {
  echo "=> $@"
}

[ -d ~/.bash4all ] && {
  Echo "Alreary installed. Proceed with update? [Y/n]"
  read yn
  if [[ $yn != [Nn]* ]]; then
    cd ~/.bash4all; git pull
  fi
  exit 0
}

nyi_contribute() {
  echo "Not yet implemented for $1 you have."
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
  "GNU/Linux")
    DISTRIB=$(lsb_release --id --short)
    case "$DISTRIB" in
      Ubuntu | LinuxMint | Debian | MX)
        . <(get_install_cmd DEBIAN)
        ;;
      Arch | ManjaroLinux | Garuda)
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
      "openSUSE project" | SUSE)
        . <(get_install_cmd SUSE)
        ;;
      PC)
        ;;
      *)
        nyi_contribute "$DISTRIB"
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
  # Cygwin)
  #   . <(get_install_cmd DOS)
  #   ;;
  *)
    nyi_contribute $OS
esac

Echo "This script will backup necessary files and install per user config"
cmd_exists git || {
  echo -n "Do you want to install needed git using \""
  echo $(alias I | sed -n 's/^alias I=.//p'|sed -n 's/.$//p' ) git\" ?
}
Echo "[Y/n]"
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
  Echo "Backups of existing files will be created with .bash4all extensions"
}

cat >>$_PROFILE <<EOF

# call bash4all scripts to change environment
BASED=$BASED
for i in ~/.bash4all/core/*.bash ; do
  . \$i
done
EOF

Echo "Installed call of main script to $_FILE_EXSISTS \"$_PROFILE\"."

# normalization outside repo
_lc_BASED="${BASED,,}"
[ -d ~/.bash4all/based/$_lc_BASED ] && bash ~/.bash4all/based/$_lc_BASED/index.bash

# user defined post install
[ -f ~/.bash4all_install ] && . ~/.bash4all_install
Echo "Installation complete. To start using it here now type 'bash -' or open new terminal."

exit 0
