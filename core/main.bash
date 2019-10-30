
_determine_scm() {
    D=$(realpath "$1")
    while [[ $D != "/" ]]; do
        [ -d .bzr ] && echo bzr && return 0
        [ -d .git ] && echo git && return 0
        [ -d .hg  ] && echo  hg && return 0
        [ -d .svn ] && echo svn && return 0
        builtin cd ..
        D=$(pwd)
    done
    echo "/"
}

cd() {
  if [ "$1" ]; then
    builtin cd "$1"
  else
    builtin cd
  fi
  local _SCM
  _SCM=$(_determine_scm "$PWD")
  if [[ "${_SCM}" != "/" ]]; then
    mode scm $_SCM
  else
    [[ "${PS_MODE:0:3}" == "scm" ]] && mode
    return 0
  fi
}



# Archives
function extract {
  if [ -z "$1" ]; then
    echo "Usage: extract archive.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f "$1" ]; then
      case "$1" in
        *.tar.bz2)   tar xvjf "$1"    ;;
        *.tar.gz)    tar xvzf "$1"    ;;
        *.tar.xz)    tar xvJf "$1"    ;;
        *.lzma)      unlzma "$1"      ;;
        *.bz2)       bunzip2 "$1"     ;;
        *.rar)       unrar x -ad "$1" ;;
        *.gz)        gunzip "$1"      ;;
        *.tar)       tar xvf "$1"     ;;
        *.tbz2)      tar xvjf "$1"    ;;
        *.tgz)       tar xvzf "$1"    ;;
        *.zip)       unzip "$1"       ;;
        *.Z)         uncompress "$1"  ;;
        *.7z)        7z x "$1"        ;;
        *.xz)        unxz "$1"        ;;
        *.exe)       cabextract "$1"  ;;
        *)           echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}
