# Environment Configuration Policy — NeuroGrid Core

## Rules
- `.env` files are never committed
- `.env.example` is the only reference
- Secrets are injected at runtime only

## Secrets
- Private keys
- API keys
- Oracle credentials

## Enforcement
- Local: `.env`
- CI/CD: GitHub Secrets
- Production: Vault or equivalent

