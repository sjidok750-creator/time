# CLAUDE.md

This file provides guidance to AI assistants (Claude and others) working in this repository.

## Project Overview

**Repository**: `sjidok750-creator/time`

This repository is currently in its initial state with no committed source code. The project name suggests a time-related application (e.g., time tracking, scheduling, timers, or time management tooling). This file should be updated as the project takes shape.

## Repository State

- No source files committed yet
- No language, framework, or toolchain established
- No CI/CD pipelines configured
- No test infrastructure in place

When the first code is added, update the sections below to reflect actual conventions, commands, and structure.

## Development Workflow

### Branch Naming

Branches should follow a consistent pattern:

```
<type>/<short-description>
```

Examples:
- `feature/add-timer-api`
- `fix/correct-timezone-offset`
- `chore/setup-ci`

### Commit Messages

Write clear, imperative-mood commit messages:

```
Add interval tracking to timer service
Fix off-by-one error in duration calculation
Refactor clock abstraction for testability
```

Avoid vague messages like "fix stuff" or "wip".

### Pull Requests

- Keep PRs focused on a single concern
- Include a short summary of what changed and why
- Reference related issues when applicable

## Code Conventions

These are placeholder conventions. Update them once the language and framework are decided.

### General

- Prefer readability over cleverness
- Write self-documenting code; add comments only where intent is not obvious
- Keep functions small and single-purpose
- Avoid over-engineering — build for current requirements, not hypothetical future ones

### Error Handling

- Handle errors explicitly; do not silently swallow them
- Propagate errors with meaningful context
- Validate inputs at system boundaries (user input, external APIs, file I/O)

### Testing

- Write tests alongside new features, not after the fact
- Test behavior, not implementation details
- Aim for fast, deterministic tests

## Project Structure (Template)

Once source code is added, document the layout here. A typical structure might look like:

```
time/
├── src/           # Application source code
├── tests/         # Test files
├── docs/          # Documentation
├── scripts/       # Build and utility scripts
├── .github/       # GitHub Actions workflows
├── CLAUDE.md      # This file
└── README.md      # User-facing documentation
```

## Common Commands

Populate these once the toolchain is established:

```bash
# Install dependencies
# <command here>

# Run development server
# <command here>

# Run tests
# <command here>

# Lint / format
# <command here>

# Build
# <command here>
```

## AI Assistant Guidelines

When working in this repository:

1. **Read before writing** — understand existing code before suggesting or making changes
2. **Stay focused** — only change what was asked; avoid unrelated refactoring or "improvements"
3. **No speculative features** — do not add error handling, fallbacks, or abstractions for scenarios that don't exist yet
4. **Minimal footprint** — prefer editing existing files over creating new ones
5. **Security first** — never introduce command injection, SQL injection, XSS, or other OWASP vulnerabilities
6. **Confirm before destructive actions** — deleting files, force-pushing, resetting branches, or modifying shared infrastructure requires explicit user confirmation
7. **Update this file** — when significant new patterns, commands, or conventions are established, update CLAUDE.md to reflect them

## Notes for Future Updates

When this project gains real content, update CLAUDE.md with:

- Exact language version and runtime requirements
- Framework and key library choices with rationale
- Actual directory structure and what each folder contains
- Working `make` or `npm`/`cargo`/etc. commands
- Test strategy (unit, integration, e2e)
- Environment variable requirements (use `.env.example` as reference)
- CI/CD pipeline overview and how to interpret failures
- Deployment process or environment targets
