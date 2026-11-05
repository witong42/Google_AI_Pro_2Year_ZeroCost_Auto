#!/bin/bash
# Google AI Pro (5 TB) full-auto console — daily start on macOS
set -u
cd "$(dirname "$0")" || exit 1
trap 'echo; echo "Exited."; exit 0' INT TERM

if [ ! -x .venv/bin/python ]; then
  echo "======================================================================"
  echo "  First run: double-click 1_first_run_install_and_start.command"
  echo "======================================================================"
  read -n 1 -s -r -p "Press any key to exit..."
  exit 1
fi

echo "======================================================================"
echo "  Starting the Google AI Pro (5 TB) zero-cost 2-year full-auto console..."
echo "  Console URL: http://127.0.0.1:8765"
echo "======================================================================"
(
  for _ in $(seq 1 120); do
    if curl -s -o /dev/null "http://127.0.0.1:8765"; then
      open "http://127.0.0.1:8765"
      break
    fi
    sleep 0.5
  done
) &

./.venv/bin/python app.py
read -n 1 -s -r -p "Server stopped, press any key to exit..."
