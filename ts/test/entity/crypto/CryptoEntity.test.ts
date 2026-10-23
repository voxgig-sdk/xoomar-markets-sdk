

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'
import { createLiveTransport } from '../../live-runner'
import { runLiveEntity } from '../../live-entity'


import { XoomarMarketsSDK, BaseFeature, config, stdutil } from '../../..'

import {
  envOverride,
  liveClientOptions,
  liveDelay,
  loadEnvLocal,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


loadEnvLocal(__dirname + '/../../../.env.local')


describe('CryptoEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when XOOMAR_MARKETS_TEST_LIVE=TRUE.
  afterEach(liveDelay('XOOMAR_MARKETS_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = XoomarMarketsSDK.test()
    const ent = testsdk.Crypto()
    assert(null != ent)
  })


  class FailHook extends BaseFeature {
    name = 'failhook'
    version = '0.0.1'
    active = true
    unexpected = 0
    init() { }
    PreSpec() { throw new Error('crypto hook failed') }
    PreUnexpected() { this.unexpected++ }
  }

  test('stream-error', async () => {
    const offline = { net: { offline: true } }
    await assert.rejects(async () => {
      for await (const _item of XoomarMarketsSDK.test(offline).Crypto().stream('list')) { }
    }, /offline/)

    for await (const _item of XoomarMarketsSDK.test(offline).Crypto()
      .stream('list', undefined, { ctrl: { throw: false } })) { }

    if (null != (config as any).feature?.rbac) {
      const denied = XoomarMarketsSDK.test(undefined, { feature: { rbac: { active: true, deny: true } } })
      await assert.rejects(async () => {
        for await (const _item of denied.Crypto().stream('list')) { }
      }, (err: any) => 'rbac_denied' === err.code)
    }
  })

  test('stream-ctrl', async () => {
    const explain: any = {}
    const ctrl: any = { explain }
    for await (const _item of XoomarMarketsSDK.test().Crypto().stream('list', undefined, { ctrl })) { }
    assert.deepStrictEqual(Object.keys(ctrl), ['explain'])
    assert(explain === ctrl.explain && 0 < Object.keys(explain).length)
  })

  test('unexpected', async () => {
    const hook = new FailHook()
    const client = new XoomarMarketsSDK({ feature: { test: { active: true } }, extend: [hook] })
    await assert.rejects(client.Crypto().list(), /hook failed/)
    assert(0 < hook.unexpected)

    const fired = hook.unexpected
    assert.strictEqual(await client.Crypto().list(undefined, { throw: false }), undefined)
    assert(fired < hook.unexpected)
  })

  test('validate', async (t) => {
    if (null == (config as any).feature?.validate) {
      t.skip('feature not present in this SDK: validate')
      return
    }
    const client = XoomarMarketsSDK.test(undefined, { feature: { validate: { active: true } } })
    await assert.rejects(client.Crypto().list({"asset":1} as any),
      (err: any) => 'validate_failed' === err.code)
  })



  test('basic', async (t) => {

    const live = 'TRUE' === process.env.XOOMAR_MARKETS_TEST_LIVE
    for (const op of ['list', 'load']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'crypto.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"asset":{"a":true,"h":"Asset","n":"asset","r":false,"sh":"btc or eth","t":"`$STRING`","key$":"asset","index$":0},"attribution":{"a":true,"h":"Attribution","n":"attribution","r":false,"t":"`$STRING`","key$":"attribution","index$":1},"aumUsd":{"a":true,"h":"Aum Usd","n":"aumUsd","r":false,"sh":"Holdings valued in USD","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"aumUsd","index$":2},"baseAsset":{"a":true,"h":"Base Asset","n":"baseAsset","r":false,"sh":"Base asset ticker (BTC, ETH...)","t":"`$STRING`","key$":"baseAsset","index$":3},"binanceSymbol":{"a":true,"h":"Binance Symbol","n":"binanceSymbol","r":false,"sh":"Binance symbol","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"binanceSymbol","index$":4},"bitmexSymbol":{"a":true,"h":"Bitmex Symbol","n":"bitmexSymbol","r":false,"sh":"Always null, kept so existing clients parse unchanged","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"bitmexSymbol","index$":5},"bybitSymbol":{"a":true,"h":"Bybit Symbol","n":"bybitSymbol","r":false,"sh":"Bybit symbol","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"bybitSymbol","index$":6},"canonicalUrl":{"a":true,"fo":"uri","h":"Canonical Url","n":"canonicalUrl","r":false,"sh":"The matching page on xoomar.com","t":"`$STRING`","key$":"canonicalUrl","index$":7},"count":{"a":true,"h":"Count","n":"count","r":false,"sh":"Events","t":"`$NUMBER`","key$":"count","index$":8},"data":{"a":true,"h":"Data","n":"data","r":false,"t":"`$OBJECT`","key$":"data","index$":9},"date":{"a":true,"fo":"date","h":"Date","n":"date","r":false,"sh":"The as-of date of the issuer file","t":"`$STRING`","key$":"date","index$":10},"docs":{"a":true,"h":"Docs","n":"docs","r":false,"t":"`$STRING`","key$":"docs","index$":11},"exchange":{"a":true,"h":"Exchange","n":"exchange","r":false,"sh":"binance, bybit, okx, hyperliquid or kraken","t":"`$STRING`","key$":"exchange","index$":12},"flowUsd":{"a":true,"h":"Flow Usd","n":"flowUsd","r":false,"sh":"Net flow for the day in USD, derived from the change in the fund's reported holdings","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"flowUsd","index$":13},"fundingAnnualized":{"a":true,"h":"Funding Annualized","n":"fundingAnnualized","r":false,"sh":"Annualized rate, simple (not compounded), from the rate and its funding interval","t":["`$ONE`",["`$NUMBER`","`$NULL`"]],"key$":"fundingAnnualized","index$":14},"fundingIntervalHours":{"a":true,"h":"Funding Interval Hours","n":"fundingIntervalHours","r":false,"sh":"Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken)","t":"`$NUMBER`","key$":"fundingIntervalHours","index$":15},"fundingRate":{"a":true,"h":"Funding Rate","n":"fundingRate","r":false,"sh":"Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval)","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"fundingRate","index$":16},"fundingRate8h":{"a":true,"h":"Funding Rate8h","n":"fundingRate8h","r":false,"sh":"The rate scaled to eight hours, comparable across venues","t":["`$ONE`",["`$NUMBER`","`$NULL`"]],"key$":"fundingRate8h","index$":17},"holdings":{"a":true,"h":"Holdings","n":"holdings","r":false,"sh":"Coins held per the issuer file","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"holdings","index$":18},"hour":{"a":true,"fo":"date-time","h":"Hour","n":"hour","r":false,"sh":"Hour bucket, ISO","t":"`$STRING`","key$":"hour","index$":19},"hyperliquidCoin":{"a":true,"h":"Hyperliquid Coin","n":"hyperliquidCoin","r":false,"sh":"Hyperliquid coin","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"hyperliquidCoin","index$":20},"id":{"a":true,"h":"Id","n":"id","r":false,"sh":"Event id","t":"`$NUMBER`","key$":"id","index$":21},"issuer":{"a":true,"h":"Issuer","n":"issuer","r":false,"sh":"Issuer name","t":"`$STRING`","key$":"issuer","index$":22},"krakenSymbol":{"a":true,"h":"Kraken Symbol","n":"krakenSymbol","r":false,"sh":"Kraken Futures symbol","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"krakenSymbol","index$":23},"license":{"a":true,"h":"License","n":"license","r":false,"sh":"Data terms","t":"`$STRING`","key$":"license","index$":24},"longShortRatio":{"a":true,"h":"Long Short Ratio","n":"longShortRatio","r":false,"sh":"Global long/short account ratio where the venue publishes it, else null","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"longShortRatio","index$":25},"longUsd":{"a":true,"h":"Long Usd","n":"longUsd","r":false,"sh":"Long liquidations in USD","t":"`$NUMBER`","key$":"longUsd","index$":26},"markPrice":{"a":true,"h":"Mark Price","n":"markPrice","r":false,"sh":"Latest mark price in USD","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"markPrice","index$":27},"maxSingleUsd":{"a":true,"h":"Max Single Usd","n":"maxSingleUsd","r":false,"sh":"Largest single event","t":"`$NUMBER`","key$":"maxSingleUsd","index$":28},"meta":{"a":true,"h":"Meta","n":"meta","r":false,"sh":"Who publishes the data and how to credit it","t":"`$OBJECT`","key$":"meta","index$":29},"nextFundingTime":{"a":true,"h":"Next Funding Time","n":"nextFundingTime","r":false,"sh":"ISO timestamp of the next funding settlement","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"nextFundingTime","index$":30},"okxInstId":{"a":true,"h":"Okx Inst Id","n":"okxInstId","r":false,"sh":"OKX instrument id","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"okxInstId","index$":31},"openInterest":{"a":true,"h":"Open Interest","n":"openInterest","r":false,"sh":"Open interest in contracts","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"openInterest","index$":32},"openInterestValue":{"a":true,"h":"Open Interest Value","n":"openInterestValue","r":false,"sh":"Open interest notional in USD","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"openInterestValue","index$":33},"price":{"a":true,"h":"Price","n":"price","r":false,"sh":"Liquidation price","t":"`$STRING`","key$":"price","index$":34},"priceChangePct24h":{"a":true,"h":"Price Change Pct24h","n":"priceChangePct24h","r":false,"sh":"24h price change as a decimal","t":["`$ONE`",["`$STRING`","`$NULL`"]],"key$":"priceChangePct24h","index$":35},"qty":{"a":true,"h":"Qty","n":"qty","r":false,"sh":"Quantity in coins","t":"`$STRING`","key$":"qty","index$":36},"rawSymbol":{"a":true,"h":"Raw Symbol","n":"rawSymbol","r":false,"sh":"Contract as the exchange names it","t":"`$STRING`","key$":"rawSymbol","index$":37},"shortUsd":{"a":true,"h":"Short Usd","n":"shortUsd","r":false,"sh":"Short liquidations in USD","t":"`$NUMBER`","key$":"shortUsd","index$":38},"side":{"a":true,"h":"Side","n":"side","r":false,"sh":"long (forced sale) or short (forced buy)","t":"`$STRING`","key$":"side","index$":39},"slug":{"a":true,"h":"Slug","n":"slug","r":false,"sh":"Symbol slug used in URLs (btc, eth, sol...)","t":"`$STRING`","key$":"slug","index$":40},"source":{"a":true,"h":"Source","n":"source","r":false,"t":"`$STRING`","key$":"source","index$":41},"symbol":{"a":true,"h":"Symbol","n":"symbol","r":false,"sh":"Contract (only when filtered)","t":"`$STRING`","key$":"symbol","index$":42},"ticker":{"a":true,"h":"Ticker","n":"ticker","r":false,"sh":"Fund ticker (IBIT, ETHA...)","t":"`$STRING`","key$":"ticker","index$":43},"totalUsd":{"a":true,"h":"Total Usd","n":"totalUsd","r":false,"sh":"Total in USD","t":"`$NUMBER`","key$":"totalUsd","index$":44},"ts":{"a":true,"fo":"date-time","h":"Ts","n":"ts","r":false,"sh":"Event time, ISO","t":"`$STRING`","key$":"ts","index$":45},"updatedAt":{"a":true,"fo":"date-time","h":"Updated At","n":"updatedAt","r":false,"sh":"When the response was built; a few dated feeds give the date of their newest row instead","t":"`$STRING`","key$":"updatedAt","index$":46},"usdValue":{"a":true,"h":"Usd Value","n":"usdValue","r":false,"sh":"Notional in USD","t":"`$STRING`","key$":"usdValue","index$":47}},"id":{"field":"id","name":"id"},"name":"crypto","op":{"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /api/markets/etf-flows","source":"openapi3","version":2},"g":{"query":[{"a":true,"k":"query","n":"asset","or":"asset","r":false,"t":"`$STRING`","index$":0},{"a":true,"ex":90,"k":"query","n":"day","or":"days","r":false,"t":"`$INTEGER`","index$":1}]},"k":"http","m":"GET","o":"/api/markets/etf-flows","q":{},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"etf-flows"}],"t":{"req":"`reqdata`","res":"`body.data`"},"index$":0},{"a":true,"co":{"id":"GET /api/markets/funding-rates","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/api/markets/funding-rates","q":{},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"funding-rates"}],"t":{"req":"`reqdata`","res":"`body.data`"},"index$":1},{"a":true,"co":{"id":"GET /api/markets/liquidations/history","source":"openapi3","version":2},"g":{"query":[{"a":true,"ex":"2026-01-01","k":"query","n":"from","or":"from","r":false,"t":"`$STRING`","index$":0},{"a":true,"ex":168,"k":"query","n":"limit","or":"limit","r":false,"t":"`$INTEGER`","index$":1},{"a":true,"ex":"BTCUSDT","k":"query","n":"symbol","or":"symbol","r":false,"t":"`$STRING`","index$":2},{"a":true,"ex":"2026-01-01","k":"query","n":"to","or":"to","r":false,"t":"`$STRING`","index$":3}]},"k":"http","m":"GET","o":"/api/markets/liquidations/history","q":{},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"liquidations"},{"lit":"history"}],"t":{"req":"`reqdata`","res":"`body.data`"},"index$":2},{"a":true,"co":{"id":"GET /api/markets/liquidations/recent","source":"openapi3","version":2},"g":{"query":[{"a":true,"k":"query","n":"exchange","or":"exchange","r":false,"t":"`$STRING`","index$":0},{"a":true,"ex":100,"k":"query","n":"limit","or":"limit","r":false,"t":"`$INTEGER`","index$":1},{"a":true,"ex":100000,"k":"query","n":"min_usd","or":"minUsd","r":false,"t":"`$NUMBER`","index$":2},{"a":true,"k":"query","n":"side","or":"side","r":false,"t":"`$STRING`","index$":3},{"a":true,"ex":"BTCUSDT","k":"query","n":"symbol","or":"symbol","r":false,"t":"`$STRING`","index$":4}]},"k":"http","m":"GET","o":"/api/markets/liquidations/recent","q":{},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"liquidations"},{"lit":"recent"}],"t":{"req":"`reqdata`","res":"`body.data`"},"index$":3},{"a":true,"co":{"id":"GET /api/markets/symbols","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/api/markets/symbols","q":{},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"symbols"}],"t":{"req":"`reqdata`","res":"`body.data`"},"index$":4}],"key$":"list"},"load":{"input":"data","name":"load","points":[{"a":true,"co":{"id":"GET /api/markets/whales/{coin}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"btc","k":"param","n":"coin","or":"coin","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/api/markets/whales/{coin}","q":{"exist":["coin"]},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"whales"},{"var":"coin"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"GET /api/markets/options/{currency}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"BTC","k":"param","n":"currency","or":"currency","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/api/markets/options/{currency}","q":{"exist":["currency"]},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"options"},{"var":"currency"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1},{"a":true,"co":{"id":"GET /api/markets/options/{currency}/dvol","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"BTC","k":"param","n":"currency","or":"currency","r":true,"t":"`$STRING`","index$":0}],"query":[{"a":true,"ex":"2026-01-01","k":"query","n":"from","or":"from","r":false,"t":"`$STRING`","index$":0},{"a":true,"ex":"2026-01-01","k":"query","n":"to","or":"to","r":false,"t":"`$STRING`","index$":1}]},"k":"http","m":"GET","o":"/api/markets/options/{currency}/dvol","q":{"exist":["currency"]},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"options"},{"var":"currency"},{"lit":"dvol"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":2},{"a":true,"co":{"id":"GET /api/markets/funding-rates/{slug}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"btc","k":"param","n":"slug","or":"slug","r":true,"t":"`$STRING`","index$":0}],"query":[{"a":true,"k":"query","n":"history","or":"history","r":false,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/api/markets/funding-rates/{slug}","q":{"exist":["slug"]},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"funding-rates"},{"var":"slug"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":3},{"a":true,"co":{"id":"GET /api/markets/open-interest/{slug}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"btc","k":"param","n":"slug","or":"slug","r":true,"t":"`$STRING`","index$":0}],"query":[{"a":true,"ex":"2026-01-01","k":"query","n":"from","or":"from","r":false,"t":"`$STRING`","index$":0},{"a":true,"ex":5000,"k":"query","n":"limit","or":"limit","r":false,"t":"`$INTEGER`","index$":1},{"a":true,"k":"query","n":"period","or":"period","r":false,"t":"`$STRING`","index$":2},{"a":true,"ex":"2026-01-01","k":"query","n":"to","or":"to","r":false,"t":"`$STRING`","index$":3}]},"k":"http","m":"GET","o":"/api/markets/open-interest/{slug}","q":{"exist":["slug"]},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"open-interest"},{"var":"slug"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":4},{"a":true,"co":{"id":"GET /api/markets/sentiment/{slug}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"btc","k":"param","n":"slug","or":"slug","r":true,"t":"`$STRING`","index$":0}],"query":[{"a":true,"k":"query","n":"history","or":"history","r":false,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/api/markets/sentiment/{slug}","q":{"exist":["slug"]},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"sentiment"},{"var":"slug"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":5},{"a":true,"co":{"id":"GET /api/markets/signals/{slug}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"btc","k":"param","n":"slug","or":"slug","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/api/markets/signals/{slug}","q":{"exist":["slug"]},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"signals"},{"var":"slug"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":6},{"a":true,"co":{"id":"GET /api/markets/liquidations","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/api/markets/liquidations","q":{},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"liquidations"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":7},{"a":true,"co":{"id":"GET /api/markets/sentiment","source":"openapi3","version":2},"g":{"query":[{"a":true,"ex":"btc","k":"query","n":"asset","or":"asset","r":false,"t":"`$STRING`","index$":0},{"a":true,"k":"query","n":"kind","or":"kind","r":false,"t":"`$STRING`","index$":1},{"a":true,"k":"query","n":"window","or":"window","r":false,"t":"`$STRING`","index$":2}]},"k":"http","m":"GET","o":"/api/markets/sentiment","q":{},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"sentiment"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":8},{"a":true,"co":{"id":"GET /api/markets/whales","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/api/markets/whales","q":{},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"api"},{"lit":"markets"},{"lit":"whales"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":9}],"key$":"load"}},"relations":{"ancestors":[]},"key$":"crypto","name__orig":"crypto","Name":"Crypto","name_":"crypto","name-":"crypto","NAME":"CRYPTO","index$":1}, {"active":true,"entity":"crypto","key$":"BasicCryptoFlow","kind":"basic","name":"BasicCryptoFlow","param":{},"step":[{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"crypto_ref01"}}],"index$":0},{"a":true,"d":{},"i":{"ref":"crypto_ref01","srcdatavar":"crypto_ref01_data","suffix":"_dt0"},"m":{},"o":"load","s":[],"v":[{"apply":"TextFieldMark","def":{"mark":"Mark01-crypto_ref01"}}],"index$":1}]}, 'Crypto', {"GET /api/markets/etf-flows":{"protocol":"http","parameters":[{"name":"asset","in":"query","required":false,"description":"Asset","schema":{"type":"string","enum":["btc","eth"]},"index$":0},{"name":"days","in":"query","required":false,"description":"Window in days (default 90, max 730)","schema":{"type":"integer"},"example":90,"index$":1}]},"GET /api/markets/funding-rates":{"protocol":"http","parameters":[]},"GET /api/markets/liquidations/history":{"protocol":"http","parameters":[{"name":"symbol","in":"query","required":false,"description":"Contract (BTC alone matches BTCUSDT)","schema":{"type":"string"},"example":"BTCUSDT","index$":0},{"name":"from","in":"query","required":false,"description":"First hour (YYYY-MM-DD)","schema":{"type":"string"},"example":"2026-01-01","index$":1},{"name":"to","in":"query","required":false,"description":"Last hour (YYYY-MM-DD)","schema":{"type":"string"},"example":"2026-01-01","index$":2},{"name":"limit","in":"query","required":false,"description":"Rows returned, newest first inside the window (default 168, max 5000)","schema":{"type":"integer"},"example":168,"index$":3}]},"GET /api/markets/liquidations/recent":{"protocol":"http","parameters":[{"name":"symbol","in":"query","required":false,"description":"Contract (BTC alone matches BTCUSDT)","schema":{"type":"string"},"example":"BTCUSDT","index$":0},{"name":"exchange","in":"query","required":false,"description":"Exchange","schema":{"type":"string","enum":["okx","gate","htx"]},"index$":1},{"name":"side","in":"query","required":false,"description":"Side","schema":{"type":"string","enum":["long","short"]},"index$":2},{"name":"minUsd","in":"query","required":false,"description":"Minimum notional in USD","schema":{"type":"number"},"example":100000,"index$":3},{"name":"limit","in":"query","required":false,"description":"Rows returned, newest first inside the window (default 100, max 500)","schema":{"type":"integer"},"example":100,"index$":4}]},"GET /api/markets/symbols":{"protocol":"http","parameters":[]},"GET /api/markets/whales/{coin}":{"protocol":"http","parameters":[{"name":"coin","in":"path","required":true,"description":"Coin","schema":{"type":"string"},"example":"btc","index$":0}]},"GET /api/markets/options/{currency}":{"protocol":"http","parameters":[{"name":"currency","in":"path","required":true,"description":"Currency","schema":{"type":"string","enum":["BTC","ETH"]},"example":"BTC","index$":0}]},"GET /api/markets/options/{currency}/dvol":{"protocol":"http","parameters":[{"name":"currency","in":"path","required":true,"description":"Currency","schema":{"type":"string","enum":["BTC","ETH"]},"example":"BTC","index$":0},{"name":"from","in":"query","required":false,"description":"First hour (YYYY-MM-DD)","schema":{"type":"string"},"example":"2026-01-01","index$":1},{"name":"to","in":"query","required":false,"description":"Last hour (YYYY-MM-DD)","schema":{"type":"string"},"example":"2026-01-01","index$":2}]},"GET /api/markets/funding-rates/{slug}":{"protocol":"http","parameters":[{"name":"slug","in":"path","required":true,"description":"Symbol slug from /api/markets/symbols","schema":{"type":"string"},"example":"btc","index$":0},{"name":"history","in":"query","required":false,"description":"Settled funding history window","schema":{"type":"string","enum":["30d","1y","all"]},"index$":1}]},"GET /api/markets/open-interest/{slug}":{"protocol":"http","parameters":[{"name":"slug","in":"path","required":true,"description":"Symbol slug","schema":{"type":"string"},"example":"btc","index$":0},{"name":"from","in":"query","required":false,"description":"First hour (YYYY-MM-DD)","schema":{"type":"string"},"example":"2026-01-01","index$":1},{"name":"to","in":"query","required":false,"description":"Last hour (YYYY-MM-DD)","schema":{"type":"string"},"example":"2026-01-01","index$":2},{"name":"period","in":"query","required":false,"description":"1h (default) or 1d","schema":{"type":"string","enum":["1h","1d"]},"index$":3},{"name":"limit","in":"query","required":false,"description":"Rows returned, newest first inside the window (default 5000, max 5000)","schema":{"type":"integer"},"example":5000,"index$":4}]},"GET /api/markets/sentiment/{slug}":{"protocol":"http","parameters":[{"name":"slug","in":"path","required":true,"description":"Asset slug","schema":{"type":"string"},"example":"btc","index$":0},{"name":"history","in":"query","required":false,"description":"Series to return: 7d (default) or 30d; all returns the 30d series","schema":{"type":"string","enum":["7d","30d","all"]},"index$":1}]},"GET /api/markets/signals/{slug}":{"protocol":"http","parameters":[{"name":"slug","in":"path","required":true,"description":"Asset slug","schema":{"type":"string"},"example":"btc","index$":0}]},"GET /api/markets/liquidations":{"protocol":"http","parameters":[]},"GET /api/markets/sentiment":{"protocol":"http","parameters":[{"name":"window","in":"query","required":false,"description":"Window of the scores (default 24h)","schema":{"type":"string","enum":["5m","15m","1h","24h","7d","30d"]},"index$":0},{"name":"asset","in":"query","required":false,"description":"One asset slug","schema":{"type":"string"},"example":"btc","index$":1},{"name":"kind","in":"query","required":false,"description":"One asset class","schema":{"type":"string","enum":["crypto","fx","index","commodity","equity"]},"index$":2}]},"GET /api/markets/whales":{"protocol":"http","parameters":[]}}, { strict: LIVE_STRICT, t })
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let crypto_ref01_data = Object.values(setup.data.existing.crypto)[0] as any

    // LIST
    const crypto_ref01_ent = client.Crypto()
    const crypto_ref01_match: any = {}

    const crypto_ref01_list = (await crypto_ref01_ent.list(crypto_ref01_match)).map((e: any) => e.data())


    // LOAD
    const crypto_ref01_match_dt0: any = {}
    crypto_ref01_match_dt0.id = crypto_ref01_data.id
    const crypto_ref01_data_dt0 = (await crypto_ref01_ent.load(crypto_ref01_match_dt0)).data()
    assert(crypto_ref01_data_dt0.id === crypto_ref01_data.id)


  })
})



// main.kit.test.live.strict is true (the default is true): a live
// request that fails, or a live test missing an input it needs,
// fails the test.
// An account with no record for a test to read skips it either way.
const LIVE_STRICT = true

function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/crypto/CryptoTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = XoomarMarketsSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['crypto01','crypto02','crypto03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'XOOMAR_MARKETS_TEST_CRYPTO_ENTID': idmap,
    'XOOMAR_MARKETS_TEST_LIVE': 'FALSE',
    'XOOMAR_MARKETS_TEST_EXPLAIN': 'FALSE',
    'XOOMAR_MARKETS_APIKEY': '',
  })

  idmap = env['XOOMAR_MARKETS_TEST_CRYPTO_ENTID']

  const live = 'TRUE' === env.XOOMAR_MARKETS_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['XOOMAR_MARKETS_TEST_CRYPTO_ENTID']
    idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {}
    if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
      throw new Error('Live ENTID must be a JSON object')
    }
    client = new XoomarMarketsSDK(merge([
      // FIRST, so the generated fields below win: sdk-test-control.json's
      // test.client.options adds to the live client, it does not redirect it.
      liveClientOptions(),
      {
        apikey: env.XOOMAR_MARKETS_APIKEY,
      },
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
      // last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey
      // and server values above and handed the SDK undefined. Harmless
      // while there was nothing in that object; not harmless now.
      extra || {},
      { system: { fetch: transport.fetch } }
    ]))
  }

  const setup = {
    idmap,
    env,
    options,
    client,
    struct,
    data: entityData,
    explain: 'TRUE' === env.XOOMAR_MARKETS_TEST_EXPLAIN,
    live,
    transport,
    now: Date.now(),
  }

  return setup
}
  
