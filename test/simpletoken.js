const Registry = artifacts.require('TokenRegistry')
const Token = artifacts.require('RideshareToken')

contract('Simple token setup', accounts => {
   let registry,
       co2kn

   it('Should register new token in registry', async () => {
      const id = 'testToken'
      registry = await Registry.new()
      co2kn = await Token.new(1000)
      await registry.setToken(id, co2kn.address)

      assert( await registry.contains(id) )
   })

   it('Should mint token', async () => {
      await co2kn.mint(accounts[0], 100)
      assert( await co2kn.totalSupply() == 100 )
   })
})
