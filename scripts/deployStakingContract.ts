import { ethers } from "hardhat";

async function main() {

  const StakingContract = await ethers.deployContract("StakingContract", ["0x410BDa5ae4B0863cde9C2A3B025d7A675335fA39", 10 , 20, 50, 50]);

  await StakingContract.waitForDeployment();

  console.log(
    `Contract deployed to ${StakingContract.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
