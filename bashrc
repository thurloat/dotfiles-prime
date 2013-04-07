# -----------------------------------------------------------------------------
# Environment
# -----------------------------------------------------------------------------
export EDITOR='vim'
export PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"
export PATH="/usr/local/bin:$PATH:$HOME/.cabal/bin"
export PATH="/usr/local/Cellar/go/1.0.3/bin/:$PATH"
export PYTHONPATH="$PYTHONPATH:/usr/local/Cellar/opencv/2.3.1a/lib/python2.7/site-packages"
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

# -----------------------------------------------------------------------------
# Atlassian SDK Stuff
# -----------------------------------------------------------------------------
export PATH="$HOME/SDK/atlassian-plugin-sdk-3.8/bin:$PATH"

# -----------------------------------------------------------------------------
# virtualenv
# -----------------------------------------------------------------------------
export WORKON_HOME=~/virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
source ~/.s3_rc
# -----------------------------------------------------------------------------
# Shortcuts
# -----------------------------------------------------------------------------
alias ls='ls -h'
alias l='ls'
alias c='echo "Use Ctrl-L"' # haha!
alias du='du -sh'
alias fn='find . -name'
alias sb='source ~/.bashrc'
alias f='fab'
alias fv='fab -R vagrant'
alias envs='cd ~/virtualenvs'
alias vim='mvim -v'

# Recursive sed
# alias s="find . -path './.git' -prune -o -type f -print0 | xargs -0 sed -i ''"
alias s="find . -name '.git' -prune -o -type f -print0 | xargs -0 sed -i ''"
alias e='tar xzvf'
alias fv='fab -R vagrant'

function prettyjson() {
    python -mjson.tool
}
alias dv='dvtm -m "^f"'
alias goawayswapfilesyouareswapfilesidontevenneedyou='rm ~/.vim/tmp/swap/*'

function using_gcc() {
  env CC="/usr/bin/gcc-4.2" ARCHFLAGS="-arch x86_64" ARCHS="x86_64" $*
}

# named svn stashes.
# ex: svn_stash foo -- stashes all changes in a patch named .stash-foo
# ex2: svn_stash pop foo -- patches the foo stash back onto svn.
function svn_stash() {
if [ -z "$1" ]
then
    echo "Missing stash name argument"
else
    if [ "$1" == "pop" ]
    then
        local stashname=".stash-$2"
        patch -p0 < $stashname; rm $stashname 
    else
        svn diff > .stash-$1; svn revert -R .
    fi
fi
}

# Sync master branch with svn and push it
function sync_master {
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  changes_stashed=$(git stash)
  git checkout master
  git svn rebase
  git push --force
  git checkout $current_branch
  if [ "$changes_stashed" != "No local changes to save" ]
  then
  git stash pop
  fi
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
alias run='python manage.py runserver'
alias sync='python manage.py syncdb'
alias rrun="rm dev.db ; sync --noinput ; m migrate; m createsuperuser --user=honza --email=me@honza.ca; m runserver"
alias pipsheep='pip install -f https://s3.amazonaws.com/sheepdog-assets/feta/index.html --no-index'

# -----------------------------------------------------------------------------
# Google Apps Deployment stuff
# -----------------------------------------------------------------------------
alias gam="python ~/github/gam-2.2-python-src/gam.py"

# -----------------------------------------------------------------------------
# todo.txt
# -----------------------------------------------------------------------------
alias t='~/dotfiles/todo.txt/todo.sh'

# -----------------------------------------------------------------------------
# clitwi
# -----------------------------------------------------------------------------
alias n='python ~/.clitwi/main.py | less'

export PATH=/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/texbin

# -----------------------------------------------------------------------------
# ssh
# -----------------------------------------------------------------------------
alias sshw='mv ~/.ssh/id_* ~/.ssh/home/. ; mv ~/.ssh/known* ~/.ssh/home/. ; mv ~/.ssh/work/* ~/.ssh/. ;'
alias sshh='mv ~/.ssh/id_* ~/.ssh/work/. ; mv ~/.ssh/known* ~/.ssh/work/. ; mv ~/.ssh/home/* ~/.ssh/. ;'

# -----------------------------------------------------------------------------
# LaTex
# -----------------------------------------------------------------------------
function rn {
    # Rename file extension
    # Usage: rn txt rst
    for f in $(find . -name "*$1");
    do
        mv $f `echo $f | sed 's/txt$/rst/'`
    done;
}

# templates
function lt {
    loc=~/Dropbox/Templates/
    if [ $1 ]
    then
        if [ $1 == "simple" ]
        then
            p="$loc"simple.tex
        elif [ $1 == "letter" ]
        then
            p="$loc"letter.tex
        else
            echo "don't know this type"
        fi
        cp $p .
    else
        echo "You need an argument. Either 'simple' or 'letter'."
        return
    fi
}

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
# Notifiers
# -----------------------------------------------------------------------------
function grr() {
    $*
    growlnotify -m "'$*' finished"
}

function spp() {
    $*
    say "'$*' finished"
}

# -----------------------------------------------------------------------------
# PostgreSQL
# -----------------------------------------------------------------------------
alias startpostgres='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias stoppostgres='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# -----------------------------------------------------------------------------
# Completion
# -----------------------------------------------------------------------------
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# -----------------------------------------------------------------------------
# Other
# -----------------------------------------------------------------------------

# Stop telling me I have new mail
unset MAILCHECK

export SHELL=/bin/bash
export GREP_OPTIONS='--color=auto'

export PATH=$PATH:$HOME/.rvm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# -----------------------------------------------------------------------------
# Project specific, if available
# -----------------------------------------------------------------------------

if [[ -s $HOME/.bashrc_local ]] ; then source $HOME/.bashrc_local ; fi
