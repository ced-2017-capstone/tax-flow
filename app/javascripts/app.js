// Import the page's CSS. Webpack will know what to do with it.
import '../stylesheets/app.css'
import '../stylesheets/force-graph.css'

// Import libraries we need.
import {
  default as Web3
} from 'web3'
import {
  default as contract
} from 'truffle-contract'

// Import our contract artifacts and turn them into usable abstractions.
import taxCollectionArtifacts from '../../build/contracts/TaxCollection.json'
import departmentArtifacts from '../../build/contracts/Department.json'
import invoiceArtifacts from '../../build/contracts/Invoice.json'

var TaxCollector = contract(taxCollectionArtifacts)
var Department = contract(departmentArtifacts)
var Invoice = contract(invoiceArtifacts)

var collectorAccounts, departmentAccounts, invoiceAccounts
var collectorAccount, departmentAccount, invoiceAccount

window.Collector = {

  setStatus: function (message) {
    var status = document.getElementById('collector-status')
    status.innerHTML = message
  },
  payDeparment: function () {
    var self = this;

    var collector;
  },
  start: function () {
    var self = this
    TaxCollector.setProvider(web3.currentProvider)

    web3.eth.getAccounts(function (err, accs) {
      if (err != null) {
        alert('There was an error fetching Collectionaccounts.')
        return
      }

      if (accs.length == 0) {
        alert('There are no Collection accounts')
        return
      }
      console.log('got accounts:', accs)
      collectorAccounts = accs
      collectorAccount = collectorAccounts[0]
      self.refreshBalance()
    })
  },

  refreshBalance: function () {
    var self = this

    var collector
    TaxCollector.deployed().then(function (instance) {
      collector = instance
      return collector.getBalance.call(collectorAccount, {
        from: collectorAccount
      })
    }).then(function (value) {
      var balanceElement = document.getElementById('department-balance')
      balanceElement.innerHTML = value.valueOf()
    }).catch(function (e) {
      console.log(e)
      self.setStatus('Error getting collections balance; see log.')
    })
  }
}

window.Department = {
  start: function () {
    var self = this
    Department.setProvider(web3.currentProvider);

    web3.eth.getAccounts(function (err, accs) {
      if (err != null) {
        self.setStatus('There was an error fetching Department accounts.')
        return
      }

      if (accs.length == 0) {
        self.setStatus('There are no Department accounts')
        return
      }
      console.log('got dept accounts:', accs)
      departmentAccounts = accs
      departmentAccount = departmentAccounts[0]
      self.refreshBalance()
    })
  },
  setStatus: function (message) {
    var status = document.getElementById('department-status')
    status.innerHTML = message
  },
  showInvoices: function () {},
  showBalance: function () {},
  refreshBalance: function () {
    var self = this

    var dept
    Department.deployed().then(function (instance) {
      dept = instance
      return dept.getBalance.call(departmentAccount, {
        from: departmentAccount
      })
    }).then(function (value) {
      var balanceElement = document.getElementById('department-balance')
      balanceElement.innerHTML = value.valueOf()
    }).catch(function (e) {
      console.log(e)
      self.setStatus('Error getting department balance; see log.')
    })
  },
  registerSupplier: function () {},
  deregisterSupplier: function () {},
  registerInvoice: function () {},
  deregisterInvoice: function () {}
}

window.Invoice = {
  start: function () {
    var self = this
    Invoice.setProvider(web3.currentProvider)

    web3.eth.getAccounts(function (err, accs) {
      if (err != null) {
        alert('There was an error fetching Invoice accounts.')
        return
      }

      if (accs.length == 0) {
        alert('There are no Invoice accounts')
        return
      }
      console.log('got accounts:', accs)
      invoiceAccounts = accs
      invoiceAccount = invoiceAccounts[0]
      self.refreshBalance()
    })
  },
  setStatus: function (message) {
    var status = document.getElementById('invoice-status')
    status.innerHTML = message
  },
  refreshBalance: function () {
    var self = this

    var inv
    Invoice.deployed().then(function (instance) {
      inv = instance
      return inv.getBalance.call(invoiceAccount, {
        from: invoiceAccount
      })
    }).then(function (value) {
      var balanceElement = document.getElementById('invoice-balance')
      balanceElement.innerHTML = value.valueOf()
    }).catch(function (e) {
      console.log(e)
      self.setStatus('Error getting invoice balance; see log.')
    })
  },
  sendInvoice: function () {},
  receivePayment: function () {}
}

window.addEventListener('load', function () {
  // Checking if Web3 has been injected by the browser (Mist/MetaMask)
  if (typeof web3 !== 'undefined') {
    console.warn("Using web3 detected from external source. If you find that your accounts don't appear or you have 0 MetaCoin, ensure you 've configured that source properly. If using MetaMask, see the following link. Feel free to delete this warning. :) http://truffleframework.com/tutorials/truffle-and-metamask")
    // Use Mist/MetaMask's provider
    window.web3 = new Web3(web3.currentProvider)
  } else {
    console.warn("No web3 detected. Falling back to http://127.0.0.1:7545. You should remove this fallback when you deploy live, as it's inherently insecure.Consider switching to Metamask for development.More info here: http: //truffleframework.com/tutorials/truffle-and-metamask")
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(new Web3.providers.HttpProvider('http://127.0.0.1:7545'))
  }

  Collector.start()
  Department.start()
  Invoice.start()
})
