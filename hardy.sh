#! /usr/bin/env bash

function will::tools::hardy() {
  case "$1" in
    -b|--begin)

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

    -e|--end)

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

    esac
}

will::tools::hardy "$@"
