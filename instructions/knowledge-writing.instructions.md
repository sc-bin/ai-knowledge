---
description: "Use when: 在 knowledge/ 目录下编写或编辑知识笔记时"
applyTo: ["knowledge/**"]
---
# 知识笔记写作规范

## 文件格式
- 使用 `.md` 扩展名
- 文件名用短横线连接：`topic-name.md`
- 必须包含 YAML frontmatter

## Frontmatter 要求
- `topic`：所属领域（必填）
- `category`：子分类（可选）
- `tags`：标签数组（推荐）
- `date`：记录日期（必填）

## 内容规范
- 用列表记录关键信息，便于检索
- 关键信息必须标注：文件路径、版本号、来源链接
- 代码统一用 fenced code block
- 命令统一用 bash fenced block

## 示例
```markdown
---
topic: linux-kernel
category: subsystems/dma
tags: [dma, kernel-6.6, arm64]
date: 2026-06-22
---
# Linux DMA 子系统分析

## 关键文件路径
- drivers/dma/dmaengine.c  — 核心框架
- include/linux/dmaengine.h — 公共接口

## 要点
- DMA 通道通过 dma_request_chan() 申请
- ...
```
