// Create a blockchain using cryptojs
// Create CryptoBlock class
// Prerequisites node, npm, and crypto-js
// based on tutorial from https://www.smashingmagazine.com/2020/02/cryptocurrency-blockchain-node-js/

const SHA256 = require('crypto-js/sha256');
class CryptoBlock{
  // Create CryptoBlock constructor method and assign parameters index, timestamp, data, precedingHash, and hash
  // Create computeHash method that calculates the hash of block based on its properties
  constructor(index, timestamp, data, precedingHash=" "){
    this.index = index;
    this.timestamp = timestamp;
    this.data = data;
    this.precedingHash = precedingHash;
    this.hash = this.computeHash();
    }
  computeHash(){
    // crypto-js library used to caluclate hash of each block.
    // output of sha256 is a number, use toString() method to convert to string
    return SHA256(this.index + this.precedingHash + this.timestamp + JSON.stringify(this.data)).toString();
    }
  }

// Create block class called CryptoBlockchain class which controls the chain
class CryptoBlockchain{
  // Instantiate blockchain 
  constructor(){
    // property is an array of blocks
    this.blockchain = [this.startGenesisBlock()];
  }
  // Creating the genesis block. initiate block using the CryptoBlock class and pass the parmeters
  startGenesisBlock(){
    return new CryptoBlock(0, "02/26/2020", "Initial Block in the Chain", "0");
  }

  // Get the latest block.
  // ensure the hash of current block points to the hash of the previous block
  // to maintain the chain's integrity
  obtainLatestBlock(){
    return this.blockchain[this.blockchain.length - 1];
  }
  addNewBlock(newBlock){
    newBlock.precedingHash = this.obtainLatestBlock().hash;
    newBlock.hash = newBlock.computeHash();
    this.blockchain.push(newBlock);
  }
}

// Instantiate new blockchain smashingCoin
let smashingCoin = new CryptoBlockchain();
// Create nwe blocs with addNewBlock method
smashingCoin.addNewBlock(new CryptoBlock(1, "02/26/2020", {sender: "Iris Ljesnjanin", recipient: "Cosima Mielke", quantity: 50}));
smashingCoin.addNewBlock(new CryptoBlock(2, "02/27/2020", {sender: "Vitaly Friedman", recipient: "Ricardo Gimenes", quantity: 100}) );
smashingCoin.addNewBlock(new CryptoBlock(3, "02/27/2020", {sender: "Hagar Coder", recipient: "Janae Maker", quantity: 1000}));
// print out blockchain parameters for 4 blocks
console.log(JSON.stringify(smashingCoin, null, 4));

// Verify Blockchain's Integrity
// checkChainValidity method verifies if two consecutive blocks point to each other
// genesis block hardcoded will not be checked (index 0 in array)
checkChainValidity(){
        for(let i = 1; i < this.blockchain.length; i++){
            const currentBlock = this.blockchain[i];
            const precedingBlock= this.blockchain[i-1];
// any anomalies indicate blockchain has been compromised and method returns false
          if(currentBlock.hash !== currentBlock.computeHash()){
              return false;
          }
// otherwise method return true
          if(currentBlock.precedingHash !== precedingBlock.hash)
            return false;
        }
        return true;
    }

