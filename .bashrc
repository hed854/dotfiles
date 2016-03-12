# directory options

export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ll='ls $LS_OPTIONS -l'

# Fancy colors
GREEN="\e[32m"
RESET="\e[39m"
RED="\e[31m"
GRAY="\e[37m"

# get current branch in git repo
function parse_git_branch() 
{
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		if [[ $STAT == "modified" ]];then
			echo -e "${RED}(${BRANCH})${RESET}"
		else
			echo -e "${GRAY}(${BRANCH})${RESET}"
		fi
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty() 
{
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${dirty}" == "0" ]; then
		echo "modified"
	else
		echo ""
	fi
}

export PS1="\[${GREEN}\][\u@\h:\W]\[${RESET}\]\[\`parse_git_branch\`\]\[${GREEN}\]\$\[${RESET}\] "
