const { expect } = require("chai");
const { ethers } = require("hardhat");
const Agent = require("../models/Agent");

describe("NeuroGrid-Core Basic Tests", function () {
  let neuroGrid, neuroToken;

  beforeEach(async function () {
    const MedToken = await ethers.getContractFactory("MedToken");
    neuroToken = await MedToken.deploy();
    await neuroToken.deployed();

    const NeuroGrid = await ethers.getContractFactory("NeuroGrid");
    neuroGrid = await NeuroGrid.deploy(neuroToken.address);
    await neuroGrid.deployed();
  });

  it("should create and manage an agent instance", function () {
    const agent = new Agent("agent01");
    agent.assignTask("Sample task");
    expect(agent.tasks.length).to.equal(1);
    expect(agent.status).to.equal('active');
  });

  it("should deploy contracts", async function () {
    expect(neuroToken.address).to.not.be.undefined;
    expect(neuroGrid.address).to.not.be.undefined;
  });
});
