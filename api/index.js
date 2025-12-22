const express = require('express');
const rateLimit = require('express-rate-limit');
const { PythonShell } = require('python-shell');
require('dotenv').config();
const config = require('../config/app');
const { startP2PNode } = require('../integration/p2p');
const Agent = require('../models/Agent');

const app = express();
app.use(express.json());

const limiter = rateLimit({
  windowMs: 60 * 1000,
  max: config.rateLimit,
  message: 'Too many requests, please try again later.',
});
app.use(limiter);

const agents = {};

app.post('/agent/task', (req, res) => {
  try {
    const { agentId, task } = req.body;
    if (!agentId || !task) return res.status(400).json({ error: 'Agent ID and task required' });
    if (!agents[agentId]) agents[agentId] = new Agent(agentId);
    agents[agentId].assignTask(task);
    res.json({ status: 'Task assigned' });
  } catch (err) {
    res.status(500).json({ error: 'Task assignment failed' });
  }
});

app.post('/compute/route', (req, res) => {
  try {
    const { task, data } = req.body;
    if (!task || !data) return res.status(400).json({ error: 'Task and data required' });
    res.json({ result: 'Routed for processing' });
  } catch (err) {
    res.status(500).json({ error: 'Routing failed' });
  }
});

app.post('/research/verify', (req, res) => {
  try {
    const { computation, data } = req.body;
    if (!computation || !data) return res.status(400).json({ error: 'Computation and data required' });
    res.json({ receipt: 'Verification receipt' });
  } catch (err) {
    res.status(500).json({ error: 'Verification failed' });
  }
});

startP2PNode().catch(console.error);

app.listen(config.port, () => console.log(`NeuroGrid API listening on port ${config.port}`));
