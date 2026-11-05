#!/bin/bash
# Google AI Pro (5 TB) 全自动控制台 — macOS 首次运行：安装依赖并启动
set -u
cd "$(dirname "$0")" || exit 1
trap 'echo; echo "已退出。"; exit 0' INT TERM

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

title "正在检查 Python 并创建本地虚拟环境 (.venv)..."
PY="$(pick_python)" || {
  echo "❌ 未找到 Python 3.10 或更高版本。"
  echo "   请先安装：brew install python@3.12  或  https://www.python.org/downloads/"
  read -n 1 -s -r -p "按任意键退出..."
  exit 1
}
echo "使用 Python: $PY ($("$PY" -V 2>&1))"

if [ ! -x .venv/bin/python ]; then
  if ! "$PY" -m venv .venv; then
    echo "❌ 创建虚拟环境失败。"
    read -n 1 -s -r -p "按任意键退出..."
    exit 1
  fi
fi

title "正在安装依赖 (fastapi, uvicorn, playwright)..."
./.venv/bin/python -m pip install --upgrade pip >/dev/null 2>&1
if ! ./.venv/bin/python -m pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple; then
  echo "❌ 依赖安装失败，请检查网络后重试。"
  read -n 1 -s -r -p "按任意键退出..."
  exit 1
fi

title "正在启动 Web 控制台 (http://127.0.0.1:8765) ..."
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
read -n 1 -s -r -p "服务已停止，按任意键退出..."
