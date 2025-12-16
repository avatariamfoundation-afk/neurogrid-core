const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NeuroGridCore", function () {
  let neuroGrid;
  let owner;

  beforeEach(async function () {
    [owner] = await ethers.getSigners();

    const NeuroGridCore = await ethers.getContractFactory("NeuroGridCore");
    neuroGrid = await NeuroGridCore.deploy();
    await neuroGrid.waitForDeployment();
  });

  it("should increment case counter when monitoring is requested", async function () {
    await neuroGrid.requestPostOpMonitoring();
    expect(await neuroGrid.caseCounter()).to.equal(1);
  });

  it("should emit PostOpMonitoringRequested event", async function () {
    await expect(neuroGrid.requestPostOpMonitoring())
      .to.emit(neuroGrid, "PostOpMonitoringRequested")
      .withArgs(1, owner.address);
  });

  it("should emit MonitoringResultSubmitted event", async function () {
    await expect(
      neuroGrid.submitMonitoringResult(1, "QmTestHash123")
    )
      .to.emit(neuroGrid, "MonitoringResultSubmitted")
      .withArgs(1, "QmTestHash123");
  });
});

