# Mushroom Pi
* March 28, 2020 *
* This program will create a server to receive and transmit sensor data from mushroom tub to local website. *

# Variables
to = March 27, 2020 #date of planting
Rht # Humidity at time t
Rhmin = 60% # minimum of desired humidity
Rhmax = 90% # maximum of desired humidity
Tt # ambient temperature at time t
Tmin = 55 # minimum desired ambient temperature
Tmax = 75 # maximum desired ambient temperature
TSt # substrate temperature at time t
refreshrate = 5 minutes

# Sensors
+ Humidity/temperature ambient (Rh, T)
+ temperature probe (TP)
+ Camera (Cam)

# Actuators
+ Humidifier (H)
+ Fan (F)
+ Light (L)
+ Heater (R)
  
# Code

## Camera
### usbcamera
\# Install fswebcam
> sudo apt install fswebcam
\# Create script
#!/bin/bash
\# Create time variable DATE
DATE =$(date+"%Y-%m-%_%H%M")
\# Take picture
> fswebcam -r 384x288 image_$DATE.jpg

\# Save file as executable
> chmod +x webcam.sh

\# create subdirectory to hold pictures
mkdir webcam && cd webcam
\# run webcam
> ./webcam.sh

\# Picture every hour & turn on light
\# time-lapse using cron
> crontab -e
\# store picture every 15 minutes
> webcam.sh 2>$15
\# save and exit

# Humidity/Temperature
> read  @RR
\# Humidity low ? turn on humidifier on : humidifier off
> Rht < Rhmin ? H =1 : H=0
> /# humidity high ? turn on fan
> Rht > Rhmax ? F = 1
\# Temperature low ? turn on heater for 5 minutes or notify
> T < Tmin ? F= 1 for RR
> Temperature high ? turn on fan
> store temperature and humidity every 15 minutes 

# Pinning
> % brown < 80% ? spawned = TRUE
> % brown + % white < 95% ? contamination == TRUE & send notification
> Image has white spawn ? turn light and fan on for 15 minutes every hour

# CO2
> eCO2 high? turn on fan for 10 minute 

# Fruited
> nothing or spawning or pinning or fruiting ? send notification

# MQTT server
send picture
send humdity and temperature reading 
send eCO2 reading
volume of mushrooms
