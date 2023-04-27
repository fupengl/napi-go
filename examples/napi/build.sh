#!/bin/bash

# 自动获取Node.js头文件路径
NODE_INCLUDE_DIR="$(node -p 'require("node-addon-api").include')"
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to get Node.js include path"
    exit 1
fi

# 定义变量
GO_ADDON_NAME="addon"
GO_ADDON_FILE="$GO_ADDON_NAME.go"
CPP_ADDON_NAME="addon"
CPP_ADDON_FILE="$CPP_ADDON_NAME.cpp"
CPP_ADDON_HEADER="$CPP_ADDON_NAME.h"
OUTPUT_FILE="$CPP_ADDON_NAME.node"

# 编译Golang代码为C库
go build -buildmode=c-shared -o "$GO_ADDON_NAME.so" "$GO_ADDON_FILE"

# 编译C++代码并链接Golang库
g++ -I"$NODE_INCLUDE_DIR" -I/usr/local/include/node -o "$OUTPUT_FILE" -shared "$CPP_ADDON_FILE" -L. -l"$GO_ADDON_NAME" -pthread -lm -ldl -std=c++11

# 清理中间文件
rm "$GO_ADDON_NAME.so"

# 复制C++头文件到当前目录
cp "$CPP_ADDON_HEADER" .
