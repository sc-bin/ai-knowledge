# ai-knowledge

AI 协作全知识库 — 在 VS Code Copilot 中使用时，存放规则、知识笔记和可复用提示模板。

## 目录结构

```
ai-knowledge/
├── instructions/        File Instructions — VS Code 自动加载的规则
├── prompts/             斜杠命令 — 可复用提示模板
├── agents/              自定义 Agent 角色
├── knowledge/           知识库 — 按主题分类的笔记
├── references/          外部资源 — URL、命令备忘
├── templates/           知识条目模板
├── setup.sh             一键初始化脚本
└── README.md
```

## 快速开始

```bash
# 1. 克隆项目到 VS Code 提示词路径
git clone <仓库地址> ~/.vscode-server/data/User/prompts

# 2. 完成。VS Code Copilot 会自动识别 instructions/ prompts/ agents/ 下的文件。
```

## 使用方式

### 添加规则
在对话中说：“**添加规则：<规则描述>**”，AI 会自动创建 `.instructions.md` 文件并归类。

示例：
```
添加规则：C 语言函数名用 snake_case，applyTo *.c *.h
添加规则：写 Markdown 文档时标题层级不超过三级
```

### 添加记忆
在对话中说：“**添加记忆：<内容摘要>**”，AI 会在 `knowledge/` 下创建带元数据的知识笔记。

示例：
```
添加记忆：RK3588 的 GPIO 引脚映射关系
添加记忆：Linux 内核 DMA 子系统架构分析
```

### 推送
在对话中说：“**推送**” 或 “**commit 并 push**”，AI 会自动提交并推送到 GitHub。

## 知识条目格式

每条知识笔记使用 YAML frontmatter 标记元数据：

```markdown
---
topic: linux-kernel
category: chips
tags: [gpio, rockchip, rk3588]
date: 2026-06-22
---
# 标题
...
```

## AI 初始化指引

> 以下内容供 AI 在新环境中自动读取和执行。

当用户首次打开本项目并要求初始化时，请执行以下步骤：

1. 检查 `~/.vscode-server/data/User/prompts/` 是否存在
2. 如果不存在，执行 `mkdir -p ~/.vscode-server/data/User/prompts`
3. 如果当前项目不在该路径下，建立符号链接：
   ```bash
   ln -sf "$(pwd)/instructions" ~/.vscode-server/data/User/prompts/instructions
   ln -sf "$(pwd)/prompts" ~/.vscode-server/data/User/prompts/prompts
   ln -sf "$(pwd)/agents" ~/.vscode-server/data/User/prompts/agents
   ```
4. 确认链接生效：`ls -la ~/.vscode-server/data/User/prompts/`
5. 告知用户：规则已生效，可以说"添加规则"或"添加记忆"来使用
