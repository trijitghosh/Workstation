# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
source /home/trijitghosh/.config/git-prompt.sh
PS1='\[\e[32m\]\u@\h\[\e[31m\]$(__git_ps1 "(%s)")\[\e[0m\]:\$ '
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export SPARK_HOME=/home/trijitghosh/Programs/spark-3.5.0-bin-hadoop3
export CONFLUENT_HOME=/home/trijitghosh/Programs/confluent-7.6.0
export M2_HOME=/home/trijitghosh/Programs/apache-maven-3.9.6
export PATH="$PATH:$SPARK_HOME/bin:$CONFLUENT_HOME/bin:$M2_HOME/bin"
# alias to start confluent kafka
start-kafka(){
    confluent local services start
}
# alias to stop confluent kafka
stop-kafka(){
    confluent local services stop
}
source /home/trijitghosh/.client-config
clear
