const {assert} = require("chai")
const kryptoBirdz = artifacts.require("./KryptoBirdz")

require("chai")
.use(require("chai-as-promised"))
.should()

describe('tests deployment', async () => {
    let contract

    it('deploys smart contracts', async () => {
        contract = await kryptoBirdz.deployed()
        const address = contract.address

        assert.notEqual(address, '')
        assert.notEqual(address, null)
        assert.notEqual(address, undefined)
        assert.notEqual(address, 0x0)
    })
})