unalias gcl co st gb branch gob add commit revert pull push log 2>/dev/null
unset -f cht

if [[ -z "$1" ]]; then
  echo "Missing programming language acronim as last parameter"
  unset _MODE _PS_MODE PS_MODE
  return 1
else
_PLANG="$1"
fi
export PS_MODE="d-${_PLANG}"

# minimal cheat sheets, for config and standalone use check https://github.com/chubin/cheat.sh
cht() {
  input="$@"
  query=$(echo "$_PLANG $input" | sed 's@ *$@@; s@^ *@@; s@ @/@; s@ @+@g')
  curl -s "cht.sh"/"$query"
}

case "$_PLANG" in
  cc)
    unalias gcl gst gbra gco gcob gadd gcom gc gl gpus gpus glom ghom 2>/dev/null
    unset -f Cr
    Cr() { # compile and run, standalone file is first argument
      F="$1"
      shift
      FF="${F%.*}"
      echo Compiling "$F and running $FF"
      c++ "$F" -o "$FF" $@ && ./"$FF"
    }
    ;;
  js)
    unalias I Id 2>/dev/null
    nvm unload 2>/dev/null; unset NVM_VERSION
    export NVM_DIR=~/.bash4all/modes/development/js/nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    alias I='npm install --save'
    alias Id='npm install --save-dev'
    alias se='npm search'
    ;;
  py)
    unalias pip 2>/dev/null
    alias pip='pip3'
    ;;
  *)
    echo "Unknown ${_MODE} or not implemented"
    PS1="$_PS_MODE"
    unset _MODE _PS_MODE PS_MODE
esac
