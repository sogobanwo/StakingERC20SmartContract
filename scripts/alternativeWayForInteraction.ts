import { ethers } from "hardhat";

async function main() {
  const tokenAddress = "0x410BDa5ae4B0863cde9C2A3B025d7A675335fA39";
  const StakeToken = await ethers.getContractFactory("StakeToken");
  const stakeToken = StakeToken.attach(tokenAddress);

  const stakingContractAddress = "0x5A44c6547A9d06CC9F87b069397c938FE8838990";
  const StakingContract = await ethers.getContractFactory("StakingContract");
  const stakingContract = StakingContract.attach(stakingContractAddress);

  //   const accounts = await ethers.getSigners()
  //   const signer = accounts[0]

  const balanceOwner = await stakeToken.balanceOf(
    "0xe902aC65D282829C7a0c42CAe165D3eE33482b9f"
  );
  console.log(balanceOwner);

//   const approveToken = await stakeToken.approve(stakingContractAddress, 1000);

//   await approveToken.wait();

//   const depositToWallet = await stakingContract.depositToWallet(200);
//   await depositToWallet.wait();

//   const stake = await stakingContract.stake(200);
//   await stake.wait();

//   const claimRewardToWallet = await stakingContract.claimRewardToWallet()
//   await claimRewardToWallet.wait();

  const withdrawFromWallet = await stakingContract.withdrawFromWallet(20)
  await withdrawFromWallet.wait()

  const balanceOwnerAfterWithdrawal = await stakeToken.balanceOf(
    "0xe902aC65D282829C7a0c42CAe165D3eE33482b9f"
  );
  console.log(balanceOwnerAfterWithdrawal);
}
// //
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
