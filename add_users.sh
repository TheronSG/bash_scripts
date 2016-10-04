#!/bin/bash
	prefix="sudo useradd "
	while read line
	do
		count="1"
		Command=$prefix
		for i in $line
		do
			Command+=$i
			if [[ $count -eq "1" ]]
			then
				Command+=" -g "
			elif [[ $count -eq "11" ]]
			then
				grep $i /etc/group | {
				read group
				if [[ $group = "" ]]
				then
					sudo groupadd $i
				fi
				}
				Command+=" -d /"
			elif [[ $count -eq "111" ]]
			then
				Command+=" -p "
			elif [[ $count -eq "1111" ]]
			then
				count+="1"
				continue
			else
				echo "Error! Too many arguments for user '$name'."
				exit 1
			fi
			count+="1"
		done
	$Command
	done < users.txt
