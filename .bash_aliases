
export LS_OPTIONS='--color=auto'
alias ll='ls $LS_OPTIONS -l'
alias ls='ls $LS_OPTIONS'
alias bat='bat -p'

function cheat() {
	curl cht.sh/$1
}

function weather() {
	curl wttr.in/$1
}

alias cheat=cheat
alias weather=weather
alias gopath='cd ${go env GOPATH}/src && tree -L 3'
