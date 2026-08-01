# Contributing

Thanks for your interest in improving **mac-config**. This is a personal macOS
dotfiles repository, but suggestions, fixes, and improvements are welcome.

## Ground rules

- Keep changes focused and portable. Avoid committing machine-specific values
  (absolute paths, project IDs, tokens, or personal identifiers). Use `$HOME`
  and existence checks instead.
- Preserve the startup-performance optimizations in `.zshrc` (lazy loading and
  the `_cache_cmd` helper). If you change them, explain why in the PR.
- One logical change per commit.

## Commit messages

This project follows [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

Format: `<type>(<optional scope>): <description>`

Common types: `feat`, `fix`, `refactor`, `docs`, `chore`, `build`, `ci`, `style`, `test`.

Examples:

```
feat: add install script for symlinking dotfiles
fix(zsh): guard rbenv init behind availability check
docs: document Brewfile usage
```

## Before opening a pull request

1. Check shell syntax:

   ```sh
   zsh -n .zshrc
   ```

2. Lint with [ShellCheck](https://www.shellcheck.net) (CI runs this too):

   ```sh
   shellcheck .zshrc install.sh
   ```

3. Open a new shell to confirm the config loads without errors:

   ```sh
   exec zsh
   ```

## Reporting issues

Open a GitHub issue describing the problem, your macOS version, and the tool(s)
involved. Steps to reproduce are appreciated.
