#!/bin/bash
# ai-knowledge 一键初始化脚本
# 将项目中的 instructions/ prompts/ agents/ 链接到 VS Code Copilot 提示词路径

set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROMPTS_DIR="$HOME/.vscode-server/data/User/prompts"

echo "=========================================="
echo "  ai-knowledge 初始化"
echo "=========================================="
echo ""
echo "项目路径: $PROJECT_DIR"
echo "VS Code 提示词路径: $PROMPTS_DIR"
echo ""

mkdir -p "$PROMPTS_DIR"

for dir in instructions prompts agents; do
    target="$PROJECT_DIR/$dir"
    link="$PROMPTS_DIR/$dir"

    if [ ! -d "$target" ]; then
        echo "⚠️  $target 不存在，跳过"
        continue
    fi

    # 备份已存在的真实目录（非符号链接）
    if [ -d "$link" ] && [ ! -L "$link" ]; then
        mv "$link" "${link}.bak.$(date +%s)"
        echo "📦  备份原有 $dir → ${dir}.bak.*"
    fi

    # 删除旧链接
    rm -f "$link"
    ln -s "$target" "$link"
    echo "✅  已链接 $link → $target"
done

echo ""
echo "=========================================="
echo "  初始化完成！"
echo "=========================================="
echo ""
echo "现在可以在 VS Code 中使用以下功能："
echo "  - 对 AI 说「添加规则」来创建新规则"
echo "  - 对 AI 说「添加记忆」来记录知识笔记"
echo "  - 对 AI 说「推送」来提交到 GitHub"
echo ""
echo "检查链接状态："
ls -la "$PROMPTS_DIR/"
