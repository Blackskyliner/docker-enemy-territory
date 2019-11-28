#!/bin/bash

ET_POOL=${ET_POOL:-"http://mappool.sexygaming.de/etmain"}
ET_MAPS=${ET_MAPS:-""}

# Maps by environment
if [[ -n $ET_MAPS ]]; then
    for MAP in $ET_MAPS; do
        if [[ ! -e "/opt/mappool/$MAP" ]]; then
            run-as-user wget -q -O "/opt/mappool/$MAP" "$ET_POOL/$MAP"
        fi
    done
fi

# Maps by .csv file
if [[ -e /opt/mappool/maps.csv ]]; then
    for MAP in $(cat /opt/mappool/maps.csv); do
        if [[ ! -e "/opt/mappool/$MAP" ]]; then
            run-as-user wget -q -O "/opt/mappool/$MAP" "$ET_POOL/$MAP"
        fi
    done
fi

# Copy cached maps into gamedir
# Symlinks are broken so we have to do it this way
# Hardlinks are not possible because docker (mount) volumes.
run-as-user find /opt/mappool -name '*.pk3' -exec cp -n -v {} /opt/application/etmain \;
