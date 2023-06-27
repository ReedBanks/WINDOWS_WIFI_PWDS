#! /bin/bash

#OS check
if [ $(uname -s) != 'MINGW'* ]; then # ESREV
    echo 'this script works for windows only.'
    echo "Running ..."
    #get profiles
    yfile=net.txt
    grepfile=grep.txt
    pwdfile=pwd.txt
    netsh wlan show profiles >$yfile
    grep -i 'All User Profile' $yfile >$grepfile
    awk '{print $5,$6,$7,$8}' $grepfile >$yfile #assigning profiles to net

    echo "Data cleared ... " >$grepfile
    echo "Data cleared ... " >$pwdfile

    if [ -a $yfile ]; then
        while IFS="" read -r line; do

            profile_output=$(netsh wlan show profiles name=$line key=clear)
            echo "$profile_output" >>$grepfile
            ssid_name= echo "$profile_output" | grep -n 'SSID name' >>$pwdfile
            key_content= echo "$profile_output" | grep -n 'Key Content' >>$pwdfile

        done <$yfile
    else
        echo -s "file system error"
    fi
    rm $grepfile
    rm $yfile
    echo "Done 100%.Check pwdlist.txt"
else
    exit
fi
