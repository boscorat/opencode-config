---
description: "Marketing playbook for launching and promoting open-source projects. Contains platform-specific best practices, content templates, timing guidelines, and case studies. USE FOR: launch templates, platform strategy, content creation, marketing playbook, case studies. DO NOT USE FOR: code implementation, burnout prevention, monetisation strategy."
license: MIT
compatibility: "opencode >= 1.0.0"
metadata:
  owner: open-source-launch-promoter
  version: "1.0.0"
  last_updated: "2026-07-03"
---

# Open Source Marketing Playbook

A comprehensive guide for launching and promoting open-source projects across multiple platforms.

## Platform Best Practices

### GitHub

**Optimisation checklist:**
- [ ] Compelling README with clear value proposition (first 3 lines critical)
- [ ] Screenshots/GIFs showing the tool in action
- [ ] Badges: license, build status, coverage, version
- [ ] Quick start guide (copy-paste ready)
- [ ] CONTRIBUTING.md for potential contributors
- [ ] GitHub Topics (5 max, relevant keywords)
- [ ] GitHub Discussions enabled for Q&A
- [ ] Releases with clear changelogs

**Launch timing:** Tuesday-Thursday, 9 AM GMT

**Case study:** ripgrep gained traction through:
1. Clear benchmark comparisons in README
2. Active Reddit/HN engagement
3. Consistent release cadence
4. Responding to every issue quickly

### LinkedIn

**Content types that work:**
1. **Personal story posts** (highest engagement): "I built X because Y"
2. **Technical deep dives**: "How I solved Z problem"
3. **Milestone celebrations**: "100 stars in 1 week — thank you"
4. **Community highlights**: "Best contribution I received"

**Tone:** Professional but personal. First-person narrative. Avoid corporate speak.

**Hashtags (3-5 max):**
- #opensource #python #fintech #privacy #dataprivacy
- #buildinpublic #indiedev #sideproject

**Timing:** Tuesday-Thursday, 8-10 AM or 12-1 PM GMT

**Engagement tactics:**
- Comment on 3-5 relevant posts daily (10 min/day)
- Connect with people who engage with your content
- Share in relevant groups (Python Developers, Fintech, Privacy)

**Template:**
```
I just open-sourced [PROJECT] — [ONE-LINE DESCRIPTION].

Here's why I built it: [PROBLEM]

And how it works: [SOLUTION]

[1-2 MINUTE DEMO GIF OR SCREENSHOT]

GitHub: [LINK]

#opensource #[RELEVANT_HASHTAGS]
```

### Reddit

**Rules of thumb:**
- Read each subreddit's rules BEFORE posting
- Never post to more than 1-2 subs per week
- Engage authentically — Reddit detects and penalizes self-promotion
- Comment on others' posts before promoting your own
- "Show-and-Tell" format works best

**Timing:** Tuesday-Thursday, 9-11 AM GMT (peak activity)

**Subreddits by project type:**

| Project Type | Subreddits |
|--------------|------------|
| Python library | r/Python, r/learnpython, r/pypi |
| Privacy tool | r/privacy, r/privacytoolsIO |
| Developer tool | r/programming, r/devops, r/commandline |
| UK finance | r/UKPersonalFinance, r/HMRC |
| General | r/SideProject, r/InternetIsBeautiful |

**Template:**
```
Title: [SHOW R/SUBREDDIT] I built [PROJECT] — [BRIEF DESCRIPTION]

Body:
- What it does: [1-2 sentences]
- Why I built it: [PROBLEM]
- How to use it: [QUICK START]
- GitHub: [LINK]

Feedback welcome!
```

### Bluesky

**Character:** Conversational, authentic, less formal than LinkedIn.

**Content strategy:**
- **Threads**: Break longer content into 3-5 post threads
- **Quick updates**: "Just pushed v1.1 with X feature"
- **Questions**: "What's your biggest pain point with Y?"
- **Behind-the-scenes**: "Building in public — today's challenge"

**Engagement tactics:**
- Reply to conversations about your domain
- Follow and engage with privacy/security/dev accounts
- Use hashtags sparingly (2-3 max): #opendev #python #privacy

**Timing:** Anytime — Bluesky has less algorithmic pressure

**Template:**
```
Just launched [PROJECT] — [DESCRIPTION]. 🧵

Why? [PROBLEM]

How it works: [SOLUTION]

[DEMO GIF]

GitHub: [LINK]

#opendev #python
```

