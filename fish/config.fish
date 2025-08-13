# Color Palette
set -l foreground D8D6C9
set -l selection  2A2A37
set -l comment    51516b
set -l red        CB7676
set -l orange     CC8D70
set -l yellow     CC9B70
set -l green      80A665
set -l purple     6872AB
set -l cyan       5D9AA9
set -l pink       BC76C1

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $green
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_option $pink
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected --background=$selection

# Environment Variables
set -x EDITOR nvim
set -x LLVM_PROFILE_FILE "/dev/null"
set -x BUN_INSTALL "$HOME/.bun"
set -x TERM xterm-256color

# PATH setup
fish_add_path $BUN_INSTALL/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.bun/bin
fish_add_path $HOME/.local/bin
fish_add_path /usr/local/bin
fish_add_path /opt/homebrew/bin
fish_add_path /run/current-system/sw/bin

# FZF configuration
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#1E1E1E,spinner:#C97D6E,hl:#CB7676 \
--color=fg:#D8D6C9,header:#CB7676,info:#6872AB,pointer:#C97D6E \
--color=marker:#4C8E72,fg+:#D8D6C9,prompt:#6872AB,hl+:#CB7676 \
--color=selected-bg:#232323 \
--multi"

# Key bindings
bind \eh backward-word
bind \el forward-word

# Disable greeting
set -g fish_greeting

# Initialize external tools
if type -q fzf
    if test -f ~/.config/fish/conf.d/fzf.fish
        source ~/.config/fish/conf.d/fzf.fish
    end
end

if type -q zoxide
    zoxide init fish | source
end

# BEGIN opam configuration
test -r "$HOME/.opam/opam-init/init.fish" && source "$HOME/.opam/opam-init/init.fish" ^/dev/null ^&/dev/null; or true
# END opam configuration

# Load latest installed node version on shell start
nvm use latest > /dev/null

# Functions
function gc
    git commit -m "$argv"
end

function nvs
    set session (pwd | sed 's|/|%2F|g')
    rm "$HOME/.local/share/nvim/sessions/$session.vim"
end

# Aliases
alias a="nvim"
alias q="exit"
alias ga="git add -A"
alias lz="lazygit"
alias gz="nvim +DiffviewOpen"
alias g="git"
alias j="just"
alias ls="eza --icons --group-directories-first"
alias l="eza --icons -la --no-user --no-time --no-permissions --git --group-directories-first"
alias lr="eza --icons -laR --git-ignore --git --no-user --no-time --no-permissions --group-directories-first"
alias tree="eza --icons --tree --git-ignore"
alias treea="eza --icons --tree -a"
alias cd="z"
alias f="open ."
alias rm="trash"
alias bs="brew services"
alias icat="kitten icat --align left"
alias swd="cd ~/nix-config ; make ; cd - >> /dev/null"

oh-my-posh init fish | source