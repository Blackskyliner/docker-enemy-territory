#!/bin/bash

ET_POOL=${ET_POOL:-"http://mappool.sexygaming.de/etmain"}
ET_MAPS=${ET_MAPS:-""}

if [[ -n $ET_MAPS ]]; then
    for MAP in $ET_MAPS; do
        if [[ ! -e "/opt/application/etmain/$MAP.pk3" ]]; then
            wget -O "/opt/application/etmain/$MAP.pk3" "$ET_POOL/$MAP.pk3"
        fi
    done
fi