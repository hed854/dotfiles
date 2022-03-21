# directory options
eval "`dircolors`"

# keyboard
setxkbmap fr

# Fancy colors
GREEN="\[\033[0;32m\]"
RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
CYAN="\[\033[0;36m\]"
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

function parse_terraform_workspace()
{
	if [ -d .terraform ]; then
		workspace=$(terraform workspace show 2>/dev/null)
		if [[ $workspace == "prod"* ]] || [[ $workspace == "PROD"* ]]; then
			echo -n "${RED}(TF:${workspace})${RESET}"
		elif [[ $workspace == "test"* ]] || [[ $workspace == "test"* ]]; then
			echo -n "${CYAN}(TF:${workspace})${RESET}"
		else
			echo -n "${GRAY}(TF:${workspace})${GRAY}"
		fi
	fi
}

function set_prompt()
{
	PS1="${GREEN}[\u@\h:\W]${RESET}$(parse_git_branch)$(parse_terraform_workspace)${GREEN}\$${RESET} "
}

PROMPT_COMMAND=set_prompt

# always source the dotfiles bash_aliases
source ~/.bash_aliases

# add specific aliases for docker based utilities
if [ -f ~/.bash_aliases_docker ]; then
	source ~/.bash_aliases_docker
fi

# add specific aliases for work
if [ -f ~/.bash_aliases_work ]; then
	source ~/.bash_aliases_work
fi
