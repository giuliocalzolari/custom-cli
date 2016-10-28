#!/bin/bash
#
### BEGIN INIT INFO
# Provides:          meny shell
# Should-Start:      $named
# Default-Start:     2 3 4 5
# Default-Stop:      
# Short-Description: shell for limit user functionality
# Description:       shell for limit user functionality
#                    useradd  --shell /opt/shell/menu_basic.sh  --create-home  --home-dir /home/admin --comment "Admin User"  admin
#                    passwd admin
#					 echo "/opt/shell/menu_basic.sh" >> /etc/shells
#                    chsh -s /opt/shell/menu_basic.sh admin
### END INIT INFO



txtbld=$(tput bold)             # Bold

bldred=${txtbld}$(tput setaf 1) #  red
bldgre=${txtbld}$(tput setaf 2) #  green
bldyll=${txtbld}$(tput setaf 3) #  yellow
bldblu=${txtbld}$(tput setaf 4) #  blue
bldwht=${txtbld}$(tput setaf 7) #  white

txtrst=$(tput sgr0)             # Reset

PROD="Cloudreach"
OWNER="Cloudreach"


show_menu(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    NOW=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**            $PROD Menu              **${NORMAL}"
    echo -e "${MENU}*********** $NOW *************${NORMAL}"
    echo -e "${MENU}**${NUMBER} C)${MENU} Chef Server ${NORMAL}"
    echo -e "${MENU}**${NUMBER} K)${MENU} Key Pair ${NORMAL}"
    echo -e "${MENU}**${NUMBER} N)${MENU} Network Configuration ${NORMAL}"
    echo -e "${MENU}**${NUMBER} P)${MENU} Password change ${NORMAL}"
    echo -e "${MENU}**${NUMBER} R)${MENU} Reboot ${NORMAL}"
    echo -e "${MENU}**${RED_TEXT} x)${MENU} Exit ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter an option ${RED_TEXT}enter [x] to exit. ${NORMAL}"
    read opt
}

function option_picked() {
    COLOR="\033[31m" # bold red
    RESET="\033[m" # normal white
    MESSAGE=$(@:-"${RESET}Error: No message passed")
    echo -e "${COLOR}${MESSAGE}${RESET}"
}


function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}


function valid_ip_fqdn()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    else
       		host $ip 2>&1 > /dev/null
    		if [ $? -eq 0 ]
    		then
        		stat=0
    		else
        		stat=1
    		fi 

    fi
    return $stat
}





function valid_ip_port()
{
    local  ip=$1
    local  stat=1
    
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\:[0-9]{2,5}$ ]]; then
        return 0;
    else
        return 1;
    fi

}




show_menu_ip(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    
    NOW=$(date +"%Y-%m-%d %H:%M:%S")        
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**          $PROD Network Menu        **${NORMAL}"
    echo -e "${MENU}************* $NOW ***********${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Set DHCP ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Set Static IP ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Get Current IP ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} Set DNS ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Get DNS ${NORMAL}"
    echo -e "${MENU}**${NUMBER} P)${MENU} Ping Tool ${NORMAL}"
    echo -e "${MENU}**${NUMBER} T)${MENU} Test Network ${NORMAL}"
    echo -e "${MENU}**${RED_TEXT} x)${MENU} Return Main Menu ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter an option ${RED_TEXT}enter [x] to exit. ${NORMAL}"
    read opt
}


show_menu_key(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    
    NOW=$(date +"%Y-%m-%d %H:%M:%S")        
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**          $PROD Key Menu        **${NORMAL}"
    echo -e "${MENU}************* $NOW ***********${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} List Key ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Add Key ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Delete Key ${NORMAL}"
    echo -e "${MENU}**${RED_TEXT} x)${MENU} Return Main Menu ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter an option ${RED_TEXT}enter [x] to exit. ${NORMAL}"
    read opt
}




