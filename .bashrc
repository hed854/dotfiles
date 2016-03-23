# directory options
export LS_OPTIONS='--color=auto'
eval "`dircolors`"

# alias
alias ll='ls $LS_OPTIONS -l'
alias svnvdiff='svn diff --diff-cmd ~/diffwrap.sh'

# Fancy colors
GREEN="\[\033[0;32m\]"
RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GRAY="\[\033[0;37m\]"

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

function set_prompt()
{
	PS1="${GREEN}[\u@\h:\W]${RESET}$(parse_git_branch)${GREEN}\$${RESET} "
}

PROMPT_COMMAND=set_prompt
