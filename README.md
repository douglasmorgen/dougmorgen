# dougmorgen.com

**Live site:** [https://dougmorgen.com](https://dougmorgen.com)

The Rails marketing and inquiry-intake site for Doug Morgen's SMB automation, Rails, Shopify, integration, and technical consulting work.

## Related projects

| Project | Live site | Source |
| --- | --- | --- |
| Node Stack — full-stack Bun, React, and TypeScript application | [node.dougmorgen.com](https://node.dougmorgen.com) | [douglasmorgen/node](https://github.com/douglasmorgen/node) |
| Tax & Financial Planning — Next.js site with a secure client document portal | [finance.dougmorgen.com](https://finance.dougmorgen.com) | [douglasmorgen/tax-financial-site](https://github.com/douglasmorgen/tax-financial-site) |

## What the application does

- Presents consulting services, selected work, a resume, an FAQ, and contact information.
- Accepts project inquiries from the home page and the dedicated `/start` form.
- Validates inquiries and protects the form with a honeypot, signed submission timing, and IP rate limiting.
- Sends an internal notification and a confirmation email through Action Mailer.
- Provides an HTTP Basic Auth-protected admin area for reviewing inquiries.
- Publishes canonical metadata, structured data, Open Graph tags, `robots.txt`, and a sitemap.

## Stack

- Ruby 3.4.9
- Rails 8.1 with High Voltage for marketing pages
- PostgreSQL
- Tailwind CSS 4
- Hotwire (Turbo and Stimulus) with import maps
- Solid Cache, Solid Queue, and Solid Cable
- RSpec, RuboCop, Brakeman, and Bundler Audit
- Docker and Kamal, with a PostgreSQL 16 production accessory

## Routes

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/` | Home page and quick inquiry form |
| `GET` | `/services` | Consulting services |
| `GET` | `/work` | Selected work and case studies |
| `GET` | `/faq` | Frequently asked questions |
| `GET` | `/about` | About Doug |
| `GET` | `/resume` | Resume |
| `GET` | `/contact` | Contact options and project CTA |
| `GET` | `/blog` | Unindexed placeholder for future notes |
| `GET` | `/start` | Full project inquiry form |
| `POST` | `/inquiries` | Create an inquiry |
| `GET` | `/start/thanks` | Inquiry confirmation page |
| `GET` | `/admin/inquiries` | Protected inquiry list |
| `GET` | `/admin/inquiries/:id` | Protected inquiry detail |
| `GET` | `/up` | Rails health check |

## Local development

### Prerequisites

- Ruby 3.4.9 (also declared in `.ruby-version` and `.tool-versions`)
- PostgreSQL
- Redis, which `bin/dev` starts locally when it is not already running

Install dependencies, prepare the database, and start Rails plus the Tailwind watcher:

```bash
asdf install
asdf exec bundle install
asdf exec bin/rails db:prepare
asdf exec bin/dev
```

The site runs at [http://localhost:3000](http://localhost:3000).

## Environment variables

### Application

- `INQUIRY_NOTIFICATION_EMAIL` — recipient for new-inquiry notifications; defaults to `inquiries@dougmorgen.com`
- `ADMIN_USERNAME` — HTTP Basic Auth username for `/admin/inquiries`
- `ADMIN_PASSWORD` — HTTP Basic Auth password for `/admin/inquiries`
- `MAILER_FROM` — optional sender; defaults to `dougmorgen.com <no-reply@dougmorgen.com>`

### Production infrastructure and email

- `RAILS_MASTER_KEY`
- `DATABASE_URL`
- `POSTGRES_PASSWORD` — password for the Kamal PostgreSQL accessory
- `SMTP_ADDRESS`
- `SMTP_PORT` — defaults to `587`
- `SMTP_DOMAIN` — defaults to `dougmorgen.com`
- `SMTP_USERNAME`
- `SMTP_PASSWORD`
- `KAMAL_REGISTRY_PASSWORD` — GHCR credential used by Kamal

Keep credentials in the ignored `.kamal/secrets` file; do not commit them.

## Testing and checks

Run the RSpec suite:

```bash
asdf exec bundle exec rspec
```

Run the repository's local CI checks (setup, RuboCop, dependency audits, and Brakeman):

```bash
asdf exec bin/ci
```

## Production

The application is built as a Docker image, published to GHCR, and deployed manually with Kamal. The tracked `config/deploy.yml` runs the web container behind the server's reverse proxy, starts Solid Queue inside Puma, and manages PostgreSQL 16 as a persistent accessory. Production releases are intentionally performed by the repository owner rather than by GitHub Actions.
