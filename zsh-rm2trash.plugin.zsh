declare -g ZSH_RM2TRASH_TRASH_DIR

function _check_trash_dir() {
  if ! [[ -d $ZSH_RM2TRASH_TRASH_DIR ]]; then
    echo -e "\033[1mWARN:\033[0m $ZSH_RM2TRASH_TRASH_DIR not exists. Create trash directory $ZSH_RM2TRASH_TRASH_DIR."
    mkdir -p $ZSH_RM2TRASH_TRASH_DIR
  fi
}

function _rm_to_trash() {
  _check_trash_dir

  declare arg
  for arg in $@; do
    if ! [[ $arg == -* ]]; then
      mv $arg $ZSH_RM2TRASH_TRASH_DIR/${arg##*/}_`date +%Y-%m-%d_%H-%M-%S`
      if [[ $? == 0 ]]; then
        echo "mv $arg to $ZSH_RM2TRASH_TRASH_DIR with timestamp."
      fi
    fi
  done
}

function _list_trash() {
  _check_trash_dir

  ls -ahl $ZSH_RM2TRASH_TRASH_DIR 
}

function _clear_trash() {
  _check_trash_dir

  echo -e "Are you sure to delete all files in $ZSH_RM2TRASH_TRASH_DIR? [y/n]"
  echo -e "\033[91m\033[1mWARN: YOU CAN NOT UNDO THIS.\033[0m\033[0m"

  declare ans
  read ans

  if [[ $ans =~ ^[Yy]{1}$ ]]; then
    /bin/rm -vrf $ZSH_RM2TRASH_TRASH_DIR/*
  else
    echo "Do nothing."
  fi
} 

ZSH_RM2TRASH_TRASH_DIR=$HOME/.trash
alias rm='_rm_to_trash'
alias rm2trash='_rm_to_trash'
alias lstrash='_list_trash'
alias cleartrash='_clear_trash'
