class Agent {
  constructor(id, type = 'autonomous') {
    if (!id) throw new Error('Agent ID required');
    this.id = id;
    this.type = type;
    this.capabilities = ['inference', 'routing', 'verification'];
    this.status = 'idle';
    this.tasks = [];
    this.auditLog = [];
  }

  assignTask(task) {
    this.tasks.push(task);
    this.status = 'active';
    this.auditLog.push({ action: 'task assigned', task, timestamp: new Date().toISOString() });
  }

  executeTask() {
    if (!this.tasks.length) throw new Error('No tasks assigned');
    const task = this.tasks.shift();
    if (!this.tasks.length) this.status = 'idle';
    this.auditLog.push({ action: 'task executed', task, timestamp: new Date().toISOString() });
    return `Executed: ${task}`;
  }

  toJSON() {
    return {
      id: this.id,
      type: this.type,
      capabilities: this.capabilities,
      status: this.status,
      tasks: this.tasks,
      auditLog: this.auditLog,
    };
  }
}

module.exports = Agent;
