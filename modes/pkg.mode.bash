# A-Z Sorted.
unalias I i U u S 2>/dev/null

if [[ ${BASED} == 'ARCH' ]]; then
alias I='pacman -Syu'
fi

if [[ ${BASED} == 'BEOS' ]]; then
alias I='pkgman install -y'
fi

if [[ ${BASED} == 'BSD' ]]; then
alias I='sudo pkg install -y'
fi

if [[ ${BASED} == 'DEBIAN' ]]; then
alias I='sudo apt-get -y install'
alias i='sudo apt-get install'
alias U='sudo apt-get -y remove'
alias u='sudo apt-get remove'
alias S='service'
fi

if [[ ${BASED} == 'FEDORA' ]]; then
alias I='sudo dnf install'
fi

if [[ ${BASED} == 'MAC' ]]; then
alias I='brew install'
fi

if [[ ${BASED} == 'MAGEIA' ]]; then
alias I='urpmi --auto'
alias i='urpmi'
alias u='urpme'
alias S='service'
fi

if [[ ${BASED} == 'REDHAT' ]]; then
alias I='sudo yum install'
fi

if [[ ${BASED} == 'SUSE' ]]; then
alias I='sudo zypper install'
fi
