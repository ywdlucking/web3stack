// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  // const Card = await hre.ethers.getContractFactory("Card");
  const card = await hre.ethers.deployContract("Card");
  await card.waitForDeployment();
  const addr = await card.getAddress();
  console.log(
    `Card deployed to ${addr}`
  );
  await card.mint();
  const token_uri = await card.tokenURI(0)
  console.log(`Card tokenURI to ${token_uri}`)
  const image = await card.getImage(0)
  console.log(`Card getImage to ${image}`)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
