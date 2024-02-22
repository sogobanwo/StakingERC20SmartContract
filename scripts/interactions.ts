import { ethers } from "hardhat";

async function main() {

  const stakingContractAddress = "0x5A44c6547A9d06CC9F87b069397c938FE8838990";
  const StakingContract = await ethers.getContractAt(
    "IStakingContract",
    stakingContractAddress
  );

  const tokenAddress = "0x410BDa5ae4B0863cde9C2A3B025d7A675335fA39";

  const stakeToken = await ethers.getContractAt("IStakeToken", tokenAddress);

  const accounts = await ethers.getSigners()
  const signer = accounts[0]

  
  const balanceOwner = await stakeToken.balanceOf("0xe902aC65D282829C7a0c42CAe165D3eE33482b9f");
    console.log(balanceOwner)

  const approveToken = await stakeToken.connect(signer).approve(
    stakingContractAddress,
    10
  );

  await approveToken.wait();

  const depositToWallet = await StakingContract.connect(signer).depositToWallet(200);
  await depositToWallet.wait();

  const stake = await StakingContract.connect(signer).stake(100);
  await stake.wait();
  const getStake = await StakingContract.getTotalStake();
  console.log(getStake);
}
// // 
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
