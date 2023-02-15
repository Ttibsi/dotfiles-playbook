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
alias go="go1.20"
alias vim="nvim"
alias nivm="nvim"

# Pomodoro - mac only
# https://gist.github.com/bashbunni/f6b04fc4703903a71ce9f70c58345106
alias pomo20="timer 20m && terminal-notifier -message 'Pomodoro'\
    -title 'Work Timer is up! Take a Break 😊'\
    -appIcon '~/Pictures/pumpkin.png'\
    -sound Crystal"

alias pomo30="timer 30m && terminal-notifier -message 'Pomodoro'\
    -title 'Work Timer is up! Take a Break 😊'\
    -appIcon '~/Pictures/pumpkin.png'\
    -sound Crystal"
