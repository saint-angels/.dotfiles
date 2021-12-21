#!/usr/bin/env bash
#
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -r|--restore) restore=1 ;;
        -k|--kill) kill=1 ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if [[ $restore -eq 1 ]]
then
    # echo "Where to deploy: $target"
  sudo tcdel enp5s0 --all
else
    if [[ $kill -eq 1 ]]
    then
        sudo tcset enp5s0 --loss 100% --direction incoming
        sudo tcset enp5s0 --loss 100%
    else
        sudo tcset enp5s0 --rate 1000Kbps --loss 10% --delay 500ms --direction incoming
        sudo tcset enp5s0 --rate 1000Kbps --loss 10% --delay 500ms
    fi
fi
