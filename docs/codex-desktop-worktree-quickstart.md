# Codex Desktop Worktree 快速上手

`git worktree` 可以让同一个 Git 仓库同时出现在多个目录里。对于 Codex Desktop 来说，这意味着你可以保留当前主工作区不动，同时再打开一个独立目录，用来处理新需求、修 Bug 或做实验。

这篇文档面向新手。你会完整走一遍流程：创建 worktree、在 Codex Desktop 中打开它、在隔离环境里工作，以及在结束后清理它。

## worktree 解决了什么问题？

如果你只有一个工作目录，平时就会频繁来回切换分支。遇到下面这些情况时，这种方式会比较别扭：

- 主分支里还有未提交的改动
- 你想让 Codex 处理另一个任务，但不想打扰当前工作
- 你需要同时对比两个分支的内容

有了 worktree，每个任务都可以拥有自己的目录和自己的分支。

## 前置条件

开始前，请确认：

- 已安装 Git
- 当前目录本身就是一个 Git 仓库
- 你知道怎样在 Codex Desktop 中打开本地目录

## 先建立一个直观理解

你可以把它理解成这样：

- 原来的项目目录保持不变
- Git 再创建一个新的工作目录，并让它对应另一个分支
- 两个目录共享同一份仓库历史，所以它不是你手动复制了一整份项目

## 一步一步演示

### 1. 先查看当前仓库状态

在当前项目目录里运行：

```bash
git status
git branch --show-current
```

这一步主要是确认两件事：

- 当前是否有未提交的改动
- 当前目录正在使用哪个分支

如果这个目录就是你的主工作区，那就保持它不动。我们接下来不是切走它，而是额外创建一个新的工作区。

### 2. 创建一个新的 worktree

用一条命令同时创建新目录和新分支：

```bash
git worktree add .worktrees/feature-demo -b feature/demo
```

这条命令的含义是：

- `.worktrees/feature-demo` 是新的工作目录
- `-b feature/demo` 表示创建一个名为 `feature/demo` 的新分支

如果 `.worktrees` 这个目录还不存在，Git 会自动帮你创建。

### 3. 进入新的 worktree

```bash
cd .worktrees/feature-demo
git status
git branch --show-current
```

现在你已经进入了新的工作区。你应该能看到，这个目录使用的是 `feature/demo` 分支，而原来的目录仍然停留在它原本的分支上。

这正是 worktree 的核心价值：两个目录可以同时存在，你不用在一个目录里反复执行 `git checkout`。

### 4. 在 Codex Desktop 中打开这个目录

在 Codex Desktop 里打开刚创建的目录：

```text
.worktrees/feature-demo
```

从这里开始，Codex 会把它当成一个普通项目目录来处理。你可以：

- 让 Codex 在这个分支上实现新功能
- 在这个独立工作区里运行测试
- 保持原来的主工作区完全不受影响

这种方式特别适合下面这些场景：

- 主目录里已经有一个 Codex 会话正在工作
- 你想为另一个任务再开一个新的 Codex 会话
- 你不想因为切分支打断当前上下文

### 5. 在新工作区里正常开发

进入 worktree 之后，你的 Git 操作和平时没有区别：

```bash
git status
git add .
git commit -m "feat: add demo change"
```

真正的区别只在于目录隔离。主目录和 worktree 目录是两份彼此独立的工作副本。

### 6. 需要时随时回到原工作区

原来的项目目录仍然可用，你可以很自然地在两个目录之间切换：

- 原目录处理当前主任务
- worktree 目录处理新任务

这也是为什么 worktree 通常比在单目录里反复切换分支更舒服。

### 7. 工作完成后清理 worktree

当你不再需要这个额外工作区时，先离开该目录，再执行移除：

```bash
cd ../..
git worktree remove .worktrees/feature-demo
```

如果这个分支也已经合并完成，或者你确定不再需要，还可以继续删除分支：

```bash
git branch -d feature/demo
```

这里建议优先使用 `-d`，而不是 `-D`，除非你明确知道自己要强制删除。

## 为什么它很适合和 Codex Desktop 配合使用？

Codex Desktop 是按“你打开的目录”来工作的。Git worktree 正好可以为每个任务提供一个干净、独立的目录。

这样你就能：

- 保留一个稳定的主工作区
- 再开一个目录专门做实验或开发新分支
- 避免无关的未提交改动互相干扰

对于新手来说，一个很好记的心智模型是：

`一个任务 = 一个目录 = 一个分支`

## 常见问题

### worktree 是不是完整复制了一份仓库？

不是通常意义上的“整仓复制”。它确实会生成一个新的工作目录，但底层仍然共享同一份 Git 对象库。你可以把它理解成“同一个仓库的另一个 checkout”，而不是你手动复制了一整份项目。

### worktree 和 branch 是一回事吗？

不是。branch 是一条开发分支，worktree 是一个绑定到分支上的工作目录。

通常它们会这样配合使用：

- 创建一个分支
- 为这个分支创建一个 worktree
- 在这个目录里完成开发

### 删除 worktree 会不会把分支一起删掉？

不会。`git worktree remove` 只会移除工作目录，分支本身仍然存在。除非你额外执行删除分支的命令，否则分支不会消失。

### 什么情况下不一定需要 worktree？

下面这些情况里，你可能不一定需要它：

- 你一次只处理一个任务
- 你不介意在同一个目录里来回切分支
- 你的仓库很小，工作流程也很简单

## 常用命令汇总

```bash
git status
git branch --show-current
git worktree add .worktrees/feature-demo -b feature/demo
cd .worktrees/feature-demo
git status
git branch --show-current
git worktree remove .worktrees/feature-demo
git branch -d feature/demo
```

## 一句话总结

如果你想让 Codex Desktop 在一个新分支上工作，又不影响当前目录，就创建一个 Git worktree，并把那个新目录当作独立工作区打开。
