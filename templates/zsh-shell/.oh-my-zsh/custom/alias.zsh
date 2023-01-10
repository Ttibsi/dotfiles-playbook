#Terminal 
alias la="ls -Alh"
alias which_term="ps -aux | grep `ps -p $$ -o ppid=`"

#Git 
alias gbl="git branch --list"
alias gss="git status -s"
alias gst="git status"
alias gau="git add -u"

alias git-branch-prune="git branch --merged main | grep -v '^[ *]*main$' | xargs git branch -d"

# Hardware 
alias bt-airpods="bluetoothctl connect 5C:52:30:E2:F8:D1"
alias bt-crushers="bluetoothctl connect 38:F3:2E:76:47:5E"

# Software
alias btm="btm --battery --dot_marker"
alias ghstat="ghstats -u ttibsi"
alias vim="nvim"
alias nivm="nvim"
