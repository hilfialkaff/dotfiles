#!/bin/bash

#Layout
BAR_H=8
SMABAR_W=30
WIDTH=1366
HEIGHT=14
X_POS=680
Y_POS=0

#Look and feel
CRIT="#d74b73"
BAR_FG="#60a0c0"
BAR_BG="#363636"
DZEN_FG="#9d9d9d"
DZEN_FG2="#5f656b"
DZEN_BG="#000000"
COLOR_ICON="#60a0c0"
COLOR_SEP="#a488d9"
FONT="-*-fixed-*-*-*-*-12-*-*-*-*-*-*-*"

#Options
IFS='|' #internal field separator (conky)
CONKYFILE="/home/aurum/.conkyrc"
ICONPATH="/home/aurum/.xmonad/icons/"
INTERVAL=1

# CPUTemp=0
# GPUTemp=0
# CPULoad0=0
# CPULoad1=0
# CPULoad2=0
# CPULoad3=0

# printMemInfo() {
#     # echo -n "^fg($COLOR_ICON)^i($ICONPATH/memory.xbm) "
#     echo -n "^fg($COLOR_ICON)Mem: "
#     echo -n "^fg()${MemUsed} "
#     echo -n "$(echo $MemPerc | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $SMABAR_W -o -nonl)"
#     return
# }
#
# printFileInfo() {
#     NPKGS=$(pacman -Q | wc -l)
#     NPROC=$(expr $(ps -A | wc -l) - 1)
#     echo -n "^fg($COLOR_ICON)^i($ICONPATH/pc.xbm) "
#     echo -n "^fg($DZEN_FG2)proc ^fg()$NPROC "
#     echo -n "^fg($DZEN_FG2)pkgs ^fg()$NPKGS"
#     return
# }
# 
# printDiskInfo() {
#     RFSP=$(df -h / | tail -1 | awk -F' ' '{ print $5 }' | tr -d '%')
#     BFSP=$(df -h /boot | tail -1 | awk -F' ' '{ print $5 }' | tr -d '%')
#     if [[ $RFSP -gt 70 ]]; then
#         RFSP="^fg($CRIT)"$RFSP"^fg()"
#     fi
#     if [[ $BFSP -gt 70 ]]; then
#         BFSP="^fg($CRIT)"$BFSP"^fg()"
#     fi
#     echo -n "^fg($COLOR_ICON)^i($ICONPATH/file1.xbm) "
#     echo -n "^fg($DZEN_FG2)root ^fg()${RFSP}% "
#     echo -n "^fg($DZEN_FG2)boot ^fg()${BFSP}%"
# }
# 
# printKerInfo() {
#     echo -n " ^fg()$(uname -r)^fg(#007b8c)/^fg(#5f656b)$(uname -m) ^fg(#a488d9)| ^fg()$Uptime"
#     return
# }
#
# printCPUInfo() {
#     # echo -n "^fg($COLOR_ICON)^i($ICONPATH/cpu.xbm) "
#     echo -n "^fg($COLOR_ICON)CPU:"
#     echo -n "^fg($DZEN_FG1)$(echo $CPULoad0 | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $SMABAR_W -o -nonl) "
#     echo -n "^fg($DZEN_FG1)$(echo $CPULoad1 | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $SMABAR_W -o -nonl) "
#     echo -n "^fg($DZEN_FG1)$(echo $CPULoad2 | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $SMABAR_W -o -nonl) "
#     echo -n "^fg($DZEN_FG1)$(echo $CPULoad3 | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $SMABAR_W -o -nonl) "
#     return
# }

printMusic() {
    echo -n "^fg($COLOR_ICON)^i($ICONPATH/music.xbm):"

    music_status=$(cmus-remote -Q)
    if [ $? == 1 ] ; then
        echo -n "^fg($DZEN_FG1) None"
        for ((x=1; x<=16; x++))
        {
            echo -n " "
        }
    else
        song_name=$(echo $music_status | grep file | cut -d '/' -f6)
        if [ ${#song_name} == 0 ]; then
            echo -n "^fg($DZEN_FG1) None"
            for ((x=1; x<=16; x++))
            {
                echo -n " "
            }
            return
        elif [ ${#song_name} -gt 20 ]; then
            song_name=$(echo $song_name | cut -c 1-17)
            echo -n "^fg($DZEN_FG1) $song_name..."
        else
            echo -n "^fg($DZEN_FG1) $song_name"
            for ((x=1; x<=$[20 - ${#song_name}]; x++))
            {
                echo -n " "
            }
        fi

        playing_status=$(echo $music_status | grep status | awk '{print $2}')
        if [ $playing_status == "playing" ]; then
            echo -n "^i($ICONPATH/play.xbm)"
        else
            echo -n "^i($ICONPATH/pause.xbm)"
        fi
    fi

    return
}

printMail() {
    echo -n "^fg($COLOR_ICON)^i($ICONPATH/mail.xbm):"
    echo -n "^fg($DZEN_FG1) $(cat /var/spool/mail/$USER | grep "From aurum" | wc -l)"
    return
}

printBattery() {
    echo -n "^fg($COLOR_ICON)^i($ICONPATH/battery.xbm):"
    echo -n "^fg($DZEN_FG1) $(acpi -b | awk '{print $4}' | tr -d "%,")%"
    
    return
}

printTimeInfo() {
    echo -n "^fg($COLOR_ICON)^i($ICONPATH/clock.xbm):"
    echo -n "^fg($DZEN_FG1) $(date '+%H^fg(#444):^fg()%M^fg(#444)')"
    echo -n "^fg()  $(date '+%Y^fg(#444):^fg()%m^fg(#444):^fg()%d^fg(#007b8c)/^fg(#5f656b)%a ^fg(#a488d9)')"
    return
}

printWifi() {
    echo -n "^fg($COLOR_ICON)^i($ICONPATH/wifi.xbm):"
    echo -n "^fg($DZEN_FG1) $(iwgetid | awk -F ":" '{print $2}'|sed -e 's/"//g')" # $(iwconfig wlan0 | grep "Link Quality" | awk '{ print $2 }')"
    return
}

printVolume() {
    echo -n "^fg($COLOR_ICON)^i($ICONPATH/vol.xbm):"
    echo -n "^fg($DZEN_FG1) $(amixer get Master | egrep -o "[0-9]+%")"
    return
}

printSpace() {
    echo -n " ^fg($COLOR_SEP)|^fg() "
    return
}

# XXX: Hack to fill in black screen due to .fehbg bug
printFill() {
    echo -n "       "
}

printBar() {
    while true; do
        # read CPULoad0 CPULoad1 CPULoad2 CPULoad3
        # printKerInfo
        # printMemInfo
        # printSpace
        # printDiskInfo
        # printSpace
        # printFileInfo
        # printSpace
        printFill
        printSpace
        printMusic
        printSpace
        printMail
        printSpace
        printBattery
        printSpace
        printVolume
        printSpace
        printTimeInfo
        printSpace
        printWifi
        echo
        sleep $INTERVAL
    done
    return
}

#Print all and pipe into dzen
# conky -c $CONKYFILE -u $INTERVAL | printBar | dzen2 -x $X_POS -y $Y_POS -w $WIDTH -h $HEIGHT -fn $FONT -ta 'l' -bg $DZEN_BG -fg $DZEN_FG -p -e ''
printBar | dzen2 -x $X_POS -y $Y_POS -w $WIDTH -h $HEIGHT -fn $FONT -ta 'l' -bg $DZEN_BG -fg $DZEN_FG -p -e ''
