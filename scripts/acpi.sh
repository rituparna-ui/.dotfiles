#!/bin/bash
#
acpi_listen | while IFS= read -r line;
do
    if [ "$line" = "jack/headphone HEADPHONE plug" ]
    then
        notify-send "Headphones Connected"
        sleep 1.5
    elif [ "$line" = "jack/headphone HEADPHONE unplug" ]
    then
        notify-send "Headphones Disconnected"
        sleep 1.5
    elif [ "$line" = "ac_adapter ACPI0003:00 00000080 00000000" ]
    then
        notify-send "Charger Disconnected"
    elif [ "$line" = "ac_adapter ACPI0003:00 00000080 00000001" ]
    then
        notify-send "Charger Connected"
    fi
done
