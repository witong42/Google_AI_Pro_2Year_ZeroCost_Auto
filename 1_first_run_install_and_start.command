#!/bin/bash
# Google AI Pro (5 TB) full-auto console — first run on macOS: install deps and start
set -u
cd "$(dirname "$0")" || exit 1
trap 'echo; echo "Exited."; exit 0' INT TERM

title() {
  echo "======================================================================"
  echo "  $1"
  echo "======================================================================"
}

pick_python() {
  for c in python3.13 python3.12 python3.11 python3.10 python3; do
    if command -v "$c" >/dev/null 2>&1; then
      if "$c" -c 'import sys; sys.exit(0 if sys.version_info >= (3, 10) else 1)' 2>/dev/null; then
        command -v "$c"
        return 0
      fi
    fi
  done
  return 1
}

title "Checking Python and creating a local virtualenv (.venv)..."
PY="$(pick_python)" || {
  echo "❌ Python 3.10 or newer not found."
  echo "   Install it first: brew install python@3.12  or  https://www.python.org/downloads/"
  read -n 1 -s -r -p "Press any key to exit..."
  exit 1
}
echo "Using Python: $PY ($("$PY" -V 2>&1))"

if [ ! -x .venv/bin/python ]; then
  if ! "$PY" -m venv .venv; then
    echo "❌ Could not create the virtualenv."
    read -n 1 -s -r -p "Press any key to exit..."
    exit 1
  fi
fi

title "Installing dependencies (fastapi, uvicorn, playwright)..."
./.venv/bin/python -m pip install --upgrade pip >/dev/null 2>&1
if ! ./.venv/bin/python -m pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple; then
  echo "❌ Dependency install failed, check the network and retry."
  read -n 1 -s -r -p "Press any key to exit..."
  exit 1
fi

title "Starting the web console (http://127.0.0.1:8765) ..."
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
