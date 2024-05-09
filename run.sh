#!/bin/zsh -l


START_TIME=$(date +"[%Y-%m-%d %H:%M:%S]")
echo ${START_TIME} start | tee /dev/stderr


source ~/.zshrc


cmd=$(pwd)/wg
osascript -e 'do shell script "wg-quick up wg0" with administrator privileges'
