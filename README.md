# dougmorgen.com (Rails 8 + Tailwind)

Personal consulting site for Doug Morgen with high-conversion lead capture at `/start`.

## Stack

- Ruby 3.4.9
- Rails 8.1
- Tailwind CSS
- PostgreSQL
- RSpec
- High Voltage (static pages)
- Kamal + Docker deployment

## Pages

- `/` Home
- `/services`
- `/work`
- `/about`
- `/blog`
- `/resume`
- `/contact`
- `/start` Lead generation form
- `/start/thanks` Inquiry success page
- `/admin/inquiries` Admin-lite inquiry listing (HTTP basic auth)

## Setup

```bash
asdf exec bundle install
asdf exec ruby bin/rails db:create db:migrate
asdf exec ruby bin/dev
```

## Environment Variables

### Inquiry + Admin

- `INQUIRY_NOTIFICATION_EMAIL`
- `ADMIN_USERNAME`
- `ADMIN_PASSWORD`
- `MAILER_FROM` (optional, defaults to `dougmorgen.com <no-reply@dougmorgen.com>`)

### SMTP (production)

- `SMTP_ADDRESS`
- `SMTP_PORT`
- `SMTP_DOMAIN`
- `SMTP_USERNAME`
- `SMTP_PASSWORD`

## Testing

```bash
asdf exec bundle exec rspec
```

## Deploy (Kamal)

1. Ensure `config/deploy.yml` values are correct.
2. Set secrets for Kamal (`RAILS_MASTER_KEY` + env vars above).
3. Deploy:

```bash
bin/kamal setup
bin/kamal deploy
```
