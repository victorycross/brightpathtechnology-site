# brightpathtechnology.io — DNS consolidation to Netlify DNS

Goal: move the authoritative DNS from Squarespace to Netlify DNS so Netlify auto-manages
records **and** wildcard SSL. Recreate every record below in the Netlify DNS zone, then
switch nameservers at Squarespace. **Do not flip nameservers until every record below
exists in Netlify** — missing/incorrect records break email or subdomains.

Netlify nameservers (set these at Squarespace last): `dns1.p09.nsone.net`,
`dns2.p09.nsone.net`, `dns3.p09.nsone.net`, `dns4.p09.nsone.net`

---

## Already in the Netlify zone (no action)
| Type | Name | Value |
|------|------|-------|
| NETLIFY | @ (apex) | brightpathtechnology.netlify.app  *(auto wildcard SSL)* |
| NETLIFY | www | brightpathtechnology.netlify.app |

## Microsoft 365 email — CRITICAL, copy exactly
| Type | Name | Value | TTL |
|------|------|-------|-----|
| MX | @ | `brightpathtechnology-io.mail.protection.outlook.com` (priority **0**) | 1 hr |
| TXT | @ | `v=spf1 include:spf.protection.outlook.com -all` | 1 hr |
| TXT | @ | `MS=ms73926376` | 1 hr |
| TXT | @ | `MS=ms86699595`  *(confirm name in Squarespace UI)* | 1 hr |
| TXT | `_dmarc` | `v=DMARC1; p=quarantine; rua=mailto:david@brightpathtechnology.io; pct=100; adkim=s; aspf=s` | 1 hr |
| CNAME | `selector1._domainkey` | `selector1-brightpathtechnology-io._domainkey.papercutscafe.q-v1.dkim.mail.microsoft` | 1 hr |
| CNAME | `selector2._domainkey` | `selector2-brightpathtechnology-io._domainkey.papercutscafe.q-v1.dkim.mail.microsoft` | 1 hr |
| CNAME | `autodiscover` | `autodiscover.outlook.com` | 1 hr |

## Domain / cert verification
| Type | Name | Value |
|------|------|-------|
| TXT | `actalis` | `actalis-dcv=7y8bvS4XtJpob7l7D88S2Ua` |
| TXT | `_github-pages-challenge-victorycross` *(confirm full name)* | `d3294e468886ec438cf46434b2f891` |

## App subdomains (other live projects — keep)
| Type | Name | Value | Host |
|------|------|-------|------|
| A | `advisors` | `76.76.21.21` | Vercel |
| A | `docs` | `76.76.21.21` | Vercel |
| A | `techassist` | `76.76.21.21` | Vercel |
| CNAME | `techassist-v2` | `cname.vercel-dns.com` | Vercel |
| CNAME | `dungeon` | `cname.vercel-dns.com` | Vercel |
| CNAME | `aiautomate` | `d658d79630f360fd.vercel-dns-017.com` | Vercel |
| CNAME | `geoguesser` | `deae49aecf9a8d32.vercel-dns-016.com` | Vercel |
| CNAME | `budgetportfolio` | `black-grass-0cd9cce00.1.azurestaticapps.net` | Azure |
| CNAME | `history` | `victorycross.github.io` | GitHub Pages |
| CNAME | `fitness` | `victorycross.github.io` | GitHub Pages |
| CNAME | `cleaner` | `victorycross.github.io` | GitHub Pages |
| CNAME | `brightpath-risk-tracker` *(confirm name)* | `victorycross.github.io` | GitHub Pages |

## DROP — Lovable (retired)
| Type | Name | Value |
|------|------|-------|
| A | `lineage` | `185.158.133.1` |
| TXT | `_lovable.lineage` | `lovable_verify=…` |
| A | `securitybarometer` | `185.158.133.1`  *(currently a stale record in the Netlify zone — delete)* |

---

## Cutover order (zero-downtime)
1. Add every "keep/migrate" record above to the Netlify DNS zone.
2. Verify the Netlify zone matches this sheet (especially the 8 email rows).
3. Netlify auto-provisions the wildcard cert (it controls the zone) — wait for "Active".
4. At Squarespace → Domain Nameservers, replace the current nameservers with the four
   Netlify nameservers above. (This is the only irreversible step; reversible by switching back.)
5. Verify mail flow + each subdomain after propagation.
