const {assert} = require("chai")
const kryptoBirdz = artifacts.require("./KryptoBirdz")

require("chai")
.use(require("chai-as-promised"))
.should()

contract('KryptoBirdz', (accounts) => {
    let contract

    before( async() => {
        contract = await kryptoBirdz.deployed()
    })

    describe('tests deployment', async () => {
            
        it('deploys smart contracts', async () => {
            
            const address = await contract.address
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
            assert.notEqual(address, 0x0)
        })
    
        it('verifies metadata name', async () => {
            const name = await contract.getName()
    
            assert.equal(name, 'Kryptobirdz')
        })
    
        it('verifies symbol', async () => {
            const symbol = await contract.getSymbol()
    
            assert.equal(symbol, 'KBIRDZ')
        })
    })

    describe('Mints tokens', async() => {

        it('mints a token', async() => { 
            const token = await contract.mint('http...1')
            const totalSupply = await contract.totalSupply()
            assert.equal(totalSupply.words[0], 1)


            const eventData = await token.logs[0].args
            assert.equal(eventData._from,'0x0000000000000000000000000000000000000000','from is the contract')
            assert.equal(eventData._to, accounts[0],'To is the msg.sender')

            await contract.mint('http...1').should.be.rejected                  
        })
    })


    describe('indexing of tokens', async() => {

        it('fetches all minted tokens', async() => {

            await contract.mint('http...2')
            await contract.mint('http...3')
            await contract.mint('http...4')

            let totalSupply = await contract.totalSupply()

            let result = []
            let kBird

            for(i = 0; i < totalSupply.words[0]; i++) {
                kBird = await contract.kryptoBirdz(i)
                result.push(kBird)
            }

            let expected = ['http...1','http...2','http...3','http...4']

            assert.equal(expected.join(','), result.join(','))
        })
    })
})

