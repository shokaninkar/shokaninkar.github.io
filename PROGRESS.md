# PROGRESS.md — shokaninkar.github.io (IPHS 400 wk4 lab)

Last updated: 2026-09-15

## Done
- Part 5.1 — `inputs/` assembled: 6 resumes, 3 portfolio PDFs, Exolynk reference letter, side-projects xlsx, `github-profile.json`, `github-repos.json`, `github-other-repos.json`. Git-ignored.
- Part 5.2 — repo `CLAUDE.md` written with the hard constraints; `.nojekyll` created; `inputs/` and `.venv/` added to `.gitignore`.
- Part 5.3a — `content_brief.md`: every fact cited to an `inputs/` file; 7 items in the UNSOURCED section awaiting confirmation. Mirrored to `~/career/PROFILE.md` for reuse by the `/resume` skill.
- Part 5.3b — `design_brief.md`: 4-colour palette with contrast ratios, system type scale, section order, the "route" signature element, and what was rejected.
- Part 5.3c — `index.html` + `style.css` built. No JS (JSON-LD only), no webfonts, no inline styles, one h1, semantic sections, alt text, skip link, focus rings, dark-mode tokens, WebP headshot with JPEG fallback (32 KB total).
- Part 5.3d/e — `verify.sh` written and passing (36 checks: files, constraints, placeholders, heading order, assets, anchors, meta lengths, OG tags, JSON-LD, page weight, HTTP 200s). Rendered and inspected at 375 px and 1280 px.
- Part 3.6 — cmdlog hook installed at `.claude/hooks/log-bash.sh` + `.claude/settings.json` (fires after a session restart).
- Global: `~/.claude/CLAUDE.md` (read-everything / no-fabrication / deliverable-format / scope rules) and `~/.claude/skills/resume/SKILL.md`; `~/career/{jobs,applications}/` created for the parallel-application workflow.

## Files created / changed
`index.html` `style.css` `headshot.webp` `headshot.jpg` `.nojekyll` `.gitignore` `CLAUDE.md` `content_brief.md` `design_brief.md` `verify.sh` `PROGRESS.md` `.claude/settings.json` `.claude/hooks/log-bash.sh` `inputs/*` (ignored)

## Live
- https://shokaninkar.github.io — repo renamed to `shokaninkar.github.io`, pushed, Pages built from `main` `/`, HTTPS enforced (2026-09-15 19:47 UTC). All 7 UNSOURCED items resolved; site updated.

## Next 3 steps
1. ~~Rename the repo~~ **Done.** Restart Claude Code in this folder so the cmdlog hook starts recording (`notes/cmdlog.txt`).
   ~~`gh repo rename so Pages serves it at the root: `gh repo rename shokaninkar.github.io` (from inside this folder), then `git push -u origin main`, then enable Pages: `gh api -X POST repos/shokaninkar/shokaninkar.github.io/pages -f build_type=legacy -f 'source[branch]=main' -f 'source[path]=/'`. Wait ≤10 min, tick Enforce HTTPS.
2. ~~Confirm the 7 UNSOURCED items~~ **Done** — see the Resolved section of `content_brief.md`. One open item: dates for the Tetr Brand Ambassador role.
3. **Remaining lab deliverables:** `notes/insights_2026-09-15.md` (3 friction patterns from `/insights`), restart the session so `notes/cmdlog.txt` fills, `.claude/skills/teach/SKILL.md` + `docs/self-learning-guide_<date>.md` (Part 6), `notes/reflection.md`, then run `/web-design-guidelines` and `/seo-audit` and save to `notes/audit_<date>.md`.
