#!/bin/bash

# Checking if docker is running, starting it if not
# pgrep docker &> /dev/null
# if [ $? != 0 ]
# then
# 	echo "Docker service stoped. Starting it..."
# 	sudo service docker start
# fi

display_settings () {
	echo "======================================"
	echo "========== Server Settings =========="
	echo "======================================"
	echo "Default site: http://localhost:80"
	echo "Static site: http://static.local/"
	echo "Dynamic site: http://php.local/"
}


if [ $# -ge 1 ] && ([[ "$1" = '-b' ]] || [[ "$1" = '-build' ]]);
then
	docker-compose --env-file $PWD/.env \
	--file $PWD/docker-compose.yml up \
	--build -d
	display_settings;
elif [ $# -ge 1 ] && [[ "$1" = 'stop' ]];
then
	docker-compose stop
elif [ $# -ge 1 ] && [[ "$1" = 'start' ]];
then
	docker-compose start
	display_settings;
elif [ $# -ge 1 ] && ([[ "$1" = 'restart' ]] || [[ "$1" = 'rs' ]]);
then
	docker-compose restart
else
	docker-compose --env-file $PWD/.env \
	--file $PWD/docker-compose.yml up -d
	display_settings;
fi

