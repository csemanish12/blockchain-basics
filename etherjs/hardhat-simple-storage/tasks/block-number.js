const { task } = require("hardhat/config")

task("block-number", "Print the current block number").setAction(
    async(taskArgs, hre) => {
    // async function bloackTask(){}
       // hre - hardhat runtime env , same as require("hardhat")
       const blockNumber = await hre.ethers.provider.getBlockNumber()
       console.log(`current block number ${blockNumber}`)
    }
)

module.exports = {}