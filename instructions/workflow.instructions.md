---
description: "Use when: 用户说'添加规则'、'添加记忆'、'推送'、'commit'时触发。定义 AI 知识库的标准工作流，包括规则创建、知识笔记归档和 git 推送流程。"
---
# AI 知识库工作流

当用户说特定关键词时，按以下流程执行：

> ⚠️ 所有 git 操作都在 `~/.vscode-server/data/User/prompts` 目录下执行（即 ai-knowledge 仓库）。

## 添加规则

触发词：`添加规则`、`创建规则`、`新增规则`、`add rule`

1. 向用户确认：
   - 规则名称（用于文件名）
   - 触发条件（`applyTo` 模式，如 `**/*.c`、`**/*.py` 等）
   - 规则内容要点
2. 将文件写入 `instructions/<规则名>.instructions.md`
3. 模板格式：

```yaml
---
description: "Use when: <触发场景描述>"
applyTo: [<文件匹配模式>]
---
# <规则标题>

- <规则条目1>
- <规则条目2>
```

4. 创建完成后，自动执行 git 提交和推送（无需等待用户说"推送"）：
   - `cd ~/.vscode-server/data/User/prompts`
   - `git add -A`
   - `git commit -m "<规则名>"`
   - `git push`
5. 告知用户已自动完成全部操作

## 添加记忆

触发词：`添加记忆`、`记录一个笔记`、`add memory`、`备忘`、`记下来`

1. 向用户确认知识所属的领域分类（如 `linux-kernel`、`embedded`、`programming-languages` 等）
2. 在 `knowledge/` 下按领域创建子目录（如已存在则使用已有）
3. 创建 `.md` 文件，包含 YAML frontmatter 元数据和正文：

```markdown
---
topic: <领域>
category: <子分类>
tags: [<标签1>, <标签2>]
date: <当前日期>
---
# <标题>
...
```

4. 创建完成后，自动执行 git 提交和推送（无需等待用户说"推送"）：
   - `cd ~/.vscode-server/data/User/prompts`
   - `git add -A`
   - `git commit -m "记忆: <标题>"`
   - `git push`
5. 告知用户已自动完成全部操作

## 推送

触发词：`推送`、`push`、`commit并push`

1. 切换到仓库目录：`cd ~/.vscode-server/data/User/prompts`
2. 检查当前是否有未提交的更改：`git status`
3. 如有未暂存文件，先 `git add -A && git commit -m "<描述>"`
4. 执行 `git push`
