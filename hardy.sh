#! /usr/bin/env bash

function will::tools::hardy::usage() {
  echo"
usage:
  hardy.sh <-s,--start [n] | -d,--die>

summary:
  hardy is a utility that spawns and
  destroys difficult processes.

  internally, it reads from 
  '/dev/urandom', forever, making 
  endless 'shasum's of the endless, 
  random input.

  luckily, hardy can die.
  this has the effect of saving your
  computer from sounding like it's 
  entering the atmosphere at low-
  earth orbit.

examples:
  # start 5 difficult processes
  hardy.sh --start 5

  # stop being difficult
  # (kill all the spawned processes)
  hardy.sh --die
"
}

function will::tools::hardy() {
  case "$1" in
    -s|--start)

      local count="$2"
      if [ -z "$2" ]; then
        local count="1"
      fi

      echo "[starting]"
      for i in $(seq 1 "$count"); do
        echo "$i/$count"
        cat /dev/urandom|shasum -a 512256 &
      done
    ;;

    -d|--die)

      local pids="$(pgrep -f "cat /dev/urandom")"
      if [ -z "$pids" ]; then
        echo "[already dead]"
      else
        echo "[dying]"
        echo "$pids"
        for i in ${pids}; do
          kill "$i"
        done
      fi
    ;;

    *)
      will::tools::hardy::usage
    ;;
    esac
}

will::tools::hardy "$@"
