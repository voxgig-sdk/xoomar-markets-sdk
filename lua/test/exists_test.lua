-- XoomarMarkets SDK exists test

local sdk = require("xoomar-markets_sdk")

describe("XoomarMarketsSDK", function()
  it("should create test SDK", function()
    local testsdk = sdk.test(nil, nil)
    assert.is_not_nil(testsdk)
  end)
end)
