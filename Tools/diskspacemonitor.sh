#!/bin/sh
#df -H | grep -vE '^Filesystem|none|cdrom' | awk '{ print $5 " " $1 }' | while read output;

#TO="deva_gladwin@in.com"

df -Pl  | grep "^/dev" | awk '{print $5, $6}' | sed "s/%//" | while read output;
do
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )

  if [ $usep -ge 97 ]; then

        echo "Please act on this email or you will loose access to this server." >> diskspace.txt
        echo " " >> diskspace.txt
        `df -h >> diskspace.txt`
        SUBJECT="Critical Alert: Low Disk Space on $HOSTNAME - $usep% usage."
        MAILMESSAGE="diskspace.txt"
        mail -s "$SUBJECT" "$TO" < $MAILMESSAGE
        rm $MAILMESSAGE
 elif [ $usep -ge 93 ]; then

        echo "The intelligence monitors recommend you to make some disk space to avoid the service disruptions." >> diskspace.txt
        echo " " >> diskspace.txt
        `df -h >> diskspace.txt`
        SUBJECT="Warning: Low Disk Space on $HOSTNAME - $usep% usage."
        MAILMESSAGE="diskspace.txt"
        mail -s "$SUBJECT" "$TO" < $MAILMESSAGE
        rm $MAILMESSAGE

 fi
 
done