---
description: "Run an SEO audit on a website. Fetches robots.txt, sitemap, homepage, and inner pages. Produces a prioritised findings report with fix instructions."
agent: seo-specialist
subtask: true
---

# SEO Audit: $ARGUMENTS

Perform a full technical SEO audit of the website at $ARGUMENTS.

## Audit Scope

1. **Fetch and analyse:**
   - `/robots.txt`
   - `/sitemap.xml` (and `/sitemap_index.xml` if exists)
   - Homepage HTML
   - 2-3 inner pages

2. **Check:**
   - robots.txt rules (is crawling allowed?)
   - XML sitemap (valid? includes all pages?)
   - Canonical URLs (self-referencing?)
   - Meta robots tags (noindex?)
   - Title tags and meta descriptions
   - H1-H6 heading hierarchy
   - Structured data (JSON-LD schemas)
   - Mobile viewport
   - Internal linking
   - HTTP status codes

3. **Produce a report** with:
   - Summary table (Critical / Warning / Passed)
   - Top 5 issues with exact fix instructions
   - Recommended next steps
