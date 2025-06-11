require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
   networks:{
    ganache:{
      url:"HTTP://127.0.0.1:7545",
      accounts:["0xe7664b9b2558892d7320fb75a0102988042f52952be056eec1e094b8955647b6"]
    }
  }
};
