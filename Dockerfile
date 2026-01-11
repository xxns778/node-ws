FROM node:20-alpine3.20

# 建议使用 /app 目录，/tmp 在某些环境下会有权限限制
WORKDIR /app

# 复制必要文件
COPY index.js package.json ./

# 暴露端口
EXPOSE 3000

# 合并所有安装指令，确保下载的是正确的 WARP 二进制文件
RUN apk update && apk add --no-cache bash openssl curl wget ca-certificates && \
    npm install && \
    wget -O /usr/local/bin/warp-plus github.com && \
    chmod +x /usr/local/bin/warp-plus

# 启动逻辑：启动 WARP -> 延迟 5 秒 -> 启动节点
CMD ["sh", "-c", "nohup /usr/local/bin/warp-plus -b 127.0.0.1:10000 --gool >/dev/null 2>&1 & sleep 5 && node index.js"]
