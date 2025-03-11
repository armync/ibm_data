#!/bin/bash

city=Casablanca

curl -s wttr.in/$city?T --output weather_report

# current
obs_temp=$(curl -s wttr.in/$city?T | grep -m 1 '°.' | grep -Eo -e '-?[[:digit:]].')
echo "The current Temperature of $city: $obs_temp"

#noon
fc_temp=$(curl -s wttr.in/$city?T | head -23 | tail -1 | grep '°.' | cut -d 'C' -f2 | grep -Eo -e '-?[[:digit:]].')
echo "The forecasted temperature for noon tomorrow for $city : $fc_temp"

TZ='Morocco/Casabanca'

day=$(TZ='Morocco/Casablanca' date -u +%d)
month=$(TZ='Morocco/Casablanca' date +%m)
year=$(TZ='Morocco/Casablanca' date +%Y)

record=$(echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp")
echo $record>rx_poc.log