show_menu_chef(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    
    NOW=$(date +"%Y-%m-%d %H:%M:%S")        
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**          $PROD Chef Menu           **${NORMAL}"
    echo -e "${MENU}************* $NOW ***********${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Boot Linux Node ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Boot Windows Node ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Bulk Boot ${NORMAL}"
    echo -e "${MENU}**${NUMBER} B)${MENU} Show bulk log ${NORMAL}"
    echo -e "${MENU}**${NUMBER} L)${MENU} Node List ${NORMAL}"
    echo -e "${MENU}**${NUMBER} G)${MENU} Get Validator Certificate ${NORMAL}"
    echo -e "${MENU}**${NUMBER} A)${MENU} Get Admin Certificate ${NORMAL}"
    echo -e "${MENU}**${RED_TEXT} x)${MENU} Return Main Menu ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter an option ${RED_TEXT}enter [x] to exit. ${NORMAL}"
    read opt
}



key_config(){
clear

if [ ! -d "/opt/shell/key/" ] 
then
	mkdir /opt/shell/key/
	chmod 666 /opt/shell/key/
fi


show_menu_key
while [ 1 ]
    do

    case $opt in

        
        1) clear;
           COUNTER=0 
           if [[ $(find /opt/shell/key/ -name "*.pem" | wc -l ) -eq  0 ]]; then
           		echo "no Keys"
           else
               for f in /opt/shell/key/*.pem ;  do
      			echo "[$COUNTER] $(basename $f)"
      			COUNTER=$[$COUNTER +1]
		       done
		   echo ""
           echo ""
           fi 
           show_menu_key;
        ;;

        2) clear;
            add_key;
            show_menu_key;
            ;;
            
        3) clear;
            delete_key;
            show_menu_key;
            ;; 
          
        
            
        [xX]) clear;
            return;
            ;;                            


        *)clear;
        echo -e  "Pick an option from the menu";
        show_menu_key;
        ;;
    esac

done




}



chef_config(){
clear
show_menu_chef
while [ 1 ]
    do

    case $opt in

        1) clear;
          boot_linux_node
          show_menu_chef;
        ;;

        2) clear;
          boot_win_node
          show_menu_chef;
            ;;
            
         3) clear;
          boot_bulk
          show_menu_chef;
            ;;   
            
        [bB]) clear;
          cat /opt/shell/bulk.log
          echo ""
          echo ""
          show_menu_chef;
            ;; 
            
         [lL]) clear;
          echo "Node List"
          /usr/bin/knife node list --config /etc/chef/knife.rb
          echo ""
          echo ""
          show_menu_chef;
            ;; 
            
               
         [gG]) clear;
          cat /etc/chef/audit-tool-validator.pem
          sleep 5
          echo " waiting ... "
          clear
          show_menu_chef;
            ;;              
          
          [aA]) clear;
          cat /etc/chef/audit-tool-admin.pem
          sleep 5
          echo " waiting ... "
          clear
          show_menu_chef;
            ;;                 
            
      
            
        [xX]) clear;
            return;
            ;;                            


        *)clear;
        echo -e  "Pick an option from the menu";
        show_menu_chef;
        ;;
    esac

done




}



network_config(){
clear
show_menu_ip
while [ 1 ]
    do

    case $opt in

        
        1) clear;
        #echo -e "Set DHCP";
        set_dhcp_conf
        show_menu_ip;
        ;;

        2) clear;
            #echo -e "Set Static IP";
             config_static_ip
        show_menu_ip;
            ;;
            
        3) clear;
            CURR_IP=$(/sbin/ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
            echo -e  "Current IP is : $CURR_IP";
            show_menu_ip;
            ;; 
          
          
         4) clear;
            #echo -e "Set Static IP";
             config_dns
        show_menu_ip;
            ;;
            
            
         5) clear;
            CURR_DNS=$(/bin/cat /etc/resolv.conf | grep nameserver)
            echo -e  "Current DNS is :";
            echo $CURR_DNS;
            show_menu_ip;
            ;;      
        [pP]) clear;
            network_ping
            echo -e  "";
            show_menu_ip;
            ;; 
            
         [tT]) clear;
            network_test
            echo -e  "";
            show_menu_ip;
            ;;    
            
         
            
        [xX]) clear;
            return;
            ;;                            


        *)clear;
        echo -e  "Pick an option from the menu";
        show_menu_ip;
        ;;
    esac

done




}




function config_static_ip() {

while [ 1 ]
do
  echo -n "Enter your IP address and press [ENTER]: "
    read IP
    #echo -n "your ip $IP "
    if valid_ip $IP; then 
      break; 
    else 
      echo -n "Invalid IP address ";
      echo ""; 
    fi
done


while [ 1 ]
do
  echo -n "Enter your NETMASK address and press [ENTER]: "
    read MASK
    #echo -n "your ip $IP "
    if valid_ip $MASK; then 
      break; 
    else 
      echo -n "Invalid MASK address ";
      echo ""; 
    fi
done



while [ 1 ]
do
  echo -n "Enter your GATEWAY address and press [ENTER]: "
    read GATEWAY
    #echo -n "your ip $GATEWAY "
    if valid_ip $GATEWAY; then 
      break; 
    else 
      echo -n "Invalid GATEWAY address ";
      echo ""; 
    fi
done


while [ 1 ]
do    
echo "Network config : IP:$IP  MASK:$MASK  GW:$GATEWAY";
echo ""
echo  -n "Do you want to apply this configuration? [y/n]: "
read yno
  case $yno in
  
          [yY] | [yY][Ee][Ss] )
                  echo "Apply Static IP ..."
                  create_static_conf $IP $MASK $GATEWAY
                  return
                  ;;
  
          [nN] | [n|N][O|o] )
                  echo "Abort";
                  return
                  ;;
          *) echo "Invalid input"
              ;;
  esac
done    
    
}




function add_key(){

while [ 1 ]
do
  echo -n "Enter your Key Name and press [ENTER]: "
    read KEYNAME
    if [  -n $KEYNAME ]; then 
      break; 
    else 
      echo -n "Invalid Key Name  ";
      echo ""; 
    fi
done


SIZE=0

	while [ 1 ]
		do
  		echo  "Paste your private keys [ENTER]: "
  		echo  "Remove the header from your key (es. -----BEGIN RSA PRIVATE KEY-----)"

    	unset KEY
   		 while :
    		do 
     		read line
     		[[ $line == "" ]] && KEY="${KEY:0:$((${#KEY}-1))}" && break
     		KEY="$KEY"$line$'\n'
    	done
    
    	FILE="/opt/shell/key/$KEYNAME.pem"
    	echo "-----BEGIN RSA PRIVATE KEY-----" >  $FILE
    	echo $KEY | sed  's/\s/\n/g' >>  $FILE
    	echo "-----END RSA PRIVATE KEY-----" >>  $FILE
    	SIZE=$(cat $FILE | wc -l )
    	if [ $SIZE -gt 10 ]; then 
    	    echo  "New Key: $KEYNAME.pem "
    		sleep 3
    		break;
    	else
    		echo "Invalid Key"
    		sleep 3
    		rm -rf $FILE
    		break	
    	fi
	done



}



delete_key(){

        COUNTER=0 
           for f in /opt/shell/key/*.pem ;  do
      			echo "[$COUNTER] $(basename $f)"
      			COUNTER=$[$COUNTER +1]
		   done


while [ 1 ]
do
  echo -n "Enter the number of Key to delete and press [ENTER]: "
    read KEYNUM
    if [[ $KEYNUM =~ ^[0-9]{1,9}$ ]]; then
      break; 
    else 
      echo -n "Invalid Key Number";
      echo ""; 
    fi
done


COUNTER=0
FOUND=0
KEYSELECT=""

for f in /opt/shell/key/*.pem ;  do
      
      if [[ $KEYNUM == $COUNTER ]]; then 
      	 FOUND=1
      	 KEYSELECT=$(basename $f)
      	 break;
      fi
      COUNTER=$[$COUNTER +1]

done

if [ $FOUND == 0 ]; then 
    echo "Invalid number"
    sleep 2
    break;
else
while [ 1 ]
do
  echo -n "Are you sure to delete  ${KEYSELECT} Key [y/N]: "
    read KEYCONFIRM
    if echo $KEYCONFIRM | grep -i "^y$" > /dev/null ; then
      echo "Deleting  ${KEYSELECT}"
       rm -rf /opt/shell/key/$KEYSELECT 
      break; 
    else 
      echo -n "Abort...";
      echo "";
      sleep 1
      break;
    fi
done

fi

}


function boot_linux_node(){




while [ 1 ]
do
  echo -n "Enter your IP/FQDN address and press [ENTER]: "
    read IP
    #echo -n "your ip $IP "
    if valid_ip_fqdn $IP; then 
      break; 
    else 
      echo -n "Invalid IP/FQDN address ";
      echo ""; 
    fi
done

while [ 1 ]
do
  echo -n "Enter your Node Name and press [ENTER]: "
    read NODENAME
    if [  -n $NODENAME ]; then 
      break; 
    else 
      echo -n "Invalid Node Name  ";
      echo ""; 
    fi
done


while [ 1 ]
do
  echo -n "Enter your Username [root]: "
    read USERNAME
    if [  ! $USERNAME == "" ]; then 
      CHEFUSR=" -x $USERNAME --sudo ";
      break; 
    else 
      CHEFUSR=" -x root ";
      break;  
    fi
done


while [ 1 ]
do
  echo "Press the name of key (like server1.pem ) for use ssh private key "
  echo -n "or your Password and press [ENTER]: "
    read -r  PASS
    if [  -n $PASS ]; then 
      break; 
    else 
      echo -n "Invalid Password ";
      echo ""; 
    fi
done



if [  $PASS =~ pem$ ]; then 

		COUNTER=0
		FOUND=0
		KEYSELECT=""

		for f in /opt/shell/key/*.pem ;  do
      
      		if [[ $KEYNUM == $COUNTER ]]; then 
      	 		FOUND=1
      	 		KEYSELECT=$(basename $f)
      	 		echo "Boot in progress... "
      	 		CMD="/usr/bin/knife   bootstrap $IP --node-name $NODENAME  -r recipe[chef-cookbook-ohai]  --config /etc/chef/knife.rb --identity-file /opt/shell/key/$KEYSELECT  $CHEFUSR"  
      	 		break;
      		fi
      		COUNTER=$[$COUNTER +1]

		done
		
		if [ $FOUND == 0 ]; then
			echo "Error Invalid Key name"
			echo "Abort ..."
			sleep 1
		fi
   	

else
    echo "Boot in progress... "
	CMD="/usr/bin/knife   bootstrap $IP --node-name $NODENAME  -r recipe[chef-cookbook-ohai]  --config /etc/chef/knife.rb  $CHEFUSR -P $PASS "
	$CMD
fi


}



function boot_win_node(){
 NORMAL=`echo "\033[m"`
 MENU=`echo "\033[36m"` #Blue

echo  -e "${MENU}Remeberm to enable the WinRM on destination server"


cat <<EOF

winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow
net stop winrm
net start winrm

EOF

echo -e "${NORMAL}"



while [ 1 ]
do
  echo -n "Enter your IP/FQDN address and press [ENTER]: "
    read IP
   if valid_ip_fqdn $IP; then 
      break; 
    else 
      echo -n "Invalid IP/FQDN address ";
      echo ""; 
    fi
done

while [ 1 ]
do
  echo -n "Enter your Node Name and press [ENTER]: "
    read NODENAME
    if [  -n $NODENAME ]; then 
      break; 
    else 
      echo -n "Invalid Node Name  ";
      echo ""; 
    fi
done


while [ 1 ]
do
  echo -n "Enter your Username [Administrator]: "
    read USERNAME
    if [  ! $USERNAME == "" ]; then 
      USERNAME="$USERNAME";
      break; 
    else 
      USERNAME="Administrator";
      break;  
    fi
done

while [ 1 ]
do
  echo -n "Enter your Administrator Password and press [ENTER]: "
    read -r  PASS
    if [  -n $PASS ]; then 
      break; 
    else 
      echo -n "Invalid Password ";
      echo ""; 
    fi
done


echo "Boot in progress... "

/usr/bin/knife  bootstrap windows winrm $IP --node-name $NODENAME -r recipe[chef-cookbook-ohai]  --config /etc/chef/knife.rb -x "$USERNAME" -P "$PASS"
}



function boot_bulk(){
 NORMAL=`echo "\033[m"`
 MENU=`echo "\033[36m"` #Blue

echo  -e "${MENU}Please add the node (use a single space to divide the field)"


cat <<EOF

example for linux  

linux root password123 linux-node1 192.168.1.40
linux root password123 linux-node2 192.168.1.41
linux root secretkey1.pem linux-node3 192.168.1.42
linux root secretkey2.pem linux-node4 192.168.1.43


example for Windows  

windows Administrator password123 windows-node1 192.168.1.50
windows Administrator password123 windows-node2 192.168.1.50
windows Administrator password123 windows-node3 192.168.1.50
windows Administrator password123 windows-node4 192.168.1.50

and press [ENTER]
EOF

echo -e "${NORMAL}"

	while [ 1 ]
		do
    	unset LIST
   		 while :
    		do 
     		read line
     		[[ $line == "" ]] && KEY="${LIST:0:$((${#LIST}-1))}" && break
     		LIST="$LIST"$line$'\n'
    	done
    
    	FILE="/tmp/list-$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM.txt"
    	echo $LIST | sed  's/\s/\n/g' >  $FILE
    	SIZE=$(cat $FILE | wc -l )
    	if [ $SIZE -gt 1 ]; then 
    	     echo "Boot process in backgroup. Please check the log from menu"
       		nohup python /opt/shell/bulk_boot.py  $FILE &
       		break;
    	else
      		echo "The List is empty"
    	fi
    
	done
	





}






function network_ping(){

while [ 1 ]
do
  echo -n "Enter IP address and press [8.8.8.8]: "
    read IP_SRV
    #echo -n "your ip $DNS1 "
    if valid_ip $IP_SRV; then 
      break; 
    else 
      IP_SRV="8.8.8.8";
      break;  
    fi
done


echo -n "Ping IP: $IP_SRV :"
echo -en ' \t '
ping -c 2 -w 2 $IP_SRV > /tmp/ping.log
if [ $? -eq 0 ]; then
  echo "$bldgre OK $txtrst" 
else
  echo "$bldred FAILED $txtrst"
fi

echo ""; 
echo $(cat /tmp/ping.log | grep "received\|rtt" )
echo ""; 

}


function network_test(){

CURR_GW=$( /sbin/route -n | grep 'UG[ \t]' | awk '{print $2}' )
CURR_DNS=$( /bin/cat /etc/resolv.conf | grep nameserver | head -1  | awk {'print$2'} )


echo -n "Ping Gateway $CURR_GW :"
echo -en ' \t '
ping -c 2 -w 2 $CURR_GW > /dev/null
if [ $? -eq 0 ]; then
  echo "$bldgre OK $txtrst" 
else
  echo "$bldred FAILED $txtrst"
fi

echo -n "Ping DNS $CURR_DNS :"
echo -en ' \t '
ping -c 2 -w 2 $CURR_DNS > /dev/null
if [ $? -eq 0 ]; then
  echo "$bldgre OK $txtrst" 
else
  echo "$bldred FAILED $txtrst"
fi


echo -n "Ping www.google.com :"
echo -en ' \t '
ping -c 2 -w 2 www.google.com > /dev/null
if [ $? -eq 0 ]; then
  echo "$bldgre OK $txtrst" 
else
  echo "$bldred FAILED $txtrst"
fi






}





function config_dns() {

while [ 1 ]
do
  echo -n "Enter your DNS 1 address and press [ENTER]: "
    read DNS1
    #echo -n "your ip $DNS1 "
    if valid_ip $DNS1; then 
      break; 
    else 
      echo -n "Invalid DNS1 address ";
      echo ""; 
    fi
done


while [ 1 ]
do
  echo -n "Enter your DNS 2 address and press [ENTER]: "
    read DNS2
    #echo -n "your ip $DNS2 "
    if valid_ip $DNS2; then 
      break; 
    else 
      echo -n "Invalid DNS2 address ";
      echo ""; 
    fi
done



while [ 1 ]
do    
echo "Network config : DNS1:$DNS1  DNS2:$DNS2";
echo ""
echo  -n "Do you want to apply this configuration? [y/n]: "
read yno
  case $yno in
  
          [yY] | [yY][Ee][Ss] )
                  echo "Apply DNS ..."
                  set_dns $DNS1 $DNS2
                  return
                  ;;
  
          [nN] | [n|N][O|o] )
                  echo "Abort";
                  return
                  ;;
          *) echo "Invalid input"
              ;;
  esac
done    
    
}


create_static_conf (){


if [ -f  /etc/debian_version ]; then
  # echo "is debian."
  echo "auto lo" > /tmp/interfaces
  echo "iface lo inet loopback  " >> /tmp/interfaces
  echo "" >> /tmp/interfaces
  echo "auto eth0" >> /tmp/interfaces
  echo "allow-hotplug eth0" >> /tmp/interfaces
  echo "iface eth0 inet static" >> /tmp/interfaces
  echo "    address $1" >> /tmp/interfaces
  echo "    netmask $2" >> /tmp/interfaces
  echo "    gateway $3" >> /tmp/interfaces
  
  sudo /bin/cp /tmp/interfaces /etc/network/interfaces
  sudo /usr/sbin/service networking restart
else
   # echo "other distro."
   HWADDR=$(sudo grep 'HWADDR=' /etc/sysconfig/network-scripts/ifcfg-eth0  | awk -F\" '{ print  $2 }')
    UUID=$(sudo grep 'UUID=' /etc/sysconfig/network-scripts/ifcfg-eth0  | awk -F\" '{ print  $2 }')
    
    echo "auto lo" > /tmp/interfaces
    
    echo 'DEVICE="eth0"' > /tmp/interfaces
    echo 'BOOTPROTO="static"'  >> /tmp/interfaces
    echo "HWADDR=\"$HWADDR\""   >> /tmp/interfaces
    echo 'NM_CONTROLLED="yes"'  >> /tmp/interfaces
    echo 'ONBOOT="yes"'     >> /tmp/interfaces
    echo 'TYPE="Ethernet"'  >> /tmp/interfaces
    echo "UUID=\"$UUID\""   >> /tmp/interfaces
    echo "IPADDR=\"$1\""   >> /tmp/interfaces
    echo "NETMASK=\"$2\""   >> /tmp/interfaces
    
    NETWORKING=$(sudo grep 'NETWORKING=' /etc/sysconfig/network  | awk -F\"  '{ print  $2 }')
    HOSTNAME=$(sudo grep 'HOSTNAME=' /etc/sysconfig/network  | awk -F\" '{ print  $2 }')
    
    echo "NETWORKING=\"$NETWORKING\""   > /tmp/network
    echo "HOSTNAME=\"$HOSTNAME\""   >> /tmp/network
    echo "GATEWAY=\"$3\""   >> /tmp/network
    
    sudo /bin/cp /tmp/interfaces /etc/sysconfig/network-scripts/ifcfg-eth0
    sudo /bin/cp /tmp/network /etc/sysconfig/network
    sudo /sbin/service network restart

fi







}

set_dhcp_conf (){



if [ -f  /etc/debian_version ]; then
  # echo "is debian."
  echo "auto lo" > /tmp/interfaces
  echo "iface lo inet loopback  " >> /tmp/interfaces
  echo "" >> /tmp/interfaces
  echo "auto eth0" >> /tmp/interfaces
  echo "allow-hotplug eth0" >> /tmp/interfaces
  echo "iface eth0 inet dhcp" >> /tmp/interfaces
  
  sudo /bin/cp /tmp/interfaces /etc/network/interfaces
  sudo /usr/sbin/service networking restart
else
   # echo "other distro."
   HWADDR=$(sudo grep 'HWADDR=' /etc/sysconfig/network-scripts/ifcfg-eth0  | awk -F\" '{ print  $2 }')
    UUID=$(sudo grep 'UUID=' /etc/sysconfig/network-scripts/ifcfg-eth0  | awk -F\" '{ print  $2 }')
    
    echo "auto lo" > /tmp/interfaces
    
    echo 'DEVICE="eth0"' > /tmp/interfaces
    echo 'BOOTPROTO="dhcp"'  >> /tmp/interfaces
    echo "HWADDR=\"$HWADDR\""   >> /tmp/interfaces
    echo 'NM_CONTROLLED="yes"'  >> /tmp/interfaces
    echo 'ONBOOT="yes"'     >> /tmp/interfaces
    echo 'TYPE="Ethernet"'  >> /tmp/interfaces
    echo "UUID=\"$UUID\""   >> /tmp/interfaces
   
    
    NETWORKING=$(sudo grep 'NETWORKING=' /etc/sysconfig/network  | awk -F= '{ print  $2 }')
    HOSTNAME=$(sudo grep 'HOSTNAME=' /etc/sysconfig/network  | awk -F= '{ print  $2 }')
    
    echo "NETWORKING=\"$NETWORKING\""   > /tmp/network
    echo "HOSTNAME=\"$HOSTNAME\""   >> /tmp/network
    
    sudo /bin/cp /tmp/interfaces /etc/sysconfig/network-scripts/ifcfg-eth0
    sudo /bin/cp /tmp/network /etc/sysconfig/network
    sudo /sbin/service network restart

fi

}


set_dns (){

echo "nameserver $1" > /tmp/resolv.conf
echo "nameserver $2" >> /tmp/resolv.conf


sudo /bin/cp /tmp/resolv.conf /etc/resolv.conf


}



clear
show_menu
while [ 1 ]
    do

    case $opt in
       

      #  3) clear;

      #      sudo service apache2 restart;
      #      echo -e "";
      #      show_menu;
      #      ;;

            
        [nN]) clear;
            network_config
            echo -e "";
            show_menu;
            ;;
            
        [kK]) clear;
            key_config
            echo -e "";
            show_menu;
            ;;
            
         
         [cC]) clear;
            chef_config
            echo -e "";
            show_menu;
            ;;   
            
        [rR]) clear;
            RED_TEXT=`echo "\033[31m"`
            YLL_TEXT=`echo "\033[33m"` #yellow
            NORMAL=`echo "\033[m"`
            echo "";
            echo "";
            echo  -en "${RED_TEXT} Do you want to ${YLL_TEXT}Reboot${RED_TEXT} ? [y/n]:${NORMAL} "
            read yno
              case $yno in
  
                    [yY] | [yY][Ee][Ss] )
                            echo "Rebooting....."
                            sudo /sbin/shutdown -r now
                            sleep 3;
                            exit;
                            ;;
            
                    [nN] | [n|N][O|o] )
                            echo "Abort";
                            show_menu;
                            ;;
                    *) echo "Invalid input"
                    show_menu;                    
                        ;;
            esac
            
            ;;            
              
         [pP]) clear;
            sudo /usr/bin/passwd admin
            show_menu
            ;; 
            
         sdo) clear;
            sudo /bin/bash
            ;;
            
         sdu) clear;
          /bin/bash   
            ;;                                    
            
        x) clear;
           exit;
            ;;            



        *)clear;
      
        echo -e " Pick an option from the menu";
        show_menu;
        ;;
    esac

done