# MultiWallet - smart contract

This smart contract distributes tokens that are sent into it to multiple wallets by defined share

## Deployment:

1. Edit .secret and put there a wallet mnemonic phrase (24 words) - you need to have some gas on it
2. Register on polygonscan.com, bscscan.com etc. and create your new API keys
3. Edit .apikey_* files and add your api keys on the first line of each file (* means block explorer name, e.g.: polygonscan, bscscan ...)
4. edit ./scripts/deploy.js and set variables
5. Install dependencies and run deploy script:
```console
yarn install
./deploy.sh
```

## Usage:

- function *addWallet*
-- parameters: wallet address, share percentage (2 decimals)
-- example: addWallet(0x123456789, 5012) - adds wallet that gets 50,12% share of every token that comes into this contract

- function *send*
-- parameters: token address, amount
-- example: send(0x987654321, 10500000000000000000) - sends 10.5 tokens with token address 0x9887654321 into this contract and it will be sent to all wallets by their defined share

- array *Wallet*
-- parameters: wallet address, share percentage (2 decimals)
-- lists all defined wallets and their percentage shares in this contract
