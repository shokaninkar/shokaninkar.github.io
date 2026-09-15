# Design brief — shokaninkar.github.io

One page, plain HTML + CSS, no JavaScript, no webfonts, under 500 KB. This is the front door: it introduces Ingkar in under a minute and routes readers to the two deep portfolios (engineering, growth).

## Palette (4 colours)

| Token | Hex | Role |
|---|---|---|
| paper | `#F3F4F1` | page ground (cool off-white, not cream) |
| ink | `#141A1F` | headings, body text |
| slate | `#4E5A64` | secondary text, captions |
| moss | `#0E6B52` | accent: links, the route line, the "open to" line |

Contrast (WCAG): ink on paper **15.9:1**; slate on paper **6.6:1**; moss on paper **5.9:1**; paper on ink **15.9:1**; paper on moss **5.9:1**. All ≥ 4.5:1 AA.

Rejected: the amber-on-navy of the engineering portfolio and the cobalt-on-white of the growth one — this page shouldn't pick a side. Rejected the warm-cream + serif + terracotta combination because it is the default "AI personal site" look.

## Type

System stack only: `ui-sans-serif, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif`. Numbers and labels in `ui-monospace, "SF Mono", Menlo, Consolas, monospace`.

| Step | Size | Line height | Use |
|---|---|---|---|
| 1 | 15px / 16px @768px | 1.6 | body |
| 2 | 18px | 1.45 | lede, section intros |
| 3 | 24px | 1.2 | section headings (h2), project names |
| 4 | 36px / 52px @768px | 1.05 | the one h1 |

Labels: 12px monospace, uppercase, 0.08em tracking.

## Section order

1. Header: name, one-line role, nav (four in-page anchors + the two portfolio links)
2. Intro: h1 statement, lede, the "open to" line, headshot (WebP with JPEG fallback)
3. **Route** — the signature element (see below)
4. Two tracks: Engineering | Growth — two columns at 1280px, stacked at 375px, each with three proof points and a button to its portfolio
5. Projects: five, as a definition list (name · what · stack · link)
6. Experience: timeline as a two-column grid (dates | role), one line each
7. Education & skills
8. Contact / footer

## Layout

- 375px: single column, 20px gutters, headshot above the h1 at 160px wide, tracks stacked, timeline dates above roles.
- 1280px: 1040px max-width centred; intro is text 1.4fr / photo 0.6fr; tracks side by side; timeline 140px date column + text.

## Signature element — the Route

A horizontal, CSS-only "route" of the eight places the work happened, in chronological order: Almaty → Dubai → Gurugram → Zürich → Singapore → Accra → Houston → Gambier. Rendered as an ordered list on a single moss-coloured line with a dot per stop and the year underneath. It scrolls horizontally inside its own container on a phone, so the page never scrolls sideways. No JavaScript; the line is a pseudo-element. Every stop is sourced (see content_brief.md §3).

## Deliberately NOT doing

- No hero gradient, no three-icon feature row, no testimonial carousel (the Exolynk reference lives on the growth site, where it has context).
- No stat tiles at the top — the numbers belong next to the work that produced them.
- No dark mode toggle (needs JS); the page respects `prefers-color-scheme` via tokens instead.
- No animation beyond a hover underline and a focus ring.
- No third page, no partials — two files, as the CLAUDE.md constraints require.
