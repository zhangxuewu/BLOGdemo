const {ethers}=require("hardhat");
async function deploy() {
    const Twitter=await ethers.getContractFactory("Twitter");//合约工厂
    const twitter=await Twitter.deploy();
    await twitter.waitForDeployment();//等待合约部署完成
const address=await twitter.getAddress();
    console.log(address);
    
}
deploy()