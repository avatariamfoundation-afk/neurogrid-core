# NeuroGrid-Core API Documentation

## Overview
NeuroGrid API supports autonomous agents, decentralized compute routing, and scientific research verification on BNB Chain for post-operative care.

## Endpoints

### POST /agent/task
Assign a task to an autonomous AI agent.

- URL: `/agent/task`
- Method: POST
- Request Body: `{ "agentId": "string", "task": "string" }`
- Response Success: `{ "status": "Task assigned" }`
- Possible Errors: 400 (bad input), 500 (server errors), 429 (rate limited)

### POST /compute/route
Routes a computational task within the NeuroGrid network.

- URL: `/compute/route`
- Method: POST
- Request Body: `{ "task": "string", "data": "string" }`
- Response Success: `{ "result": "Routed for processing" }`
- Possible Errors: 400 (bad input), 500 (server errors)

### POST /research/verify
Verifies scientific computations for reproducibility.

- URL: `/research/verify`
- Method: POST
- Request Body: `{ "computation": "string", "data": "string" }`
- Response Success: `{ "receipt": "Verification receipt" }`
- Possible Errors: 400 (bad input), 500 (server errors)

## Setup
- Start server: `node api/index.js`
- Use Postman or curl for testing.

## Security
- Encrypted data transmission.
- Rate limited requests.
- Audit logs for compliance.
