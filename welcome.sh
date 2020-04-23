#/bin/zsh
#Roberto Enko
#welcome.sh prints a hello msg with *current date*, *shell version*, *current username*


version_zsh=$ZSH_VERSION   #when using bash shell
version_bash=$BASH_VERSION

date_today=$(date +"%d-%m-%Y")

user=$USER

echo "Hello again ${user}! Today is $date_today. Your current zsh version is $version_zsh | $version_bash"




