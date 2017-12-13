# tax-flow

This project is presented as a capstone project for the Certified Ethereum Developer program at Blockchain Hub.

This demonstration ethereum blockchain application taxpayer in a hypothetical municipality that runs on a blockchain. We provide a visualization the flow of his transactions through the tax system in real time

# Installation

## Prerequisites
* yarn: `npm install -g yarn`
* truffle: `npm install -g truffle`
* ganache (Ganache)[http://truffleframework.com/ganache/]

## Installation
* pull down repo
* run `yarn` to install dependencies
* start Ganache desktop client - wait until it starts before proceeding
* run `truffle develop`
* run `compile`
* run `migrate`
* open another tab
* run `npm run dev` 
* a browser window should open. If it gives the 'no accounts ..' warning, just refresh browser

  * Note: ctrl+c to stop npm run dev. You will need to open a new tab and close the old one before running `npm run dev` again


## Workflow

![Worklfow](Workflow.png)