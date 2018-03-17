#!/bin/bash
if [ "$1" == "" ]; then
    echo "期間を入力して下さい"
    exit 1
fi

START_DATE=$(date -v -"$1"d "+%Y/%m/%d")
echo "  \n$START_DATE 以降の社畜コミット\n"

for (( i = "$1"; i >= 0; i-- )); do
    DATE=$(date -v -"$i"d "+%Y/%m/%d")

    SYACHIKU_LOG_1=$(git log --pretty=format:"%ad  %an  %s  %h" --date=format:'%H:%M' --since="$DATE 00:00:00" --until="$DATE 7:59:59" | sort -k1)
    SYACHIKU_LOG_2=$(git log --pretty=format:"%ad  %an  %s  %h" --date=format:'%H:%M' --since="$DATE 22:00:00" --until="$DATE 23:59:59" | sort -k1)

    if [ "$SYACHIKU_LOG_1" == "" ] && [ "$SYACHIKU_LOG_2" == "" ]; then
        continue
    fi

    echo "[$DATE]"

    if [ "$SYACHIKU_LOG_1" != "" ]; then
        echo "$SYACHIKU_LOG_1\n"
    fi
    if [ "$SYACHIKU_LOG_2" != "" ]; then
        echo "$SYACHIKU_LOG_2\n"
    fi
done