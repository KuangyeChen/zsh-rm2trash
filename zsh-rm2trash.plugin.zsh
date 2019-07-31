function _check_trash_dir() {
  if ! [[ -d ${ZSH_RM2TRASH_TRASH_DIR} ]]; then
    echo -e "\033[1mWARN:\033[0m ${ZSH_RM2TRASH_TRASH_DIR} not exists. Create trash directory ${ZSH_RM2TRASH_TRASH_DIR}."
    mkdir -p ${ZSH_RM2TRASH_TRASH_DIR}
  fi
}

function _rm_to_trash() {
  _check_trash_dir

  for arg in ${@}; do
    if [[ ${arg} == -* ]]; then continue; fi
    
    if [[ -L ${arg} ]]; then
      message="Remove softlink ${arg}."
      /bin/rm ${arg}
    else
      message="mv ${arg} to ${ZSH_RM2TRASH_TRASH_DIR} with timestamp."
      mv ${arg} ${ZSH_RM2TRASH_TRASH_DIR}/${arg##*/}_`date +%Y-%m-%d_%H-%M-%S`
    fi
  
    if [[ ${?} == 0 ]]; then
      echo -e ${message}
    fi
  done
}

function _list_trash() {
  _check_trash_dir

  ls -ahl ${ZSH_RM2TRASH_TRASH_DIR}
}

function _clear_trash() {
  _check_trash_dir

  echo -e "\033[91m\033[1mWARN: YOU CANNOT UNDO THIS.\033[0m\033[0m"
  echo -e "Are you sure to delete all files in ${ZSH_RM2TRASH_TRASH_DIR}? [y/n]"

  read ans

  if [[ ${ans} =~ ^[Yy]{1}$ ]]; then
    echo -e "Permanently deleting all files in ${ZSH_RM2TRASH_TRASH_DIR}."
    /bin/rm -vrf ${ZSH_RM2TRASH_TRASH_DIR}/*
  else
    echo -e "Do nothing."
  fi
} 

function _cd_to_trash() {
  _check_trash_dir

  cd ${ZSH_RM2TRASH_TRASH_DIR}
}

export ZSH_RM2TRASH_TRASH_DIR=${HOME}/.Trash

alias rm='_rm_to_trash'
alias rm2trash='_rm_to_trash'
alias lstrash='_list_trash'
alias cleartrash='_clear_trash'
alias cdtrash='_cd_to_trash'
