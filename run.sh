#!/bin/bash
NC='\033[0m'
RED='\033[1;38;5;196m'
GREEN='\033[1;38;5;040m'
ORANGE='\033[1;38;5;202m'
BLUE='\033[1;38;5;012m'
BLUE2='\033[1;38;5;032m'
PINK='\033[1;38;5;013m'
GRAY='\033[1;38;5;004m'
NEW='\033[1;38;5;154m'
YELLOW='\033[1;38;5;214m'
CG='\033[1;38;5;087m'
CP='\033[1;38;5;221m'
CPO='\033[1;38;5;205m'
CN='\033[1;38;5;247m'
CNC='\033[1;38;5;051m'

function banner(){
echo -e ${RED}"##########################################################"                                                    
echo -e ${CP}"#     _____     _               ____  __  __ ____         #"    
echo -e ${CP}"#    |  ___|_ _| | _____       / ___||  \/  / ___|        #"
echo -e ${CP}"#    | |_ / _  | |/ / _ \      \___ \| |\/| \___ \        #"
echo -e ${CP}"#    |  _| (_| |   <  __/       |__) | |  | |___) |       #"
echo -e ${CP}"#    |_|  \__,_|_|\_\___|      |____/|_|  |_|____/  v1.0  #"
echo -e ${BLUE}"#                                                           #"
echo -e ${BLUE}"#             Send Messages Anonymously                     #" 
echo -e ${YELLOW}"#                                                          #"
echo -e ${GREEN}"#     https://github.com/IranSoldier/Fake-sms            #"  
echo -e ${GREEN}"#                                                        #"
echo -e ${RED}"##########################################################"
   
}
resize -s 38 70 > /dev/null
function dependencies(){
echo -e ${PINK}
cat /etc/issue.net


echo "Checking dependencies configuration " 
sleep 1
if [[ "$(ping -c 1 8.8.8.8 | grep '100% packet loss' )" != "" ]]; then
  echo ${RED}"Error! No Internet Connection."
  exit 1
  else
  echo -e ${GREEN} "\n[ ✔ ] Internet.............${GREEN}[ working ]"
fi
sleep 1
which curl > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e ${GREEN} "\n[ ✔ ] curl.............${GREEN}[ found ]"
else
echo -e $red "[ X ] curl  -> ${RED}Error! Not Found "
echo -e ${YELLOW} "[ ! ] Installing curl "
sudo apt-get install curl
echo -e ${BLUE} "[ ✔ ] Done installing ...."
fi
sleep 1
which git > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e ${GREEN} "\n[ ✔ ] git.............${GREEN}[ found ]"
else
echo -e $red "[ X ] git  -> ${RED}Error! Not Found  "
echo -e ${YELLOW} "[ ! ] Installing git "
pkg update && pkg upgrade  > /dev/null 2>&1
pkg install git > /dev/null 2>&1
echo -e ${BLUE} "[ ✔ ] Done installing ...."
which git > /dev/null 2>&1
sleep 1
fi
sleep 1
}

function printmsg(){
echo  -e ${RED}"Action Was Finished!"
exit
}

function instruction(){

echo -e ${YELLOW}"\n1. Your Country Code Must Be without "+"\n"
sleep 0.5
echo -e ${BLUE}"2. Country Code Example: 98\n"
sleep 0.5
echo -e ${ORANGE}"3. Your Phone Number Must Be Start Without 0\n"
sleep 0.5
echo -e ${CNC}"4. Full Usage: 989123456789\n"
sleep 0.5
echo -e ${RED}"Attention: Only One Text Message Is Allowed Per Day!\n"
sleep 0.5
echo -e -n ${BLUE}"\nDo You Want To Test It?: [y/n]: "
read back_press
if [ $back_press = "y"  ]; then
         SENDSMS
elif [ $back_press = "n" ]; then
              exit
     fi


}

function SENDSMS() {
    clear
    banner
    echo ""
   echo -e ${ORANGE}"Enter Phone Number with County Code like (989123456789)\n"
   echo -e -n ${CP}"Enter Phone Number : "
   
   read num
   
   echo "  "
   echo -e -n ${BLUE}"Enter Your Message: "
   
   read msg


   SMSVERIFY=$(curl -# -X POST https://textbelt.com/text --data-urlencode phone="$num" --data-urlencode message="$msg" -d key=textbelt)
   
   if grep -q true <<<"$SMSVERIFY"
   
   then
      
      echo "  "
      echo -e ${CNC}"MESSAGE WAS SUCCESSFULLY SENT! "
      echo "  "
      echo -e ${CNC}" ---------------------------------------------- "
      echo "$SMSVERIFY"
      echo -e ${CNC}" ---------------------------------------------- "
      echo "  "
      printmsg
   else
      
      echo "  "
      echo -e ${RED}"MESSAGE WAS NOT SENT! ACTION FAILED "
      echo "  "
      echo -e ${CNC}" ---------------------------------------------- "
      echo "$SMSVERIFY"
      echo -e ${CNC}" ---------------------------------------------- "
      echo " "
      printmsg
   fi
}
function STATUSCHECK(){
echo -e -n ${ORANGE}"\nEnter Text ID (e.g 123456): "
read ID
STATUSCONFIRM=$(curl -# https://textbelt.com/status/"$ID")
echo -e ${PINK}" Final Response (JSON): "
   echo " "
   echo -e ${PINK}" ---------------------------------------------- $NC"
   echo "$STATUSCONFIRM"
   echo -e ${PINK}"------------------------------------------------- $NC"
}
trap ctrl_c INT
ctrl_c() {
clear
echo -e ${RED}"[*] Stopping Services... "
sleep 1
echo ""
echo -e ${YELLOW}"[*] Thanks For Using Fake-SMS  :)"
exit
}


menu(){

clear
dependencies
clear
banner


echo -e " \n${NC}[${CG}"1"${NC}]${CNC} SEE USAGE "
echo -e "${NC}[${CG}"2"${NC}]${CNC} Send Fake SMS"
echo -e "${NC}[${CG}"3"${NC}]${CNC} CHECK SMS STATUS "
echo -e "${NC}[${CG}"4"${NC}]${CNC} EXIT "
echo -n -e ${RED}"\n[+] Select: "
read play
   if [ $play -eq 1 ]; then
          instruction
   elif [ $play -eq 2 ]; then
          SENDSMS
   elif [ $play -eq 3 ]; then
          STATUSCHECK
   elif [ $play -eq 4 ]; then
          exit
         
      fi
}
menu
#coded by Machine404
