mode() {
  if [[ $1 ]] && [[ ! $PS_MODE ]] && [[ -r ~/.bash4all/modes/"$1".mode.bash ]]; then 
    export _PS_MODE="$PS1"
    export _MODE="$1"
    export PS_MODE="$1"
    shift
    . ~/.bash4all/modes/"$_MODE".mode.bash "$@"
    PS1="$PS1\e[93m\${PS_MODE}\e[00m> "
  else
    # clean up mode
    if [[ $PS_MODE ]]; then
      . <(cat ~/.bash4all/modes/"$_MODE".mode.bash | grep -e unalias -e unset |grep -v PS_MODE)
      export PS1="$_PS_MODE"
      unset _MODE _PS_MODE PS_MODE
      if [[ "$1" ]]; then # switch to new one
        export _PS_MODE="$PS1"
        export _MODE="$1"
        export PS_MODE="$1"
        shift
        . ~/.bash4all/modes/"$_MODE".mode.bash "$@"
        PS1="$PS1\e[93m\${PS_MODE}\e[00m> "
      fi
    fi
  fi
}

_modes_completions()
{
  case $COMP_CWORD in
    1)
      COMPREPLY=( $(compgen -W '$(for m in $(cd ~/.bash4all/modes/; ls *.mode.bash); do echo ${m:0:-10}; done)' -- "${COMP_WORDS[COMP_CWORD]}") )
      ;;
    2)
      COMPREPLY=( $(compgen -W "$(cat ~/.bash4all/modes/${COMP_WORDS[1]}.mode.bash |grep -oE '(\w+)\)' |tr -d ')' )" -- "${COMP_WORDS[COMP_CWORD]}") )
      ;;
  esac
  return 0
}
complete -F _modes_completions mode