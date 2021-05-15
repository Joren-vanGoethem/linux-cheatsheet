# Prompt:
# %F => Color codes
# %f => Reset color
# %~ => Current path
# %m => hostname
# %M => full hostname
# %m => username
# %(x.true.false) => Specifies a ternary expression
#   ! => True if the shell is running with root privileges
#   ? => True if the exit status of the last command was success
#
# Git:
# %a => Current action (rebase/merge)
# %b => Current branch
# %c => Staged changes
# %u => Unstaged changes
#
# Terminal:
# \n => Newline/Line Feed (LF)

setopt PROMPT_SUBST

autoload -U add-zsh-hook
autoload -Uz vcs_info

# Use True color (24-bit) if available.
if [[ "${terminfo[colors]}" -ge 256 ]]; then
    turquoise="%F{75}"
    orange="%F{202}"
    red="%F{196}"
    limegreen="%F{83}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    red="%F{red}"
    limegreen="%F{green}"
fi

# Reset color.
reset_color="%f"

# VCS style formats.
FMT_UNSTAGED="%{$reset_color%} %{$orange%}●"
FMT_STAGED="%{$reset_color%} %{$limegreen%}✚"
FMT_ACTION="(%{$limegreen%}%a%{$reset_color%})"
FMT_VCS_STATUS="on %{$turquoise%} %b%u%c%{$reset_color%}"

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr    "${FMT_UNSTAGED}"
zstyle ':vcs_info:*' stagedstr      "${FMT_STAGED}"
zstyle ':vcs_info:*' actionformats  "${FMT_VCS_STATUS} ${FMT_ACTION}"
zstyle ':vcs_info:*' formats        "${FMT_VCS_STATUS}"
zstyle ':vcs_info:*' nvcsformats    ""
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

# Check for untracked files.
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
            git status --porcelain | grep --max-count=1 '^??' &> /dev/null; then
        hook_com[staged]+="%{$reset_color%} %{$red%}●"
    fi
}

# Executed before each prompt.
add-zsh-hook precmd vcs_info

# prompt style WITH hostname
# PROMPT=$'\n%{$red%}%n @ %m %{$limegreen%}%~%{$reset_color%} ${vcs_info_msg_0_}\n%(?.%{%F{white}%}.%{$red%})%(!.#.❯)%{$reset_color%} '
# prompt style WITHout hostname
PROMPT=$'\n%{$red%}%n %{$limegreen%}%~%{$reset_color%} ${vcs_info_msg_0_}\n%(?.%{$limegreen%}.%{$red%})❯%{$reset_color%} '

# to enable for root, execute following commands (NOT as root)
# sudo ln -s $HOME/.zshrc /root/.zshrc
# sudo ln -s $HOME/.zshrc /root/.oh-my-zsh
# now set ZSH_DISABLE_COMPFIX="true" in ~/.zshrc

# for separate root zsh config use if statement below
# if [[ $EUID == 0 ]]; then
#     PROMPT=$'\n%{$red%}%n %{$limegreen%}%~%{$reset_color%} ${vcs_info_msg_0_}\n%(?.%{$limegreen%}.%{$red%})❯%{$reset_color%} '
# else
#     PROMPT=$'\n%{$red%}%n %{$limegreen%}%~%{$reset_color%} ${vcs_info_msg_0_}\n%(?.%{$limegreen%}.%{$red%})❯%{$reset_color%} '
# fi