### Mastodon

**Character:** Thoughtful, privacy-conscious, community-oriented.

**Key instances for developers:**
- techhub.social (general tech)
- hachyderm.io (tech, welcoming)
-fosstodon.org (open source)
- mastodon.online (general)

**Content strategy:**
- Cross-post from Bluesky (but adjust tone — Mastodon is more thoughtful)
- Engage with privacy-focused conversations
- Share technical insights, not just promotions

**Timing:** Varies by instance — generally 9 AM-12 PM GMT

**Template:**
```
[PROJECT] is now open source.

[DESCRIPTION]

Built with [TECH]. 100% offline. No accounts needed.

GitHub: [LINK]

#opensource #privacy #python
```

### Dev.to

**Content types:**
1. **Launch announcements**: "I just launched X — here's the story"
2. **Tutorials**: "How to use X to solve Y"
3. **Deep dives**: "Building X: technical decisions and trade-offs"

**Optimisation:**
- Use tags: #opensource, #python, #webdev, #beginners
- Include code snippets
- Add cover image
- Series format works well for multi-part content

**Timing:** Tuesday-Thursday, 8 AM GMT

**Template:**
```markdown
---
title: "I built [PROJECT] — [DESCRIPTION]"
published: true
tags: opensource, python, privacy
---

# The Problem

[Describe the problem you solved]

# The Solution

[Describe your approach]

# Quick Start

```bash
[Installation commands]
```

# What's Next

[Future plans]

GitHub: [LINK]
```

### Hacker News

**Character:** Technical, minimal, evidence-based. HN hates marketing speak.

**What works:**
- "Show HN: [PROJECT] — [technical description]"
- Focus on technical innovation, not features
- Be ready to answer detailed technical questions
- Respond to every comment

**What doesn't work:**
- Marketing language
- Overclaiming
- Ignoring criticism

**Timing:** Tuesday-Thursday, 10 AM-12 PM GMT

**Template:**
```
Show HN: [PROJECT] — [TECHNICAL DESCRIPTION]

[1-2 paragraphs explaining the technical approach]

[Link to GitHub]

[Brief note on what you'd like feedback on]
```

### Friendica

**Character:** Community-focused, Facebook-like but privacy-respecting.

**Best for:** Non-technical audiences (openstan target users)

**Content strategy:**
- Join relevant groups (UK finance, privacy, self-assessment)
- Share user stories, not technical details
- Focus on benefits: "No data leaves your machine"

**Timing:** Evenings and weekends (non-professional audience)

**Template:**
```
[PROJECT] — [USER-FRIENDLY DESCRIPTION]

✓ [BENEFIT 1]
✓ [BENEFIT 2]
✓ [BENEFIT 3]

Free, open source, and your data stays on your computer.

Learn more: [LINK]
```

### Stoat (Discord Alternative)

**Character:** Real-time community support, helpful, responsive.

**Best for:** Scaling community support for openstan

**Setup tips:**
- Start with GitHub Discussions (lower overhead)
- Only create Stoat server if >50 active users
- Create channels: #general, #support, #feature-requests, #showcase

**Moderation:**
- Set clear rules
- Respond within 24 hours
- Pin important messages

## Content Templates

### Launch Announcement (Universal)

```markdown
# [PROJECT] is now open source

## What it does
[1-2 sentences]

## Why I built it
[Problem statement]

## Key features
- [Feature 1]
- [Feature 2]
- [Feature 3]

## Quick start
```bash
[Installation]
```

## Links
- GitHub: [LINK]
- Documentation: [LINK]
- [Other relevant links]

## What's next
[Future plans]

Feedback welcome!
```

### Demo GIF Script

1. Open terminal/application
2. Show the problem (e.g., raw PDF)
3. Run the tool
4. Show the result (e.g., anonymised PDF)
5. Keep it under 60 seconds
6. Use GIF at 1280x720 or 1920x1080

### Email to Mailing Lists

```
Subject: [PROJECT] - [BRIEF DESCRIPTION]

Hi [NAME/TEAM],

I'm [YOUR NAME], and I built [PROJECT] to solve [PROBLEM].

[BRIEF DESCRIPTION]

It's open source under [LICENSE]: [GITHUB LINK]

Would you be interested in featuring it in [NEWSLETTER/PUBLICATION]?

Happy to provide more details or a demo.

Best,
[YOUR NAME]
```

## Timing Guidelines

### Launch Day Schedule

