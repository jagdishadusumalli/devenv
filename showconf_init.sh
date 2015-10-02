#!/bin/bash
#to initialize showconfig.sh and set a cronjob 
USER=$(whoami)
SSV_PATH="home/$USER/work/mac-dev-env"

printf '\n\n creating symlink in usr/local/bin'
sudo ln -s $SSV_PATH/showconfig.sh /usr/local/bin/showstackversion

grep -q -F 'alias showstackversion='/usr/local/bin/showstackversion'' ~/.zshrc || echo 'alias showstackversion='/usr/local/bin/showstackversion'' >> ~/.zshrc

printf '\n\n setting cron to run every week'

crontab -l | { cat; echo "* * */7 * * showstackversion > $SSV_PATH/log/showstackversion_output.log 2> $SSV_PATH/log/showstackversion_error.log"; } | crontab

printf '\n\n All Done!'