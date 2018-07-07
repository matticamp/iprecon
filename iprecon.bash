#!/bin/bash

#IP address checking script
#Created by Mattia Campagnano on Tue Jan  2 21:37:04 EST 2018
echo -n "Please enter an IP address to check:  ";

read ip
echo -n "Output file 1: "
read output1

echo -n "Output file 2: "
read output2

echo -n "Output file 3: "
read output3

echo -n "Output file 4: "
read output4

echo -n "Enter analyst name: "

read name

#Checks whether the user enters an IP.
#If not, it throws an error

#If the user enters an IP, it starts recon process.

#IP address validation through if statement 
#and a regular expression.

if [ -z  $ip ]
then
   echo "Enter an IP address"
fi

    octet1=$(echo $ip | cut -d "." -f1)
    octet2=$(echo $ip | cut -d "." -f2)
    octet3=$(echo $ip | cut -d "." -f3)
    octet4=$(echo $ip | cut -d "." -f4)
    stat=0
if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] && [ $octet1 -le 255 ] && [ $octet2 -le 255 ] && [ $octet3 -le 255 ] && [ $octet4 -le 255 ];
then
       stat=1
else
       stat=0
fi
case "$stat" in
   "1")echo "Recon on $ip" ;;
   "0")echo "Invalid IP address" 
      exit 1 ;;
esac
if  [[ "$ip" =~ (^192.168|^10\.) ]];
then

     echo "${ip} is a private IP address. No recon can be performed"
     exit 1;
elif [[ "$ip" =~ (^172.16\.|^172.17\.|^172.18\.|^172.19\.|^172.20\.|^172.21\.|^172.22\.|^172.23\.|^172.24\.|^172.25\.|^172.26\.|^172.27\.|^172.28\.|^172.29\.|^172.30\.|^172.31\.) ]];   
then
     echo "${ip} is a private IP address. No recon can be performed"
     exit 1;
elif [[ "$ip" =~ (^127\.) ]]
then
     echo "${ip} is a loopback IP address. No recon can be performed"
     exit 1;


elif [[ "$ip" =~ (^224\.|^225\.|^226\.|^227\.|^228\.|^229\.|^230\.|^231\.|^232\.|^233\.|^234\.|^235\.|^236\.|^237\.|^238\.|^239\.|^240\.|^241\.|^242\.|^243\.|^244\.|^245\.|^246\.|^247\.|^248\.|^249\.|^250\.|^251\.|^252\.|^253\.|^254\.|^255\.) ]];

then
     echo "Reserved IP address range. No recon can be performed"
     exit 1;


else
     echo "Valid public IP Address"

fi

today=$(date)
echo "Output of the nslookup command run on ${ip} performed by ${name} on ${today}" >> "$output1"

echo "Output of the dig command run on ${ip} performed by ${name} on ${today}" >> "$output2"

echo "Output of the whois command run on ${ip} performed by ${name} on ${today}" >> "$output3"

echo "Output of the host command run on ${ip} performed by ${name} on ${today}" >> "$output4"
echo
nslookup $ip >> $output1
sleep 2
dig $ip >> $output2
sleep 2
whois $ip >> $output3
sleep 2
host $ip >> $output4
echo
echo "All commands successfully performed. Exiting..."
