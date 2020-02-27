Day 2 of 100

2/25/20
Using js to create cryptocurrency called smashing coin

Nodejs tutorial for simple crytocurrency called smashing coin.
tutorial: https://www.smashingmagazine.com/2020/02/cryptocurrency-blockchain-node-js/.

blockchain is a distributed public ledger technology
blocks connected to each otehr to create a chain

# Create smashingcoin.js
Create CryptoBlock class

# insall crytpo-js JavaScript library
> npm install --save crypto-js

# Create blockchain
## Create block with required parameters and output hash
## Create method for genesis block
## Create method for obtaining latest block
## Create method to add new block which has preceding hash and new block adds to the chain

# Test the Blockchain
## Create new instance of CryptoBlockchain() method. Our currency is smashingcoin.js
## use method addNewBlock to create blocks to chain
## output 4 hashes in chain

# Verify Blockchain's Integrity
>>> once a block has been added to the chain it cannot be changed without invalidating the integrity of the rest of the chain
## verify blockchain integrity

# Add Proof of Work
>>> increase the difficulty entailed in mining or adding new blocks to the blockchain
## Create a simple algorithm that deters people from generating new blocks easily or spamming the blockchain
## Update code with nonce and proofOfWork() parameters/methods as necessary