#!/bin/bash

if [[ ! -e /tmp/et.zip ]]; then
    wget -q -O et.zip https://cdn.splashdamage.com/downloads/games/wet/et260b.x86_full.zip
fi

if [[ ! -e /tmp/etl.tgz ]]; then
    wget -q -O etl.tgz https://www.etlegacy.com/download/file/122
fi

if [[ ! -e /tmp/nitmod.zip ]]; then
    wget -q -O nitmod.zip http://etmods.net/forums/filedl.php?id=9
fi

if [[ ! -e /tmp/etjump.zip ]]; then
    wget --no-check-certificate -q -O etjump.zip https://etjump.com/etjump/etjump-2_3_0.zip
fi
