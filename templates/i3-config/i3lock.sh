#!/bin/sh
# https://linuxcommandlibrary.com/man/i3lock

WHITE='#ffffffff'
LOCK_COL='#77777766'
WRONG='#88000000'
RAND_IMAGE=$(find ~/.wallpapers -name "*.jpg" | shuf n1)

i3lock \
--image=$RAND_IMAGE                            \
--blur 10                                      \
\
--indicator                                    \
--radius=10                                    \
--ring-width=5                                 \
--ind-pos="x+w/15-30:y+h/15"                   \
--ring-color=$WHITE                            \
--ringver-color=$WHITE                         \
--ringwrong-color=$WRONG                       \
\
--verif-text=""                                \
--wrong-text=""                                \
--verif-color=$WHITE                           \
--verif-size=25                                \
--wrong-size=25                                \
--wrong-color=$WHITE                           \
\
--clock                                        \
--time-str="%H:%M:%S"                          \
--date-str="%A %d-%m-%Y"                       \
--time-size=40                                 \
--date-size=25                                 \
--time-font="DroidSansMono Nerd Font Mono"     \
--date-font="DroidSansMono Nerd Font Mono"     \
--time-color=$WHITE                            \
--date-color=$WHITE                            \
--time-pos="w/2:h/3"                           \
--date-pos="w/2:h/3+45"                        \
\
--beep                                         \
--ignore-empty-password                        \
\
--greeter-text=""                             \
--greeter-size=180                             \
--greeter-color=$LOCK_COL                      \
--greeteroutline-color=$WHITE                  \
--greeter-font="DroidSansMono Nerd Font Mono"  \
--greeter-pos=w/2:h/2+130
