#!/bin/bash

# Функция для проверки наличия процесса screen с именем miner
check_miner() {
    pgrep -f "SCREEN.*miner" > /dev/null
}

# Флаг для отслеживания состояния майнера
miner_was_running=false

while true; do
    if check_miner; then
        echo "Mining run"
        miner_was_running=true
    else
        if $miner_was_running; then
            echo "Mining stop, OC reset"
            nvtool --setclocks 0 --setcoreoffset 0 --setmem 0 --setmemoffset 0 --setpl 0
            miner_was_running=false
        else
            echo "Mining stop"
        fi
    fi

    sleep 60
done
