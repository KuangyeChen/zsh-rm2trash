function _zsh_rm2trash_check_trash_dir() {
    if ! [[ -d ${ZSH_TRASH} ]]; then
        print "\033[1mWARN:\033[0m ${ZSH_TRASH} not exists. Create trash directory ${ZSH_TRASH}."
        mkdir -p ${ZSH_TRASH}
    fi
}

function _zsh_rm2trash_rm_to_trash() {
    _zsh_rm2trash_check_trash_dir

    local arg
    local message
    for arg in ${@}; do
        if [[ ${arg} == -* ]]; then continue; fi

        if [[ -L ${arg} ]]; then
            message="Remove softlink ${arg}."
            /bin/rm ${arg}
        else
            message="mv ${arg} to ${ZSH_TRASH} with timestamp."
            mv ${arg} ${ZSH_TRASH}/${arg##*/}_`date +%Y-%m-%d_%H-%M-%S`
        fi
  
        if [[ ${?} == 0 ]]; then
            print ${message}
        fi
    done
}

function _zsh_rm2trash_list_trash() {
    _zsh_rm2trash_check_trash_dir

    ls -ahl ${ZSH_TRASH}
}

function _zsh_rm2trash_clear_trash() {
    _zsh_rm2trash_check_trash_dir

    print "\033[91m\033[1mWARN: YOU CANNOT UNDO THIS.\033[0m\033[0m"
    print "Are you sure to delete all files in ${ZSH_TRASH}? [y/n]"

    local ans
    read ans

    if [[ ${ans} =~ ^[Yy]{1}$ ]]; then
        print "Permanently deleting all files in ${ZSH_TRASH}."
        /bin/rm -vrf ${ZSH_TRASH}/* || true; /bin/rm -vrf ${ZSH_TRASH}/.* || true 
    else
        print "Do nothing."
    fi
} 

function _zsh_rm2trash_cd_to_trash() {
    _zsh_rm2trash_check_trash_dir

    cd ${ZSH_TRASH}
}

export ZSH_TRASH=${HOME}/.Trash

alias rm='_zsh_rm2trash_rm_to_trash'
alias rm2trash='_zsh_rm2trash_rm_to_trash'
alias lstrash='_zsh_rm2trash_list_trash'
alias cleartrash='_zsh_rm2trash_clear_trash'
alias cdtrash='_zsh_rm2trash_cd_to_trash'
