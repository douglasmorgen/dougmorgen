# dougmorgen.com Rails Conventions

This file is the source of truth for code style and architecture decisions in this repo.
Follow these rules unless the user explicitly asks otherwise.

## Core Principles

- Prefer simple, explicit Rails code over clever abstractions.
- Avoid "framework magic" when a direct line of code is clearer.
- Optimize for readability and predictability over DRY purity.
- If a choice is ambiguous, pick the option that is easiest for a new Rails dev to understand.
- Don't rescue standarderror ever
- Never run any `git commit` command in this repository, ever.
- Never add fallback behavior ("fallback paths", "best effort", silent degradation) unless the user explicitly asks for it.
- Never hardcode user-facing AI answers, product facts, or support copy inside service constants or conditional branches. All AI answers must be generated from retrieved data sources (DB records, indexed content, or managed knowledge files), not inline strings in Ruby code.

## Controllers

- Keep `ApplicationController` minimal. Do not put app-specific behavior there.
- Do not add controller-level `rescue` blocks unless explicitly requested.
- Do not silently default required request intent in controller code.
- Keep controller actions straightforward: load/build model, save, render/redirect.
- Do not add concerns for minor logic unless explicitly requested.

## Params and Defaults

- Use strong params with explicit allowed keys.
- Do not rely on enum key ordering (`Model.enums.keys.first`) for behavior.
- If a default is needed, use explicit symbols/values (for example `:manual_upload`), not positional enum logic.
- Prefer model defaults for persistent defaults when appropriate.

## Models

- Put domain formatting and domain logic in models (or plain service objects), not controllers.
- Keep validations explicit and easy to scan.
- Avoid coupling model behavior to presentation concerns.

## Migrations

- All migrations must be reversible.
- Prefer `change` only when Rails can reverse every operation automatically.
- Use explicit `up` and `down` methods for anything Rails cannot reverse safely, including raw SQL, custom indexes, or ambiguous `remove_index` calls.
- When removing indexes, specify enough information for rollback, preferably the index name and the matching `down` operation.

## Views / UX

- Error messages must be user-friendly and action-oriented.
- Avoid internal Rails phrasing like "prohibited this record from being saved".
- Forms should only expose fields users should control.
- Required user inputs must be enforced both ways: browser-level form constraints (`required`, etc.) and server-side validations.
- Hidden fields are acceptable when intent is fixed by UX (for example manual upload source).

## Devise/Auth

- Keep Devise parameter customization in Devise-specific controllers, not `ApplicationController`.
- Keep auth requirements explicit per controller via `before_action :authenticate_user!`.

## AI Extraction Pipeline

- OCR-first, then model extraction.
- Store structured output plus evidence in persisted data.
- Do not add fallback/status complexity unless requested.
- Keep MVP schemas small and explicit.

## Prototype Runtime Policy

- Prototype policy: no fallbacks, no silent defaults, fail fast on missing dependencies or invalid model output.
- Do not add rescue-based fallback paths unless explicitly requested.
- If model or schema validation fails, surface a user-visible error and stop processing.
- Prefer explicit errors over degraded behavior during prototype development.

## Testing and Verification

- Add or update specs for behavior changes.
- Always fix specs alongside code changes in the same task. Do not leave known failing or outdated specs behind.
- Run targeted specs for changed areas before finishing.
- Do not claim behavior without verification when tests can check it.

## Anti-Patterns to Avoid

- Dynamic defaults based on enum order.
- Controller rescues for expected flow control.
- Putting app-specific helper exposure in `ApplicationController`.
- Premature abstractions and indirection without user request.

## PR Checklist

Before opening or merging a PR, confirm:

- `ApplicationController` stayed minimal.
- No new controller `rescue` blocks were added.
- No new fallback/degraded-behavior paths were introduced unless explicitly requested.
- No enum-order defaults were introduced.
- Defaults are explicit (or clearly owned by model defaults).
- Forms only expose user-controlled fields.
- Required fields are enforced both client-side and server-side.
- Error messages are user-friendly.
- Devise customizations live in Devise-specific controllers.
- Migrations are reversible, with explicit `up`/`down` when `change` is not safely reversible.
- Any extraction/pipeline changes keep schema small and explicit.
- Relevant specs were added/updated for behavior changes.
- Specs were updated in lockstep with code changes (no deferred spec fixes).
- Targeted tests were run and pass.

# AGENTS

## LLM Parsing Policy

- Do **not** implement fallback behavior in any LLM-driven code path.
- This includes (but is not limited to):
  - provider fallback (e.g., OpenAI -> Claude or Claude -> OpenAI),
  - model fallback,
  - parser-path fallback (e.g., vision -> OCR -> heuristic fallback chains),
  - silent rescue-based fallback that switches to alternate extraction logic.
- LLM code paths must be single-path and deterministic based on explicit configuration.
- If the configured LLM path fails, surface the failure state instead of routing to fallback parsing logic.

## Git Workflow

- Never run `git commit` (or create commits) from the agent.

## Deploy Workflow

- Never run deploy commands from the agent.
- Specifically, do not run `kamal deploy`, `kamal setup`, or any command that pushes/releases to production.
- The user performs all deploy actions manually.
