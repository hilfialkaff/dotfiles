# Use color xterm when possible
if [ -e /lib/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

if [[ -f ~/.dir_colors ]] ; then
    eval $(dircolors -b ~/.dir_colors)
fi

# Bash completion if available
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Colored directory 
eval $(dircolors -b ~/.dircolors)

# Fun color for bash prompt
PS1='\[\e[00;33m\]\n\w \[\e[1;30m\]
\[\e[01;36m\]\u\[\e[31;1m\]@\[\e[01;36m\]\h\[\e[33;1m\]($(printf "%03d" "$?"))\[\033[00m\]:\$ '

# Use vim for everything!
export EDITOR=vim

# Enable forward searching (opposite of ctrl-r) with ctrl-s
stty -ixon

#########################################################################################
# Custom paths
#########################################################################################

# Where to look for binaries/shell commands
PATH="/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/bin/perlbin/site:/usr/bin/perlbin/vendor:/usr/bin/perlbin/core"
PATH="/home/aurum/downloads/jdk1.7.0_02/bin/:$PATH"
PATH="/home/aurum/packages/heroku-client/:$PATH"
PATH="/home/raijin/files/packages/omnetpp-4.1/bin/":$PATH
PATH="/home/raijin/files/packages/yii/framework/":$PATH
PATH="/home/raijin/files/research/crowdwatch/kernel/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin:$PATH"
PATH="/home/raijin/downloads/adt-bundle-linux-x86/sdk/platform-tools/:$PATH"

# Where to look for libraries
LD_LIBRARY_PATH="/usr/local/lib/:/usr/lib/:/usr/lib32/:/lib/"
LD_LIBRARY_PATH="/home/raijin/files/research/crowdwatch/code/ns-allinone-2.34/otcl-1.13:/home/raijin/files/research/crowdwatch/code/ns-allinone-2.34/lib:$LD_LIBRARY_PATH"
LD_LIBRARY_PATH="/home/raijin/files/packages/omnetpp-4.1/lib/:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH

# TCL library location
export TCL_LIBRARY=/usr/share/tcltk/tcl8.5

GIT_PAGER=""

# Sets the Mail Environment Variable
MAIL=/var/spool/mail/aurum && export MAIL

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
function setup_cscope () { CSCOPE_DB=`pwd`; export CSCOPE_DB; }

# Long command short cut
alias connect_wpa='sudo wpa_supplicant -i wlan0 -B -D wext -c /etc/wpa_supplicant.conf && sudo dhcpcd wlan0'
alias autolock='xautolock -time 10 -locker xlock -nowlocker xlock -detectsleep &'

# Alias for programs
alias firefox='firefox > /dev/null 2> /dev/null &'
alias skype='skype > /dev/null 2> /dev/null &'
alias lmake='make -j4 2> make.err'
alias python='python2.7'
alias diff='colordiff'
alias openflow='ssh -X openflow@192.168.56.101'

# Most accessed directories
alias cd241='cd /home/raijin/files/classes/uiuc/cs241/'
alias cd425='cd /home/raijin/files/classes/uiuc/cs425/'
alias cd538='cd /home/raijin/files/classes/uiuc/cs538/'
alias cdjelly='cd /home/raijin/files/research/jellyfish/'
alias cdcrowd='cd /home/raijin/files/research/crowdwatch/'
alias cdsdn='cd /home/raijin/files/research/sdn/'
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

#########################################################################################
# External script
#########################################################################################
source ~/.bash/svn.sh

export PERL_LOCAL_LIB_ROOT="/home/raijin/perl5";
export PERL_MB_OPT="--install_base /home/raijin/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/raijin/perl5";
export PERL5LIB="/home/raijin/perl5/lib/perl5/i686-linux-gnu-thread-multi-64int:/home/raijin/perl5/lib/perl5";
export PATH="/home/raijin/perl5/bin:$PATH";

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
