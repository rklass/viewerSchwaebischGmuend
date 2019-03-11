#!/bin/bash
# 1.)  Beim ersten Start jpgs über fbbi in Endlosschelicfe anzeigen
#pfad="~/streamups/bilder/*"
#zeit=3
end=15
lauf=$end
while [ $lauf -gt 0 ]
do
 echo In $lauf sec wird gestartet
 lauf=$((lauf-1))
 sleep 1
done
sudo fbi -a -T 1 -1 --once -v --noverbose /home/pi/Pausenbild.jpg
#sudo fbi -noverbose -a -T 1 -u /home/pi/Pausenbild.jpg
pfbi=$(pidof fbi)
#echo "fbi gestartet " $pfbi
# 2.)  Kamera IPs
ip1="192.168.22.141" #ip der Kamera1
ip2="192.168.22.142" #ip der Kamera2
#ip1="192.168.0.80" # Test an meinem PC -> auskommentieren
#ip2="192.168.0.52" # Test an meinem PC -> auskommentieren
stream1="rtsp://root:tibet2000@192.168.22.141:554/axis-media/media.amp"
stream2="rtsp://root:tibet2000@192.168.22.142:554/axis-media/media.amp"
# 3.) Endlosschleife Kamerabild oder fbi anzeigen
while true
do
  if ping -c 1 $ip1 > /dev/null ; then          #Kamera1 suchen
     echo "Kamera1 ist gefunden IP= " $ip1
      sudo kill $pfbi # fbi stoppen
#      /usr/bin/omxplayer -o both --no-keys --live -b --threshold 0 $stream1  #omxplayer starten mit Kamera1
#      /usr/bin/omxplayer -o both --no-keys -b --threshold 0 $stream1  #omxplayer starten mit Kamera1
      /usr/bin/omxplayer --avdict rtsp_transport:tcp -o both --no-keys -b --threshold 0.8  $stream1 # spezial mit Ralf
#      /usr/bin/omxplayer -o hdmi --win "0 0 1280 720" $stream1 # Stream aus Bondorf PI Lokal in Kirche
#      /usr/bin/omxplayer --avdict rtsp_transport:tcp -o hdmi --no-keys -b --threshold 0.8  $stream1 # spezial mit Ralf
#     /usr/bin/omxplayer -o hdmi $stream1  # funktionieret so fuer rtmp://rk-solutions-stream.de/livegecho/test
#     /usr/bin/omxplayer -o both --no-keys -b --threshold 0.8 # Testfall bei Bondorf


     echo "Kamera1 wurde abgeschaltet, fbi wird wieder gestartet"
      sudo fbi -a -T 1 -1 --once -v --noverbose /home/pi/Pausenbild.jpg
#      sudo fbi -noverbose -a -T 1 -u /home/pi/Pausenbild.jpg # fbi wieder starten
      pfbi=$(pidof fbi)
     echo "fbi gestartet " $pfbi
      sleep 5
  fi
  if ping -c 1 $ip2 > /dev/null ; then          #Kamera2 suchen
      echo "Kamera2 ist gefunden. IP=  " $ip2
      sudo kill $pfbi # fbi stoppen
      /usr/bin/omxplayer -o both --no-keys --live -b --threshold 0 $stream2  #omxplayer starten mit Kamera2
      #/usr/bin/omxplayer -o both --no-keys --live -b --threshold 0 /home/pi/film.mp4  #Teststream anzeigen
      echo "Kamera2 wurde abgeschaltet, fbi wird wieder gestartet"
      sudo fbi -a -T 1 -1 --once -v --noverbose /home/pi/Pausenbild.jpg
#     sudo fbi -noverbose -a -T 1 -u /home/pi/Pausenbild.jpg # fbi wieder starten
      pfbi=$(pidof fbi)
      echo "fbi gestartet " $pfbi
      sleep 5
  fi
  echo "Es läuft keine Kamera"
  sleep 5
done

