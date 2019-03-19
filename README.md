# zsh-rm2trash
Oh-My-Zsh plugin. </br>
Write after a sad story of `rm -rf`.

## Install (with Oh-My-Zsh)
1. Clone this repository into `$ZSH_CUSTOM/plugins` (by default `~/.oh-my-zsh/custom/plugins`)

    ```sh
    git clone https://github.com/FieldMrFive/zsh-rm2trash ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-rm2trash
    ```

2. Add the plugin to the list of plugins for Oh My Zsh to load (inside `~/.zshrc`):

    ```sh
    plugins=(zsh-rm2trash)
    ```
## Usage
Trash directory set by `$ZSH_RM2TRASH_TRASH_DIR`, default to `$HOME/.trash`.

Command    | Description
---------- | -----------
rm         | alias rm to rm2trash
rm2trash   | mv files to trash
lstrash    | ls trash dir
cleartrash | clear trash dir (real rm)
