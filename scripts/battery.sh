POWER=$(acpi -b | grep "Battery 0" | grep -o '[0-9]\+%' | tr -d '%')
if [ $POWER -le 5 ]; then
	notify-send "Battery low !"
fi	
