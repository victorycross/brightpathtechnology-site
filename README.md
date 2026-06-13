# BrightPath Technology — Website

Rebranded static site for **brightpathtechnology.io**. White background, deep-navy mark (`#1A2D52`), black text, Poppins + Lato. No build step — plain HTML/CSS, deploys as-is.

## Structure

```
index.html                     Hub / landing page
brand.css                      Shared styles (sub-pages)
persona-x/                     Persona-x platform page
tusc-website/                  Toronto Urban Scooter Community
solution-intake-review/        Governance triage tool (preserved, fully functional)
  ├─ index.html
  ├─ src/intake-form.html      Live intake + routing tool
  └─ docs/process/executive-overview.html
_redirects                     Off-domain redirects (foundation, david-martin)
netlify.toml                   Static config: no build, publish root
```

Off-domain properties are handled by `_redirects`:
- `/brightpath-foundation/*` → `https://brightpathfoundation.ca/`
- `/david-martin-website/*` → `https://david-martin.ca/`

## Deploy

This is a **static site — there is no build command.** Three options:

1. **Netlify drag-and-drop** (fastest): Netlify → your site → Deploys → drag this folder onto the upload area. Publishes instantly with no build.
2. **Connect this repo to Netlify**: New site from Git → pick this repo. `netlify.toml` sets `command = ""` and `publish = "."`, so Netlify serves it as static.
3. **Netlify CLI**: `netlify deploy --prod --dir=. --no-build`

> Note: the previous Netlify project had a `pnpm run build` command configured in its UI that fails for a static site. If reusing that project, clear the build command (Site settings → Build & deploy → Build command = empty) or use drag-and-drop.

## Brand

- Deep Navy `#1A2D52` · Ink `#111111` · Paper `#FFFFFF`
- Headings **Poppins** (300), body **Lato** (300/400)
- Logo: overlapping-circles mark, inline SVG (`#bp-mark` symbol) in every page

© 2026 BrightPath Technologies. Toronto, Ontario, Canada.
