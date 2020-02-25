## Compile the Contract
## compile contract with nodejs console
## open nodejs console
#node 
#> Web3 = require('web3')
#> web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

## Confirm that the web3 object is initialized and can communicate with the blockchain
## using the 'accounts' method on the object
#> web3.eth.accounts

## Compile the Contract
## in nodejs console
## load solidity code from voting.sol from voting-blockchain-dapp
#> code = fs.readFileSync.('voting.sol').toString()
#> solc = require('solc')
#> compiledCode = solc.compile(code)


## Deploy the contract
## create contract object and deploy the contract
## in nodejs console
#> abiDefinition = JSON.parse(compiledCode.contracts[':voting'].interface)
#> VotingContract = web3.eth.contract(abiDefinition)
#> byteCode  = compiledCode.contracts[':voting'].bytecode
#> deployedContract = VotingContract.new(['Bill','Tom','Janice'], {data: byteCode, from: web3.eth.accounts[0], gas: 4700000})
#> deployedContract.address
#> contractInstance = VotingContract.at(deployedContract.address)

## FYI — Interacting with the blockchain costs money. We are specifying how much we are willing to pay for our code to be 
## included in the blockchain through the gas amount above. This amount will be given to the miners so that our code can be
## included in the blockchain.

## Interact with the contract
## in nodejs
#> contractInstance.totalVotesFor.call('Bill')
#Output: BigNumber { s: 1, e: 0, c: [ 0 ] }
#> contractInstance.voteForCandidate('Bill', {from: web3.eth.accounts[0]})
#Ouput: '0x78a713775fc24d56564f2aafb4028405966f2185c1b0f9fe0a549c02e9187d8f'
#> contractInstance.voteForCandidate('Tom', {from: web3.eth.accounts[0]})
#Output: '0x852f07e466523f210710517f041566d60f34264418a0d116cb14d20dedd2bc2a'
#> contractInstance.voteForCandidate('Tom', {from: web3.eth.accounts[0]})
#Output: '0xcde90cafd005823a95b545be7dc1690b7d448b0fa9dd8581d903aca76e230592'
#> contractInstance.totalVotesFor.call('Tom').toLocaleString()
#Output: '2'

## Create a simple lightweight web GUI
## in nodejs console
## In your nodejs console, execute contractInstance.address to 
## get the address at which the contract is deployed and change 
## the line below to use your deployed address
## see index.js and index.html