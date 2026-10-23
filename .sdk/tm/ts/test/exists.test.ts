
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { XoomarMarketsSDK } from '..'


describe('exists', async () => {

  test('test-mode', () => {
    const testsdk = XoomarMarketsSDK.test()
    equal(testsdk instanceof XoomarMarketsSDK, true,
      'XoomarMarketsSDK.test() must return a client synchronously')
  })

})
