# zsh-rm2trash
Oh-My-Zsh plugin. </br>
Write after a sad story of `rm -rf`.

## Install (with Oh-My-Zsh)
1. Clone this repository into `$ZSH_CUSTOM/plugins` (by default `~/.oh-my-zsh/custom/plugins`)

    ```sh
    git clone https://github.com/KuangyeChen/zsh-rm2trash ${ZSH_CUSTOM}/plugins/zsh-rm2trash
    ```

2. Add the plugin to the list of plugins for Oh My Zsh to load (inside `~/.zshrc`):

    ```sh
    plugins=(zsh-rm2trash)
    ```
## Usage
Trash directory is set by `$ZSH_TRASH`, by default `$HOME/.Trash`, when in Mac OSX this is the same directory used by Finder, so the command works like dragging to Trash but without Put Back function (need to parse .DS_Store file).

Command    | Description
---------- | -----------
rm         | alias rm to rm2trash
rm2trash   | mv files to trash
lstrash    | ls trash dir
cdtrash    | cd to trash dir
cleartrash | clear trash dir (real rm)
