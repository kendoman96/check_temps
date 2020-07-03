#!/bin/bash

check ()
        {

        CPUWARN=65
        CHIPWARN=80

        CPUCRIT=75
        CHIPCRIT=90

        SENSORS=$(sensors)

        CORE0=$(echo $SENSORS | awk -F 'Core 0:' '{print $2}' | awk -F '+' '{print $2}' | awk -F '.' '{print $1}' )
        CORE1=$(echo $SENSORS | awk -F 'Core 1:' '{print $2}' | awk -F '+' '{print $2}' | awk -F '.' '{print $1}' )
        CORE2=$(echo $SENSORS | awk -F 'Core 2:' '{print $2}' | awk -F '+' '{print $2}' | awk -F '.' '{print $1}' )
        CORE3=$(echo $SENSORS | awk -F 'Core 3:' '{print $2}' | awk -F '+' '{print $2}' | awk -F '.' '{print $1}' )
        CORE4=$(echo $SENSORS | awk -F 'Core 4:' '{print $2}' | awk -F '+' '{print $2}' | awk -F '.' '{print $1}' )
        CORE5=$(echo $SENSORS | awk -F 'Core 5:' '{print $2}' | awk -F '+' '{print $2}' | awk -F '.' '{print $1}' )
        CORE6=$(echo $SENSORS | awk -F 'Core 6:' '{print $2}' | awk -F '+' '{print $2}' | awk -F '.' '{print $1}' )
        CORE7=$(echo $SENSORS | awk -F 'Core 7:' '{print $2}' | awk -F '+' '{print $2}' | awk -F '.' '{print $1}' )
        CORE8=$(echo $SENSORS | awk -F 'Core 8:' '{print $2}' | awk -F '+' '{print $2}' | awk -F '.' '{print $1}' )
        CORE9=$(echo $SENSORS | awk -F 'Core 9:' '{print $2}' | awk -F '+' '{print $2}' | awk -F '.' '{print $1}' )
        CORE10=$(echo $SENSORS | awk -F 'Core 10:' '{print $2}' | awk -F '+' '{print $2}' | awk -F '.' '{print $1}' )
        CORE11=$(echo $SENSORS | awk -F 'Core 11:' '{print $2}' | awk -F '+' '{print $2}' | awk -F '.' '{print $1}' )

        CHIPSET=$(echo $SENSORS | awk -F 'temp1:' '{print $2}' | awk -F '+' '{print $2}' | awk -F '.' '{print $1}' )

        TOTAL=$(($CORE0 + $CORE1 + $CORE2 + $CORE3 + $CORE4 + $CORE5 + $CORE6 + $CORE7 + $CORE8 + $CORE9 + $CORE10 + $CORE11))
        AVG_CPU=$(($TOTAL / 12))

        main;

        }

alarm ()
        {

        echo "ALARM"
        echo "CPU: "$AVG_CPU" C "$CPUCRIT""
        echo "Chipset: "$CHIPSET" C "$CHIPCRIT""
        exit 2

        }

warning ()
        {

        echo "WARNING"
        echo "CPU: "$AVG_CPU" C "$CPUWARN""
        echo "Chipset: "$CHIPSET" C "$CHIPWARN""
        exit 1

        }

normal ()
        {

        echo "NORMAL"
        echo "CPU: "$AVG_CPU" C"
        echo "Chipset: "$CHIPSET" C"
        exit 0

        }

main ()
        {

        if [[ $AVG_CPU -ge $CPUCRIT ]]; then
                alarm;
        else
                if [[ $AVG_CPU -ge $CPUWARN ]]; then
                        warning;
                else
                        if [[ $CHIPSET -ge $CHIPCRIT ]]; then
                                alarm;
                        else
                                if [[ $CHIPSET -ge $CHIPWARN ]]; then
                                        warning;
                                else
                                        normal;
                                fi
                        fi
                fi
        fi

        }

check;
