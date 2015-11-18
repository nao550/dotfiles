#
# Example .zshrc file for zsh 4.0
#
# .zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#

# THIS FILE IS NOT INTENDED TO BE USED AS /etc/zshrc, NOR WITHOUT EDITING
#return 0	# Remove this line after editing this file as appropriate

# 言語の設定
#export LANG=ja_JP.eucJP
export LANG=ja_JP.UTF-8

# iBusの設定
export XIM=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=xim
export XMODIFIERS=@im=ibus
export XIM_PROGRAM="ibus-daemon"
export XIM_ARGS="--daemonize --xim"


path=(/sbin /bin /usr/local/bin /usr/sbin /usr/bin /usr/games /usr/local/sbin /usr/local/bin /usr/X11R6/bin /usr/local/jdk1.1.8/bin /usr/local/pgsql/bin $HOME/bin)

# Search path for the cd command
cdpath=(.. ~ ~/src ~/zsh)

#------------
#Prompt Setup
#============
#PROMPT='%B%h%b%U%~%u`show-window` %# '
#RPROMPT='%n@$HOST'
PROMPT="%U$USER@%m%%%u"
RPROMPT="*[%~]"

precmd() { 
	TITLE=`print -P %n@$HOST \[tty%l\]: %~` 
	#TITLE=`print -P %n@$HOST on tty%l: $PWD` 
	echo -n "\e]2;$TITLE\a" 
}

show-window(){
if [ ${WINDOW} ]; then
	echo "(${WINDOW}"
fi
}

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000



# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s

umask 022

# Set up aliases
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
alias grep=egrep
alias ll='ls -l'
alias la='ls -a'

alias h=history 25
alias j=jobs -l
alias la=ls -a
alias lf=ls -FA
alias ll=ls -l
alias a2ps=2ps-j
alias man=jman
alias less=jless
#alias grep=/usr/local/bin/jgrep
#alias hd=jhd
alias cp=cp -i
alias mv=mv -i
alias cls=clear
alias pa=ps -ax
alias cdcon=cdcontrol -f /dev/acd0
#alias mycvs=cvs -d /usr/home/nao/ncvs
#alias uum=uum -Uu
alias irc=emacs -e riece
#alias mew=emacs -e mew


# List only directories and symbolic
# links that point to directories
alias lsd='ls -ld *(-/DN)'

# List only file beginning with "."
alias lsa='ls -ld .*'

# Shell functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

# Where to look for autoloaded function definitions
fpath=($fpath ~/.zfunc)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'

#manpath=(/usr/man /usr/lang/man /usr/local/man $X11HOME/man)
#export MANPATH

# Hosts to use for completion (see later zstyle)
hosts=(`hostname` ftp.math.gatech.edu prep.ai.mit.edu wuarchive.wustl.edu)

# Set prompts
#PROMPT='%m%# '    # default prompt
#RPROMPT=' %~'     # prompt for right side of screen

# Some environment variables
export MAIL=/var/spool/mail/$USERNAME
export LESS=-cex3M
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs
export EDITOR=emacs

MAILCHECK=300
HISTSIZE=200
DIRSTACKSIZE=20

# Watch for my friends
#watch=( $(<~/.friends) )       # watch for people in .friends file
watch=(notme)                   # watch for everybody but me
LOGCHECK=300                    # check every 5 min for login/logout activity
WATCHFMT='%n %a %l from %m at %t.'

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

#-------
# zsh オプション設定
#=======

#------
# 動作 
#------
# cdのタイミングで自動的にpushd
setopt auto_pushd 
# cd をしたときにlsを実行する
function chpwd() { ls }
# ディレクトリ名だけで､ディレクトリの移動をする｡
setopt auto_cd
# C-s, C-qを無効にする。
setopt no_flow_control
# プロンプトで $UID、$GID が使えるようにする
setopt prompt_subst
# Ctrl+wで､直前の/までを削除する｡
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#------
# 補完
#=====
# sudo でも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
# 補完候補が複数ある時に、一覧表示
setopt auto_list
# 保管結果をできるだけ詰める
setopt list_packed
# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完
setopt auto_menu
# aliasを補完候補に含める
setopt complete_aliases
# カッコの対応などを自動的に補完
setopt auto_param_keys
# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示しない
setopt no_list_types
# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst
# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
# ディレクトリの後でスペースを入力すると最後の / を削除
setopt auto_remove_slash
# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
# 語の途中でもカーソル位置で補完
setopt complete_in_word
# --prefix=/usr などの = 以降も補完
setopt magic_equal_subst

#-----
# 表示
#=====
# ビープ音を鳴らさないようにする
setopt no_beep
# 8 ビット目を通すようになり、日本語のファイル名を表示可能
setopt print_eight_bit
# ディレクトリを水色にする｡
export LS_COLORS='di=01;36'
# ファイルリスト補完でもlsと同様に色をつける｡
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#------
# ヒストリ 
#======
# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups
# ヒストリにhistoryコマンドを記録しない
setopt hist_no_store
# 余分なスペースを削除してヒストリに記録する
setopt hist_reduce_blanks
# 行頭がスペースで始まるコマンドラインはヒストリに記録しない
# setopt hist_ignore_spece
# 重複したヒストリは追加しない
# setopt hist_ignore_all_dups
# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify
# シェルのプロセスごとに履歴を共有
setopt share_history
# 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt append_history
# 履歴を複数端末で共有する
setopt hist_ignore_all_dups




# Autoload zsh modules when they are referenced
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile
# stat(1) is now commonly an external command, so just load zstat
zmodload -aF zsh/stat b:zstat
zmodload zsh/complist # 補完候補メニューで移動できるように




# Some nice key bindings
#bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^X^A' vi-find-prev-char-skip
#bindkey '^Xa' _expand_alias
#bindkey '^Z' accept-and-hold
#bindkey -s '\M-/' \\\\
#bindkey -s '\M-=' \|

# bindkey -v               # vi key bindings

bindkey -e                 # emacs key bindings
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -Uz compinit
compinit

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'