**Pre-launch (1-2 weeks before):**
- Tease on Bluesky/Mastodon: "Working on something new..."
- Prepare all content
- Set up GitHub Discussions

**Launch day (Tuesday-Thursday recommended):**

| Time (GMT) | Platform | Action |
|------------|----------|--------|
| 9:00 AM | GitHub | Create release, push code |
| 9:30 AM | Bluesky | Launch thread |
| 10:00 AM | LinkedIn | Personal story post |
| 10:30 AM | Reddit | Show-and-Tell (1-2 subs) |
| 11:00 AM | Hacker News | Show HN |
| 12:00 PM | Dev.to | Launch article |
| 1:00 PM | Mastodon | Cross-post |
| 2:00 PM | Email | Outreach to relevant lists |

**Post-launch (1-4 weeks):**
- Week 1: Daily engagement, respond to feedback
- Week 2: Follow-up content (learnings, early adoption stories)
- Week 3: Technical deep dive
- Week 4: Roadmap based on community feedback

### Ongoing cadence

- **Bluesky/Mastodon**: 2-3 posts per week
- **LinkedIn**: 1 post per week
- **Reddit**: 1 post per 2 weeks (max)
- **Dev.to**: 1 article per month
- **GitHub**: Regular releases, responsive issues

## Case Studies

### ripgrep

**What worked:**
1. Clear benchmark comparisons in README
2. Active engagement on Reddit/HN
3. Consistent release cadence
4. Responding to every issue quickly
5. Technical excellence spoke for itself

**Key lesson:** Technical merit + active community engagement = sustainable growth

### fzf

**What worked:**
1. Solving a real pain point (fuzzy finding)
2. Excellent documentation
3. Integration with popular tools (vim, git)
4. Patient, consistent development

**Key lesson:** Solve a real problem well, and the community will find you

### starship

**What worked:**
1. Beautiful screenshots in README
2. Cross-platform support
3. Active Reddit/HN presence
4. Regular feature additions based on community feedback

**Key lesson:** Visual appeal + community responsiveness = rapid adoption

### direnv

**What worked:**
1. Solving a specific pain point (environment variables)
2. Excellent documentation
3. Patient development over years
4. Growing with the community

**Key lesson:** Long-term commitment + solving real problems = sustainable success

## Success Metrics (Realistic)

**Week 1:**
- 10-50 GitHub stars
- 5-20 social media engagements
- 1-5 issues/discussions opened

**Month 1:**
- 50-200 GitHub stars
- 20-100 social media engagements
- 5-20 issues/discussions opened
- 1-3 external mentions (blog posts, newsletters)

**Month 3:**
- 100-500 GitHub stars
- 50-200 social media engagements
- 10-50 issues/discussions opened
- 5-10 external mentions
- 1-3 contributors

**Remember:** These are ranges, not guarantees. Focus on quality engagement over vanity metrics.

## Common Mistakes to Avoid

1. **Posting to too many Reddit subs at once** — Reddit penalizes this
2. **Using marketing speak on Hacker News** — HN hates it
3. **Ignoring feedback** — Respond to every comment, even criticism
4. **Inconsistent posting** — Better to post 2x/week consistently than 10x once
5. **Only promoting, never engaging** — Participate in communities before promoting
6. **Forgetting non-technical audiences** — openstan needs different messaging than parser
7. **Using Twitter/X or Meta platforms** — Respect user preferences for European alternatives
8. **Promising features you haven't built** — Be honest about current state

## Quick Reference

### Platform Selection Matrix

| Project Type | Primary Platforms | Secondary | Avoid |
|--------------|-------------------|-----------|-------|
| Python library | GitHub, Reddit, HN | Dev.to, Bluesky | LinkedIn (unless fintech) |
| Privacy tool | GitHub, Reddit, Mastodon | Bluesky, HN | Twitter/X |
| Desktop app | GitHub, LinkedIn, Reddit | Friendica, Bluesky | Hacker News |
| UK finance | GitHub, LinkedIn, Reddit | Friendica, Stoat | Hacker News |

### Content Length Guide

| Platform | Ideal Length | Max |
|----------|--------------|-----|
| Bluesky | 100-300 chars | 300 |
| Mastodon | 100-500 chars | 500 |
| LinkedIn | 150-300 words | 1000 |
| Reddit | 200-500 words | 40000 |
| Dev.to | 800-1500 words | Unlimited |
| HN | 100-300 words | Unlimited |
