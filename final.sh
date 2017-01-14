#!/bin/bash
echo enter your username please ^_^
read username
touch 1.txt
grep -w $username mypasswd.txt > 1.txt
#grep -w $username /etc/passwd > 1.txt
if [ -s 1.txt ]; then
	#halatie k username vojud dare
	#bayad passo begire bbine doroste ya na
	touch 2.txt
	sed s/"$username"/""/g 1.txt > 2.txt
	echo enter your password!
	read password;
	if grep -w --quiet $password 1.txt; then
		echo "you are logged in";
	else
		echo "wrong password!"
		exit
	fi
else
	#halatie k bayad user pass besaze
	echo you are new!! Enter your password!
	read newpass;
	echo $username":"$newpass >> mypasswd.txt
	echo you have signed up!
fi
if [ ! -d "$username" ]; then
	mkdir $username
fi
cd $username
echo "enter your command! :)"
read cmd name;
while [ $cmd != exit ]; do
	if [ $cmd == maked ]; then
		if [ ! -d "$name" ]; then
			mkdir $name
			echo directory made
		else
			echo directory exists
		fi
	elif [ $cmd == makef ]; then
		if [ ! -e "$name" ]; then
			touch $name
			echo file $name made
		else
			echo file $name already exists
		fi
	elif [ $cmd == open ]; then
		if [ ! -e "$name" ]; then
			echo file $name doesn\'t exist
                else
                       cat $name
                fi
	elif [ $cmd == list ]; then
		for I in `ls`
		do
			echo $I;
		done
	elif [ $cmd == math ]; then
		echo enter the first operand
		read op1
		echo enter the second operand
		read op2
		echo enter the operator
		read optr
		if [ "$optr" != "+" ] && [ "$optr" != "-" ] && [ "$optr" != "*" ] && [ "$optr" != "/" ]; then
			echo wrong format for operator!
		elif [[ $op1 =~ ^-?[0-9]+$ ]] && [[ $op2 =~ ^-?[0-9]+$ ]]; then
			if [ "$optr" == "/" ] && [ "$op2" == "0" ]; then
				echo cant divide by zero!
			else
				let myvar=$op1$optr$op2
				echo $myvar
			fi
		else
			echo wrong format for inputs!
		fi
	elif [ $cmd == retrieve ]; then
		for I in `ls -R`
		do
			if [ -f "$I" ]; then
				if grep -w --quiet $name $I; then
					echo $I
				fi
			fi
		done
	elif [ $cmd == writer ]; then
		if [ ! -e "$name" ]; then
                        mkfifo $name
			echo insert the text
			read -e text
			echo $text >> $name
                        echo fifo $name made and written
                else
                        echo fifo $name already exists
                fi
	elif [ "$cmd" == "time" ]; then
		let seconds=60*$name
		for I in `seq 1 $seconds`;
		do
			echo $I
			sleep 1s;
		done
	elif [ $cmd == write ]; then
		m="";
		if [ "$name" != "" ]; then
			if [ ! -e "$name" ]; then
                	        touch $name
				while [ "$m" != "end writing" ]; do
		                        read -e m
                                        if [ $"m" != "end writing" ]; then
						echo $m >> $name
					fi
				done
        	        else
				while [ "$m" != "end writing" ]; do
					read -e m
					if [ $"m" != "end writing" ]; then
						echo $m >> $name
					fi
				done
                	fi
		else
			echo no file name!
		fi
	else
		echo wrong command
	fi
	read cmd name;
done
