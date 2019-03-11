#!/bin/bash
# 1.)  Beim ersten Start jpgs über fbbi in Endlosschelicfe anzeigen
#pfad="~/streamups/bilder/*"
#zeit=3
ip1=192.168.22.141
ip2=192.168.22.142


cam1="/usr/bin/ffmpeg -i rtsp://root:tibet2000@$ip1:554/axis-media/media.amp -c:v libx264 -preset superfast -maxrate 1800k -bufsize 3500k -crf 23 \
-s 1280x720 -pix_fmt yuv420p -b:v 2500 -g 30 -r 30 -c:a aac -ac 1 -b:a 128k -ar 48000 -f flv rtmp://rk-solutions-stream.de/livevinzenz/test"
cam2="/usr/bin/ffmpeg -i rtsp://root:tibet2000@$ip2:554/axis-media/media.amp -c:v libx264 -preset superfast -maxrate 1800k -bufsize 3500k -crf 23 \
-s 1280x720 -pix_fmt yuv420p -b:v 2500 -g 30 -r 30 -c:a aac -ac 1 -b:a 128k -ar 48000 -f flv rtmp://rk-solutions-stream.de/livevinzenz/test"

while true
do
  if ping -c 1 $ip1 > /dev/null ; then          #Kamera1 suchen
     echo "Kamera1 ist gefunden IP= " $ip1
     sleep 10
     $cam1 > /dev/null 2> /dev/null
  fi
  if ping -c 1 $ip2 > /dev/null ; then          #Kamera2 suchen
     echo "Kamera2 ist gefunden IP= " $ip2
     sleep 10
     $cam2 > /dev/null 2> /dev/null
  fi
  echo "Keine Kamera gefunden!"
  sleep 5
done

