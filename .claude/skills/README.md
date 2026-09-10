# Personal Claude Code skills

Each subdirectory here is one skill (`<skill-name>/SKILL.md` plus any
supporting files). `init.sh` symlinks every subdirectory into
`~/.claude/skills/` so these skills are available on every machine.

They are symlinked individually rather than symlinking the whole
`~/.claude/skills/` directory, so they coexist with `~/.claude/skills/synced/`
(skills synced from claude.ai).

To add a skill: create `.claude/skills/my-skill/SKILL.md`, commit it, and
re-run `./init.sh` (or `ln -nfs "$PWD/.claude/skills/my-skill" ~/.claude/skills/`).
