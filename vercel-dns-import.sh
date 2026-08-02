#!/usr/bin/env bash
# OPTIONAL — only needed if you switch nameservers to Vercel (full DNS consolidation).
# Populate Vercel DNS for brightpathtechnology.io BEFORE switching nameservers.
#
# NOT added here (Vercel handles automatically):
#   - @ (apex) and www  -> assigned to the brightpathtechnology-site project
#   - advisors, docs, techassist, dungeon, geoguesser, maple
#     -> already their own Vercel projects, auto-served once Vercel owns DNS
#   - Lovable records    -> intentionally dropped (retired)
set -e
D=brightpathtechnology.io

# --- Microsoft 365 email (critical) ---
vercel dns add $D @ MX brightpathtechnology-io.mail.protection.outlook.com 0
vercel dns add $D @ TXT "v=spf1 include:spf.protection.outlook.com -all"
vercel dns add $D _dmarc TXT "v=DMARC1; p=quarantine; rua=mailto:david@brightpathtechnology.io; pct=100; adkim=s; aspf=s"
vercel dns add $D selector1._domainkey CNAME selector1-brightpathtechnology-io._domainkey.papercutscafe.q-v1.dkim.mail.microsoft
vercel dns add $D selector2._domainkey CNAME selector2-brightpathtechnology-io._domainkey.papercutscafe.q-v1.dkim.mail.microsoft
vercel dns add $D autodiscover CNAME autodiscover.outlook.com

# --- Non-Vercel subdomains (keep where they are) ---
vercel dns add $D budgetportfolio CNAME black-grass-0cd9cce00.1.azurestaticapps.net   # Azure
vercel dns add $D history CNAME victorycross.github.io                                 # GitHub Pages
vercel dns add $D fitness CNAME victorycross.github.io                                 # GitHub Pages
vercel dns add $D cleaner CNAME victorycross.github.io                                 # GitHub Pages
vercel dns add $D _github-pages-challenge-victorycross TXT "d3294e468886ec438cf46434b2f891"

# --- Other Vercel deployments not assigned as project domains ---
vercel dns add $D aiautomate CNAME d658d79630f360fd.vercel-dns-017.com
vercel dns add $D techassist-v2 CNAME cname.vercel-dns.com

# --- Optional verification TXTs (harmless to keep) ---
vercel dns add $D actalis TXT "actalis-dcv=7y8bvS4XtJpob7l7D88S2Ua"

# --- Confirm-then-add (names were truncated in the Squarespace UI) ---
# vercel dns add $D brightpath-risk-tracker CNAME victorycross.github.io
# vercel dns add $D @ TXT "MS=ms86699595"

echo "Done. Verify:  vercel dns ls $D"
echo "Then set nameservers at Squarespace to: ns1.vercel-dns.com and ns2.vercel-dns.com"
