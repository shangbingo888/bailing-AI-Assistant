#!/bin/bash
# 本地打包部署产物（方案 A：前端 dist + 后端源码 + 部署配置）
# 用法: 先完成前端构建，再执行 bash deploy/pack.sh
set -e
cd "$(dirname "$0")/.."

if [ ! -d frontend/dist ]; then
  echo "错误: frontend/dist 不存在，请先执行 cd frontend && npm run build"
  exit 1
fi

tar -czf industry-deploy.tar.gz \
  --exclude='__pycache__' \
  --exclude='*.pyc' \
  --exclude='frontend/node_modules' \
  --exclude='.git' \
  backend \
  docker \
  frontend/dist \
  docker-compose.yml \
  docker-compose.prod.yml \
  deploy

ls -lh industry-deploy.tar.gz
echo "打包完成。上传命令: scp industry-deploy.tar.gz <用户>@81.70.199.173:/opt/"
