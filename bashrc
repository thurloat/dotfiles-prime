# .bashrc

# -----------------------------------------------------------------------------
# Environment
# -----------------------------------------------------------------------------
export EDITOR='vim.gnome'
export PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"
export PATH="$HOME/dotfiles/bin:$PATH"

# -----------------------------------------------------------------------------
# virtualenv
# -----------------------------------------------------------------------------
export WORKON_HOME=~/.virtualenvs

# -----------------------------------------------------------------------------
# Shortcuts
# -----------------------------------------------------------------------------
alias ls='ls -h --color=auto'
alias l='ls'
alias c='echo "Use Ctrl-L"' # haha!
alias du='du -sh'
alias fn='find . -name'
alias sb='source ~/.bashrc'
alias f='fab'
alias envs='cd ~/.virtualenvs'
alias vim='vim.gnome'

# Recursive sed
# alias s="find . -path './.git' -prune -o -type f -print0 | xargs -0 sed -i ''"
alias s="find . -name '.git' -prune -o -type f -print0 | xargs -0 sed -i ''"
alias e='tar xzvf'

alias display_work="xrandr -s 1920x1080"
alias display_laptop="xrandr -s 1680x1050" 
alias display_small="xrandr -s 1280x960" 

function prettyjson() {
    python -mjson.tool
}

alias goawayswapfilesyouareswapfilesidontevenneedyou='rm ~/.vim/tmp/swap/*'

# -----------------------------------------------------------------------------
# Dealing with OpenStack 
# -----------------------------------------------------------------------------
alias Tl='testrepository_list_tests'
alias Tr='testrepository_run_tests'

function testrepository_list_tests() {
    # List tests, and send to temp file.
    testr list-tests $1 > /tmp/testrepository_list 
}

function testrepository_run_tests() {
    # Runs listed tests from temp file.
    python -m testtools.run discover --load-list /tmp/testrepository_list 
}

# -----------------------------------------------------------------------------
# Git
# -----------------------------------------------------------------------------
alias gitl='git log --pretty=format:"%h - %an, %ar : %s"'
alias gits='clear; git status'
alias gitchart="git shortlog --numbered --summary"
alias gitg='git log --oneline --graph'
alias gall='git submodule foreach git '

# -----------------------------------------------------------------------------
# Python & Django
# -----------------------------------------------------------------------------
alias rmpyc='find . -name "*.pyc" -exec rm {} \;'
alias m='python manage.py'

# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------

export CLICOLOR=1

# Prompt stuff
export VIRTUAL_ENV_DISABLE_PROMPT=1
function ve () {
    if [ -z "$VIRTUAL_ENV" ]; then
        echo ''
        return
    fi

    x=`basename $VIRTUAL_ENV`
    echo "$x"

}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1]/"
}

export PS1="[\$(ve)] \w \$(parse_git_branch) $ "

# -----------------------------------------------------------------------------
# Other
# -----------------------------------------------------------------------------

# Stop telling me I have new mail
unset MAILCHECK

export SHELL=/bin/bash
export GREP_OPTIONS='--color=auto'

# -----------------------------------------------------------------------------
# Project specific, if available
# -----------------------------------------------------------------------------

if [[ -s $HOME/.bashrc_local ]] ; then source $HOME/.bashrc_local ; fi
