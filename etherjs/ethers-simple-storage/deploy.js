// deploy a contract ? wait for it to be deployed
// http://0.0.0.0:8545

const ethers = require("ethers");
const fs = require("fs-extra");

async function main() {
  const privateKey =
    "0x978fb1037abbcbc98eca81aba24fb75f01dcc3fd4bef9cab0c3a8c6b3a0ddcba";
  const host = "HTTP://127.0.0.1:7545";
  const provider = new ethers.JsonRpcProvider(host);
  const wallet = new ethers.Wallet(privateKey, provider);
  console.log("wallet:", wallet);

  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf8"
  );

  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("deploying please wait");
  const contract = await contractFactory.deploy(); // stop here! Wait for contract to deploy
  console.log("contract=",contract);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
