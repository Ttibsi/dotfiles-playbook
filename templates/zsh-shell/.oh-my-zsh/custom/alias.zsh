#Terminal 
alias la="ls -Alh"
alias which_term="ps -aux | grep `ps -p $$ -o ppid=`"
alias vim="nvim"

#Git 
alias gbl="git branch --list"
alias gss="git status -s"
alias gst="git status"
alias gau="git add -u"
alias ga.="git add ."
alias gph="git push origin HEAD"

# Other
alias bt-airpods="bluetoothctl connect 5C:52:30:E2:F8:D1"
alias bt-crushers="bluetoothctl connect 38:F3:2E:76:47:5E"
alias btm="btm --color=nord --battery"
alias stats="ghstats -u ttibsi"
