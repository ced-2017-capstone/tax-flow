Hi folks,
The instructions below are for working with Truffle and a local running testrpc rather than MetaMask or Mist.

npm is a wonderful tool when it works. There seems to be some library configuration issue with cloning my "WorkingTruffleToken" directory, so you are advised to follow the instructions in the truffle slides.


truffle unbox webpack

If you are NOT using MetaMask or Mist Browser then web3.js must be found in the app/javascripts folder as demonstrated here:

https://github.com/professormarek/WorkingTruffleToken/tree/master/app/javascripts


Also, with this standalone configuration, app.js will consider this to be a "fallback" setup and try to connect over RPC port 9545 instead of 8545 so make sure you start testrpc (for example) on port 9545 using the command (in its own terminal window!)


testrpc --port 9545


For convenience you can configure truffle to work by default on port 9545 as demonstrated here:
https://github.com/professormarek/WorkingTruffleToken/blob/master/truffle.js


Then, in a separate terminal window:
truffle compile
truffle migrate
npm run dev


You should then be able to view your running token app by opening up http://localhost:8080
Use the browser's console/inspect functionality to see what is going on. Note: expect a warning about Web3.js:

"No web3 detected. Falling back to..." but you should expect to see a token balance displayed.