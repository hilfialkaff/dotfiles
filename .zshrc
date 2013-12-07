export TERM='xterm-256color'

# Path to your oh-my-zsh configuration.
ZSH=$HOME/files/projects/dotfiles/oh-my-zsh/

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="raijin"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git-flow history-substring-search)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Colored directory
eval $(dircolors -b ~/.dircolors)

# Use vim for everything!
export EDITOR=vim

# Enable forward searching (opposite of ctrl-r) with ctrl-s
stty -ixon

#########################################################################################
# Custom paths
#########################################################################################

# Where to look for binaries/shell commands
PATH="/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/bin/perlbin/site:/usr/bin/perlbin/vendor:/usr/bin/perlbin/core"
PATH="$HOME/bin/:$PATH"
PATH="$HOME/files/packages/omnetpp-4.1/bin/":$PATH
PATH="$HOME/files/research/crowdwatch/kernel/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin:$PATH"
PATH="$HOME/downloads/adt-bundle-linux-x86/sdk/platform-tools/:$PATH"
PATH="$HOME/files/packages/scala-2.9.3/bin/:$PATH"
PATH="$HOME/files/research/tomography/repo/impl/hadoop-2.1.0-beta-src/hadoop-dist/target/hadoop-2.1.0-beta/bin:$PATH"
PATH="$HOME/files/research/tomography/repo/impl/hadoop-2.1.0-beta-src/hadoop-dist/target/hadoop-2.1.0-beta/sbin:$PATH"
PATH="$HOME/files/packages/play-2.1.1/:$PATH"
PATH="$HOME/files/packages/matlab/bin:$PATH"
PATH="$HOME/files/packages/eclipse/:$PATH"
PATH="$HOME/files/packages/gsutil:$PATH"

# Where to look for libraries
LD_LIBRARY_PATH="/usr/local/lib/:/usr/lib/:/usr/lib32/:/lib/"
LD_LIBRARY_PATH="/home/raijin/files/research/crowdwatch/code/ns-allinone-2.34/otcl-1.13:/home/raijin/files/research/crowdwatch/code/ns-allinone-2.34/lib:$LD_LIBRARY_PATH"
LD_LIBRARY_PATH="/home/raijin/files/packages/omnetpp-4.1/lib/:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
export JAVA_HOME="/usr/lib/jvm/java-1.6.0-openjdk"
export JRE_LOC="/usr/lib/jvm/java-6-openjdk-i386/jre/"
export SCALA_HOME="/home/raijin/files/packages/scala-2.9.3"

# TCL library location
export TCL_LIBRARY=/usr/share/tcltk/tcl8.5

GIT_PAGER=""

#########################################################################################
# Shortcuts
#########################################################################################

# Pretty explanatory aliases
alias ls='ls --color=auto'
alias b='cd ..; ls'
alias l='ls'
alias grep='grep --color'
alias fw='grep * -r -e'
alias ff='find . | grep'
alias vol='pavucontrol'
alias recompile='source ~/files/misc/oh-my-zsh/oh-my-zsh.sh'
function setup_cscope () { CSCOPE_DB=`pwd`; export CSCOPE_DB; }

# Long command short cut
alias connect_wpa='sudo wpa_supplicant -i wlan0 -B -D wext -c /etc/wpa_supplicant.conf && sudo dhcpcd wlan0'

# Wicd bug hack
function restart_inet() {
    sudo iwconfig wlan0 power off;
    sudo rmmod iwlwifi;
    sudo modprobe iwlwifi;
    sudo iwconfig wlan0 power on;
    sudo ifconfig wlan0 up
}
alias autolock='xautolock -time 10 -locker xlock -nowlocker xlock -detectsleep &'

# Alias for programs
alias firefox='firefox > /dev/null 2> /dev/null &'
alias spotify='spotify > /dev/null 2> /dev/null &'
alias skype='skype > /dev/null 2> /dev/null &'
alias lmake='make -j4 2> make.err'
alias mmake='make -C ../../../../ M=$PWD -j4'
alias python='python2.7'
alias diff='colordiff'
alias openflow='ssh -X openflow@192.168.56.101'
alias fvctl='fvctl --passwd-file=/home/raijin/files/research/netvirt/flowvisor/passwd'

# Most accessed directories
alias cd241='cd /home/raijin/files/classes/uiuc/cs241/'
alias cd425='cd /home/raijin/files/classes/uiuc/cs425_fa13/'
alias cd525='cd /home/raijin/files/classes/uiuc/cs525/'
alias cd598='cd /home/raijin/files/classes/uiuc/cs598_mcc/'
alias cd538='cd /home/raijin/files/classes/uiuc/cs538/'
alias cdjelly='cd /home/raijin/files/research/jellyfish/'
alias cdcrowd='cd /home/raijin/files/research/crowdwatch/'
alias cdnetvirt='cd /home/raijin/files/research/netvirt/'
alias cdtomo='cd /home/raijin/files/research/tomography/'
alias cdsri='cd /home/raijin/files/projects/sri/'

# SSH/sftp alias
alias sshmobius='ssh alkaff2@mobius.cs.illinois.edu'
alias sftpmobius='sftp alkaff2@mobius.cs.illinois.edu'
alias sshews='ssh alkaff2@linux1.ews.illinois.edu'
alias sftpews='sftp alkaff2@linux1.ews.illinois.edu'
alias sshengr='ssh alkaff2@ssh.courses.engr.illinois.edu'
alias sftpengr='sftp alkaff2@ssh.courses.engr.illinois.edu'
alias sshgrader='ssh alkaff2@siebl-0403a-07.ews.illinois.edu'
alias sftpgrader='sftp alkaff2@siebl-0403a-07.ews.illinois.edu'

alias sshtomo='ssh halkaff@client-1.tomography.uiucnet.emulab.net'
alias sftptomo='sftp halkaff@client-1.tomography.uiucnet.emulab.net'
alias sshemulab='ssh halkaff@users.emulab.net'

#########################################################################################
# External script
#########################################################################################
if [[ -f ~/.bash/svn.sh ]] ; then
  source ~/.bash/svn.sh
fi

if [[ -f ~/files/research/tomography/repo/impl/hadoop-2.1.0-beta-src/env.sh ]] ; then
  source ~/files/research/tomography/repo/impl/hadoop-2.1.0-beta-src/env.sh
fi

export PERL_LOCAL_LIB_ROOT="/home/raijin/perl5";
export PERL_MB_OPT="--install_base /home/raijin/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/raijin/perl5";
export PERL5LIB="/home/raijin/perl5/lib/perl5/i686-linux-gnu-thread-multi-64int:/home/raijin/perl5/lib/perl5";
export PATH="/home/raijin/perl5/bin:$PATH";

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# bind UP and DOWN arrow keys
for keycode in '[' '0'; do
  bindkey "^[${keycode}A" history-substring-search-up
  bindkey "^[${keycode}B" history-substring-search-down
done
unset keycode
