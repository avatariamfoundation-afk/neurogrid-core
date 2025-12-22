# NeuroGrid-Core API Documentation

## Overview
NeuroGrid API supports autonomous agents, decentralized compute routing, and scientific research verification on BNB Chain, enabling post-operative care intelligence.

## Endpoints

### POST /agent/task
Assign a task to an autonomous AI agent.

- **URL:** `/agent/task`
- **Method:** POST
- **Body:**
  ```json
  {
    "agentId": "string",
    "task": "string"
  }
