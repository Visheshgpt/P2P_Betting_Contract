const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
    // console.log(Deploying  Contracts with the account: ${deployer.address});

  const Escrow = await ethers.getContractFactory("Escrow");
  console.log("\nDeploying Escrow...");
  const escrow = await Escrow.deploy();
  await escrow.deployed();
  console.log("Escrow Deployed at...", escrow.address);

  const DummyToken = await ethers.getContractFactory("DummyERC");
  console.log("\nDeploying DummyUSDC...");
  const token = await DummyToken.deploy("USDC", "USDC");
  await token.deployed();
  console.log("DummyUSDC Deployed at...", token.address);

  const DummyToken2 = await ethers.getContractFactory("DummyERC");
  console.log("\nDeploying DummyUSDT...");
  const token2 = await DummyToken2.deploy("USDT", "USDT");
  await token2.deployed();
  console.log("DummyUSDC Deployed at...", token2.address);
  
  const Factory = await ethers.getContractFactory("Factory");
  console.log("\nDeploying Factory...");
  const factory = await Factory.deploy([token.address, token2.address], escrow.address);
  await factory.deployed();
  console.log("Escrow Deployed at...", factory.address);
 

}
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

