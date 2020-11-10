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
  vlang)
    v() {
      V_DIR=~/.bash4all/modes/development/v
      if [ up = "$1" -a ! -d "$V_DIR" ]; then
        git clone https://github.com/vlang/v $V_DIR
        (cd $V_DIR && make)
        return
      fi
      $V_DIR/v $@
    }
    _v_complete() {
      local cur cmds
      COMPREPLY=()
      cur=${COMP_WORDS[COMP_CWORD]}
      opts=""
      if [ $COMP_CWORD -le 1 ]; then
        opts+=$( v help | sed -n "1,/supports the following/d;/^*/d;/for more information/q;p" | cut -c 4-16 | grep -oP '([\w-]+)\s+' )
      fi
      opts+=$(compgen -f -o plusdirs -X '!*.v' -- "${cur}")
      case "$cur" in
        *)
        COMPREPLY=( $( compgen -W '$opts' -- $cur ) );;
      esac
      return 0
    }
    complete -F _v_complete v
    ;;
  *)
    echo "Unknown ${_MODE} or not implemented"
    PS1="$_PS_MODE"
    unset _MODE _PS_MODE PS_MODE
esac
