#!/bin/bash
# Google AI Pro (5 TB) 全自动控制台 — macOS 日常启动
set -u
cd "$(dirname "$0")" || exit 1
trap 'echo; echo "已退出。"; exit 0' INT TERM

if [ ! -x .venv/bin/python ]; then
  echo "======================================================================"
  echo "  首次使用请先双击运行：1_首次运行_安装依赖并启动.command"
  echo "======================================================================"
  read -n 1 -s -r -p "按任意键退出..."
  exit 1
fi

echo "======================================================================"
echo "  正在启动 Google AI Pro (5 TB) 全自动控制台..."
echo "  控制台地址: http://127.0.0.1:8765"
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
read -n 1 -s -r -p "服务已停止，按任意键退出..."
