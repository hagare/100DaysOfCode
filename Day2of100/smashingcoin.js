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
    // add nonce parameter to constructor method for use in proofOfWork() method
    this.nonce = 0;
    }
  computeHash(){
    // crypto-js library used to caluclate hash of each block.
    // output of sha256 is a number, use toString() method to convert to string
    // return SHA256(this.index + this.precedingHash + this.timestamp + JSON.stringify(this.data)).toString();

    // updated computHash() method to include nonce random value required for proofOfWork() method
     return SHA256(this.index + this.precedingHash + this.timestamp + JSON.stringify(this.data) + this.nonce).toString();
    }

// Add Proof Of Work method
// create method proofOfWork() that uses a simple algorithm to identify a number (difficulty property)
// so that every block has leading zeros that correspond to this difficulty level
// the higher the "difficulty" the more time it takes to mine new blocks
// add random nonce value to every hashed block so that when rehashing takes place the difficulty 
// level restriction can still be met
proofOfWork(difficulty){
      while(this.hash.substring(0, difficulty) !==Array(difficulty + 1).join("0")){
          this.nonce++;
          this.hash = this.computeHash();
      }        
  }
 }
 

// Create block class called CryptoBlockchain class which controls the chain
class CryptoBlockchain{
  // Instantiate blockchain 
  constructor(){
    // property is an array of blocks
    this.blockchain = [this.startGenesisBlock()];
    // updated constructor() method to include difficulty value required for proofOfWork() method
    this.difficulty = 4;
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
   // addNewBlock(newBlock){
   // newBlock.precedingHash = this.obtainLatestBlock().hash;
   // newBlock.hash = newBlock.computeHash();
   // this.blockchain.push(newBlock);

   // updated addNewBlock() method to use the proofOfWork() method
    addNewBlock(newBlock){
      newBlock.precedingHash = this.obtainLatestBlock().hash;
      //newBlock.hash = newBlock.computeHash(); 
      newBlock.proofOfWork(this.difficulty);       
      this.blockchain.push(newBlock);
  }
 
  
// Verify Blockchain's Integrity
// checkChainValidity method verifies if two consecutive blocks point to each other
// genesis block hardcoded will not be checked (index 0 in array)

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
  }


// Instantiate new blockchain smashingCoin
let smashingCoin = new CryptoBlockchain();
// Create new blocks with addNewBlock method
console.log("smashingCoin mining in progress... "); // let user know program is running
smashingCoin.addNewBlock(new CryptoBlock(1, "02/26/2020", {sender: "Iris Ljesnjanin", recipient: "Cosima Mielke", quantity: 50}));
smashingCoin.addNewBlock(new CryptoBlock(2, "02/27/2020", {sender: "Vitaly Friedman", recipient: "Ricardo Gimenes", quantity: 100}) );
smashingCoin.addNewBlock(new CryptoBlock(3, "02/27/2020", {sender: "Hagar Coder", recipient: "Janae Maker", quantity: 1000}));
// print out blockchain parameters for 4 blocks
console.log(JSON.stringify(smashingCoin, null, 4));

 // Check chain validity
// console.log("Is Chain Valid?: "+ smashingCoin.checkChainValidity());