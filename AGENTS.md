# AGENTS.md 

## Guidelines
- Always use `caveman` skill to communicate, `caveman-review` to review, `caveman-commit` to generate commit messages and `caveman-compress` to make less verbose documents and comments

## Rules
- Follow `asnsible-lint` rules
- Each role should be atomic and idempotent
- Each playbook should be idempotent and easy to setup without a bunch of boolean flags that control their roles -- it has no sense, cuz' I'd use --tags flag instead
