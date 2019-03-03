#!/bin/bash

if [[ ! -e /tmp/et.zip ]]; then
    wget -O et.zip https://cdn.splashdamage.com/downloads/games/wet/et260b.x86_full.zip
fi

if [[ ! -e /tmp/etl.tgz ]]; then
    wget -O etl.tgz https://www.etlegacy.com/download/file/122
fi

if [[ ! -e /tmp/nitmod.zip ]]; then
    wget -O nitmod.zip http://etmods.net/forums/filedl.php?id=9
fi
