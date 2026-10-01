#!/bin/bash
# 服务器初始化脚本（OpenCloudOS 9.6）——安装 Docker / Nginx / 基础工具
# 用法: sudo bash deploy/server-setup.sh
set -e

echo "==> [1/4] 安装 Docker（腾讯云内网镜像源）"
dnf install -y yum-utils
yum-config-manager --add-repo https://mirrors.cloud.tencent.com/docker-ce/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "==> [2/4] 配置 Docker 镜像加速（腾讯云内网）"
mkdir -p /etc/docker
cat > /etc/docker/daemon.json <<'EOF'
{ "registry-mirrors": ["https://mirror.ccs.tencentyun.com"] }
EOF
systemctl enable --now docker
docker compose version

echo "==> [3/4] 安装 Nginx"
dnf install -y nginx
systemctl enable nginx

echo "==> [4/4] 部署目录"
mkdir -p /opt/industry

echo "ALL DONE: docker $(docker --version) / nginx 已就绪"
