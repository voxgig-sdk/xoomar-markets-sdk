# XoomarMarkets TypeScript SDK



The TypeScript SDK for the XoomarMarkets API — a type-safe, entity-oriented client with full async/await support.

The API is exposed as capitalised, semantic **Entities** — e.g.
`client.Company()` — each with a small set of operations (`list`, `load`)
instead of raw URL paths and query parameters. This keeps the surface
predictable and low-friction for both humans and AI agents.

> Also generated from this model: `go`, `go-cli`, `go-mcp`, `lua`, `php`, `py`, `rb` — see
> the [top-level README](../README.md).


## Install
This package is not yet published to npm. Install it from the GitHub
release tag (`ts/vX.Y.Z`, see [Tags](https://github.com/voxgig-sdk/xoomar-markets-sdk/tags)), or from a
clone, which carries the compiled `dist/`:

```bash
git clone https://github.com/voxgig-sdk/xoomar-markets-sdk
npm install ./xoomar-markets-sdk/ts
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record. The client sends the API key in the `x-api-key` header.

### 1. Create a client

```ts
import { XoomarMarketsSDK } from '@voxgig-sdk/xoomar-markets-sdk'

const client = new XoomarMarketsSDK({
  apikey: process.env.XOOMAR_MARKETS_APIKEY,
})
```

### 2. List company records

`list()` resolves to an array of Company ENTITIES — every operation
resolves to entities, not raw records. Iterate them directly, and call
`.data()` on one for the record it holds:

```ts
const companys = await client.Company().list()

for (const company of companys) {
  console.log(company.data())
}
```

### 3. Load a company

`load()` returns the entity and throws on failure; `.data()` reads its record:

```ts
try {
  const company = await client.Company().load({ slug: 'example_slug' })
  console.log(company.data())
} catch (err) {
  console.error('load failed:', err)
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const macros = await client.Macro().list()
  console.log(macros.map((item) => item.data()))
} catch (err) {
  console.error('list failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
result envelope. Branch on `ok`; on failure `status` holds the HTTP status
(for error responses) and `err` holds the error:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (!result.ok) {
  console.error('request failed:', result.status, result.err)
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})

if (result.ok) {
  console.log(result.status)  // 200
  console.log(result.data)    // response body
}
```

### Prepare a request without sending it

```ts
const fetchdef = await client.prepare({
  path: '/api/resource/{id}',
  method: 'DELETE',
  params: { id: 'example' },
})

// Inspect before sending
console.log(fetchdef.url)
console.log(fetchdef.method)
console.log(fetchdef.headers)
```

### Use test mode

Create a mock client for unit testing — no server required:

```ts
const client = XoomarMarketsSDK.test()

const macros = await client.Macro().list()
// macros is an array of Macro entities, one per mock record
console.log(macros.map((macro) => macro.data()))
```

You can also use the instance method:

```ts
const client = new XoomarMarketsSDK({ apikey: '...' })
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```ts
const entity = client.Macro()

// First call runs the operation and stores its result
await entity.list()

// Subsequent calls reuse the stored state
const data = entity.data()
console.log(data)
```

### Add custom middleware

Pass features via the `extend` option:

```ts
const logger = {
  hooks: {
    PreRequest: (ctx: any) => {
      console.log('Requesting:', ctx.spec.method, ctx.spec.path)
    },
    PreResponse: (ctx: any) => {
      console.log('Status:', ctx.out.request?.status)
    },
  },
}

const client = new XoomarMarketsSDK({
  apikey: '...',
  extend: [logger],
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
XOOMAR_MARKETS_TEST_LIVE=TRUE
XOOMAR_MARKETS_APIKEY=<your-key>
```

Then run:

```bash
cd ts && npm test
```

Live entity tests continue independent operations after errors and attempt
supported cleanup. Their final result reports failures and missing prerequisites
after the remaining work completes. The model and test inputs determine which
API operations the generated scenarios cover.


## Reference

### XoomarMarketsSDK

#### Constructor

```ts
new XoomarMarketsSDK(options?: {
  apikey?: string
  base?: string
  prefix?: string
  suffix?: string
  feature?: Record<string, { active: boolean }>
  extend?: Feature[]
})
```

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `object` | Feature activation flags (e.g. `{ test: { active: true } }`). |
| `extend` | `Feature[]` | Additional feature instances to load. |

#### Methods

| Method | Returns | Description |
| --- | --- | --- |
| `options()` | `object` | Deep copy of current SDK options. |
| `utility()` | `Utility` | Deep copy of the SDK utility object. |
| `prepare(fetchargs?)` | `Promise<FetchDef>` | Build an HTTP request definition without sending it. |
| `direct(fetchargs?)` | `Promise<DirectResult>` | Build and send an HTTP request. |
| `Company(data?)` | `CompanyEntity` | Create a Company entity instance. |
| `Crypto(data?)` | `CryptoEntity` | Create a Crypto entity instance. |
| `Macro(data?)` | `MacroEntity` | Create a Macro entity instance. |
| `tester(testopts?, sdkopts?)` | `XoomarMarketsSDK` | Create a test-mode client instance. |

#### Static methods

| Method | Returns | Description |
| --- | --- | --- |
| `XoomarMarketsSDK.test(testopts?, sdkopts?)` | `XoomarMarketsSDK` | Create a test-mode client. |

### Entity interface

All entities share the same interface.

#### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `load(reqmatch?, ctrl?): Promise<Entity>` | Load a single entity by match criteria, and return it. |
| `list` | `list(reqmatch?, ctrl?): Promise<Entity[]>` | List entities matching the criteria, one per record. |
| `data` | `data(data?: Partial<Entity>): Entity` | Get or set entity data. |
| `match` | `match(match?: Partial<Entity>): Partial<Entity>` | Get or set entity match criteria. |
| `make` | `make(): Entity` | Create a new instance with the same options. |
| `client` | `client(): XoomarMarketsSDK` | Return the parent SDK client. |
| `entopts` | `entopts(): object` | Return a copy of the entity options. |

#### Return values

Entity operations resolve to the entity itself — there is no result
envelope, and an entity's `data()` reads its record:

- `load` resolves to a single entity object.
- `list` resolves to an **array** of entity objects (iterate it directly;
  there is no `.data` and no `.ok`).

On a failed request these methods **throw**, so wrap calls in
`try`/`catch` to handle errors. Only `direct()` returns the result
envelope described below.

### DirectResult shape

The `direct()` method returns:

```ts
{
  ok: boolean
  status: number
  headers: object
  data: any
}
```

On error, `ok` is `false` and an `err` property contains the error.

### FetchDef shape

The `prepare()` method returns:

```ts
{
  url: string
  method: string
  headers: Record<string, string>
  body?: any
}
```

### Entities

#### Company

| Field | Description |
| --- | --- |
| `accessionNo` | The filing's accession number for reported rows; null for estimates |
| `actionDate` | Date the action was signed |
| `actionType` | FPDS action type code |
| `aggregateMarketValue` | Aggregate market value of the shares to be sold, USD |
| `amendmentNo` | Amendment number; null for the original filing |
| `amountUsd` | Dollars obligated by this action; negative for de-obligations |
| `approxSaleDate` | Approximate date of sale |
| `asOf` | Balance sheet date of the figures |
| `attribution` |  |
| `avgDailyVol` | Average daily trading volume |
| `awardId` | Contract or order number (PIID) |
| `awardType` | Definitive contract, delivery order, BPA call, purchase order |
| `awardingAgency` | Awarding department and bureau |
| `awardingSubAgency` | Awarding department and bureau |
| `barrierPct` | Barrier/threshold as % of initial level. |
| `basis` | Reference date for an estimated row; null for reported rows |
| `broker` | Broker named in the notice |
| `buybacks` | PaymentsForRepurchaseOfCommonStock for the fiscal year, USD |
| `buyers` | Up to five buyers, largest first |
| `canonicalUrl` | The matching page on xoomar.com |
| `capPct` | Maximum return as % of initial level when the note is capped |
| `changePct` | Change in short quantity vs the prior report |
| `cik` | SEC CIK, ten digits |
| `company` | Filer name as on the filing |
| `companyName` | Filer name as on EDGAR |
| `costUsd` | Cost basis as filed, USD |
| `coupon` | Annual coupon %; null on preliminary filings, which are filed before the rate is set |
| `cusip` | CUSIP of the security |
| `data` |  |
| `date` | The reported date (filing date of the 8-K) or the estimated date |
| `dateOfFirstSale` | ISO date; null when the first sale has yet to occur |
| `daysToCover` | shortQty / avgDailyVol, FINRA-computed |
| `description` | Security description as the SEC publishes it |
| `docUrl` | Link to the filing index on sec.gov |
| `docs` |  |
| `end` | Fiscal year end |
| `entityType` | Corporation, Limited Partnership, LLC, Trust and so on |
| `eventDate` | Date of the event that requires the filing |
| `eventLabels` | Readable labels for each item |
| `exchange` | Exchange named for the sale |
| `exemptions` | Rule items claimed, e.g. |
| `fairValueUsd` | Fair value of crypto assets as filed, USD |
| `filedAt` | SEC acceptance timestamp |
| `firstRegistration` | Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing |
| `firstTxDate` | Earliest purchase in the window |
| `form` | 10-Q or 10-K the figures come from |
| `formType` | S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT |
| `frame` | Fiscal year frame, e.g. |
| `fundType` | Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only |
| `generatedId` | USAspending award id; https://www.usaspending.gov/award/{generatedId} |
| `impliedPrice` | fairValueUsd divided by units, the filing's own valuation per coin |
| `industryGroup` | SEC industry category (Pooled Investment Fund for funds) |
| `insiderName` | Reporting officer, director, or 10% owner |
| `insiderTitle` | Role at the company (CEO, CFO, Director...) |
| `insiders` | Distinct insiders who bought on the open market in the window |
| `investorsCount` | Investors who have already invested |
| `isAmendment` | Form D/A |
| `issuer` | Filing entity (BofA Finance, Morgan Stanley Finance...) |
| `issuerCik` | Issuer CIK, ten digits |
| `issuerName` | Issuer name as filed |
| `items` | 8-K item numbers (2.02, 5.02...) |
| `latestFiledAt` | When the latest of those filings reached EDGAR |
| `latestTxDate` | Latest purchase in the window |
| `license` | Data terms |
| `listed` | Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now |
| `manager` | Manager |
| `market` | nasdaq or cboe |
| `meta` | Who publishes the data and how to credit it |
| `minimumInvestment` | USD minimum accepted from an outside investor |
| `mod` | Modification number; 0 or null is the original award |
| `naicsCode` | Industry code of the work |
| `name` | Company |
| `netIncome` | Net income for the same fiscal year, USD |
| `noteType` | autocallable, buffered, barrier, or income. |
| `offeringAmount` | Always null; offering amounts are not included |
| `percentOfClass` | Percent of the class owned |
| `personName` | Person for whose account the shares are to be sold |
| `personType` | Type of reporting person as filed, e.g. |
| `price` | Closing price the SEC reports with the row, USD |
| `priceNote` | "price not stated in the filing" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); "≈ $61.36, midpoint of the stated range $60.86 to $61.85" when the price is the midpoint of… |
| `pricePerShare` | Reported price per share in USD |
| `pricingDate` | Pricing/trade date when stated |
| `principalUsd` | Aggregate principal when stated (final filings) |
| `quantity` | Shares failed to deliver, as the SEC publishes them |
| `recipientName` | Recipient legal name as registered |
| `relationship` | Relationship to the issuer, e.g. |
| `reportingCik` | Reporting person's CIK, when filed |
| `reportingPerson` | Reporting person or entity |
| `revenue` | Revenue for the same fiscal year, USD |
| `revenueRange` | Issuer revenue range or fund net asset value range, as disclosed |
| `securityClass` | Title of the class of securities |
| `securityName` | Security name as listed |
| `securityTypes` | equity, debt, options, pooled fund, other |
| `settlementDate` | Settlement date |
| `shares` | Shares bought or sold |
| `sharesOwned` | Shares beneficially owned |
| `shortExemptVolume` | Short sales marked exempt |
| `shortQty` | Total shares held short |
| `shortRatio` | shortVolume divided by totalVolume |
| `shortVolume` | Shares sold short that day, as reported to FINRA's facilities |
| `slug` | Fund slug for URLs |
| `source` |  |
| `state` | Issuer state or country code |
| `status` | reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives) |
| `symbol` | Ticker |
| `ticker` | Listed ticker |
| `totalAmountSold` | USD sold as of the filing |
| `totalOfferingAmount` | USD; null when indefinite |
| `totalVolume` | Total shares reported to FINRA's facilities that day (not the consolidated tape) |
| `trades` | Open-market purchase transactions in the window |
| `txDate` | Transaction date from the filing, YYYY-MM-DD |
| `underlyings` | Parsed underlying symbols (SPX, NDX, NVDA...). |
| `units` | Bitcoin held as tagged in the filing; null when the filing gives no usable count |
| `unitsOutstanding` | Shares or units of the class outstanding |
| `unitsReliable` | true when the filing gives a usable coin count |
| `unitsToSell` | Shares or units to be sold |
| `updatedAt` | When the response was built; a few dated feeds give the date of their newest row instead |
| `url` | Hub page |
| `valueUsd` | quantity times price, USD |

Operations: list, load.

API path: `/api/markets/bitcoin-treasuries`

#### Crypto

| Field | Description |
| --- | --- |
| `asset` | btc or eth |
| `attribution` |  |
| `aumUsd` | Holdings valued in USD |
| `baseAsset` | Base asset ticker (BTC, ETH...) |
| `binanceSymbol` | Binance symbol |
| `bitmexSymbol` | Always null, kept so existing clients parse unchanged |
| `bybitSymbol` | Bybit symbol |
| `canonicalUrl` | The matching page on xoomar.com |
| `count` | Events |
| `data` |  |
| `date` | The as-of date of the issuer file |
| `docs` |  |
| `exchange` | binance, bybit, okx, hyperliquid or kraken |
| `flowUsd` | Net flow for the day in USD, derived from the change in the fund's reported holdings |
| `fundingAnnualized` | Annualized rate, simple (not compounded), from the rate and its funding interval |
| `fundingIntervalHours` | Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken) |
| `fundingRate` | Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval) |
| `fundingRate8h` | The rate scaled to eight hours, comparable across venues |
| `holdings` | Coins held per the issuer file |
| `hour` | Hour bucket, ISO |
| `hyperliquidCoin` | Hyperliquid coin |
| `id` | Event id |
| `issuer` | Issuer name |
| `krakenSymbol` | Kraken Futures symbol |
| `license` | Data terms |
| `longShortRatio` | Global long/short account ratio where the venue publishes it, else null |
| `longUsd` | Long liquidations in USD |
| `markPrice` | Latest mark price in USD |
| `maxSingleUsd` | Largest single event |
| `meta` | Who publishes the data and how to credit it |
| `nextFundingTime` | ISO timestamp of the next funding settlement |
| `okxInstId` | OKX instrument id |
| `openInterest` | Open interest in contracts |
| `openInterestValue` | Open interest notional in USD |
| `price` | Liquidation price |
| `priceChangePct24h` | 24h price change as a decimal |
| `qty` | Quantity in coins |
| `rawSymbol` | Contract as the exchange names it |
| `shortUsd` | Short liquidations in USD |
| `side` | long (forced sale) or short (forced buy) |
| `slug` | Symbol slug used in URLs (btc, eth, sol...) |
| `source` |  |
| `symbol` | Contract (only when filtered) |
| `ticker` | Fund ticker (IBIT, ETHA...) |
| `totalUsd` | Total in USD |
| `ts` | Event time, ISO |
| `updatedAt` | When the response was built; a few dated feeds give the date of their newest row instead |
| `usdValue` | Notional in USD |

Operations: list, load.

API path: `/api/markets/etf-flows`

#### Macro

| Field | Description |
| --- | --- |
| `actual` | Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...) |
| `assetMgrLong` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assetMgrShort` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assets` | Fed total assets, USD (WALCL) |
| `attribution` |  |
| `auctionDate` | Auction date |
| `bidToCover` | Tendered divided by accepted |
| `canonicalUrl` | The matching page on xoomar.com |
| `country` | Economy |
| `countryCode` | BIS area code |
| `cusip` | Security CUSIP; a reopening shares the original's CUSIP |
| `data` |  |
| `date` | H.4.1 Wednesday date |
| `dealerAccepted` | Accepted by primary dealers, USD |
| `dealerLong` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `dealerShare` | Dealer share of accepted, 0 to 1 |
| `dealerShort` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `directAccepted` | Accepted from direct bidders, USD |
| `directShare` | Direct share of accepted, 0 to 1 |
| `docs` |  |
| `eventName` | CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ... |
| `forecast` | Always null: consensus forecasts aren't included |
| `group` | currencies, indices, crypto, metals, energy, bonds, agriculture, other |
| `highRate` | High discount rate (bills) or high discount margin (FRNs), percent |
| `highYield` | Stop-out yield, percent (notes, bonds, TIPS) |
| `importance` | high, med, or low |
| `indirectAccepted` | Accepted from indirect bidders, USD |
| `indirectShare` | Indirect share of accepted, 0 to 1 |
| `interestRate` | Coupon set at auction, percent |
| `issueDate` | Settlement date |
| `lastChanged` | Date of the most recent move |
| `levFundLong` | Leveraged funds (tff); managed money (disagg) |
| `levFundShort` | Leveraged funds (tff); managed money (disagg) |
| `license` | Data terms |
| `m1_m6` | 1, 2, 3, 6 month Treasury yields in percent |
| `maturityDate` | Maturity |
| `meta` | Who publishes the data and how to credit it |
| `name` | CFTC contract market name |
| `net` | assets minus tga minus rrp, USD |
| `nonreptLong` | Non-reportable (small trader) positions |
| `nonreptShort` | Non-reportable (small trader) positions |
| `offeringAmount` | Announced size, USD |
| `openInterest` | Total open interest in contracts |
| `otherLong` | Other reportable positions |
| `otherShort` | Other reportable positions |
| `periodLabel` | Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05' |
| `previous` | Prior period on the same basis as actual |
| `rate` | Policy rate, percent |
| `reopening` | True when the auction adds to an existing issue |
| `reportDate` | CFTC report Tuesday, YYYY-MM-DD |
| `reportType` | tff (financial futures) or disagg (commodities) |
| `reserves` | Reserve balances with Federal Reserve Banks, USD (WRESBAL) |
| `rrp` | Overnight reverse repo usage on that date, USD (RRPONTSYD) |
| `scheduledAt` | Release time, UTC |
| `securityTerm` | Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening) |
| `securityType` | Bill, CMB (cash management bill), Note, Bond, TIPS or FRN |
| `slug` | Market slug for URLs (euro-fx, gold...) |
| `sortRank` | Display order within the group |
| `source` | bls, bea, census, fed, dol or treasury (coupon auctions) |
| `tga` | Treasury General Account, USD (WTREGEN) |
| `totalAccepted` | Accepted, USD (null until results) |
| `totalTendered` | Bids received, USD |
| `unit` | What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance' |
| `updatedAt` | When the response was built; a few dated feeds give the date of their newest row instead |
| `y1_y30` | 1 to 30 year Treasury yields in percent |

Operations: list, load.

API path: `/api/markets/calendar`



## Entities


### Company

Create an instance: `const company = client.Company()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accessionNo` | `string | null` | The filing's accession number for reported rows; null for estimates |
| `actionDate` | `string` | Date the action was signed |
| `actionType` | `string | null` | FPDS action type code |
| `aggregateMarketValue` | `number | null` | Aggregate market value of the shares to be sold, USD |
| `amendmentNo` | `number | null` | Amendment number; null for the original filing |
| `amountUsd` | `number` | Dollars obligated by this action; negative for de-obligations |
| `approxSaleDate` | `string | null` | Approximate date of sale |
| `asOf` | `string | null` | Balance sheet date of the figures |
| `attribution` | `string` |  |
| `avgDailyVol` | `number | null` | Average daily trading volume |
| `awardId` | `string` | Contract or order number (PIID) |
| `awardType` | `string | null` | Definitive contract, delivery order, BPA call, purchase order |
| `awardingAgency` | `string | null` | Awarding department and bureau |
| `awardingSubAgency` | `string | null` | Awarding department and bureau |
| `barrierPct` | `string | null` | Barrier/threshold as % of initial level. |
| `basis` | `string | null` | Reference date for an estimated row; null for reported rows |
| `broker` | `string | null` | Broker named in the notice |
| `buybacks` | `number` | PaymentsForRepurchaseOfCommonStock for the fiscal year, USD |
| `buyers` | `any[]` | Up to five buyers, largest first |
| `canonicalUrl` | `string` | The matching page on xoomar.com |
| `capPct` | `string | null` | Maximum return as % of initial level when the note is capped |
| `changePct` | `string | null` | Change in short quantity vs the prior report |
| `cik` | `string` | SEC CIK, ten digits |
| `company` | `string` | Filer name as on the filing |
| `companyName` | `string` | Filer name as on EDGAR |
| `costUsd` | `number | null` | Cost basis as filed, USD |
| `coupon` | `string | null` | Annual coupon %; null on preliminary filings, which are filed before the rate is set |
| `cusip` | `string` | CUSIP of the security |
| `data` | `Record<string, any>` |  |
| `date` | `string` | The reported date (filing date of the 8-K) or the estimated date |
| `dateOfFirstSale` | `string | null` | ISO date; null when the first sale has yet to occur |
| `daysToCover` | `string | null` | shortQty / avgDailyVol, FINRA-computed |
| `description` | `string | null` | Security description as the SEC publishes it |
| `docUrl` | `string` | Link to the filing index on sec.gov |
| `docs` | `string` |  |
| `end` | `string` | Fiscal year end |
| `entityType` | `string | null` | Corporation, Limited Partnership, LLC, Trust and so on |
| `eventDate` | `string | null` | Date of the event that requires the filing |
| `eventLabels` | `any[] | null` | Readable labels for each item |
| `exchange` | `string | null` | Exchange named for the sale |
| `exemptions` | `string | null` | Rule items claimed, e.g. |
| `fairValueUsd` | `number | null` | Fair value of crypto assets as filed, USD |
| `filedAt` | `string` | SEC acceptance timestamp |
| `firstRegistration` | `string | null` | Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing |
| `firstTxDate` | `string` | Earliest purchase in the window |
| `form` | `string | null` | 10-Q or 10-K the figures come from |
| `formType` | `string` | S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT |
| `frame` | `string` | Fiscal year frame, e.g. |
| `fundType` | `string | null` | Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only |
| `generatedId` | `string | null` | USAspending award id; https://www.usaspending.gov/award/{generatedId} |
| `impliedPrice` | `number | null` | fairValueUsd divided by units, the filing's own valuation per coin |
| `industryGroup` | `string | null` | SEC industry category (Pooled Investment Fund for funds) |
| `insiderName` | `string` | Reporting officer, director, or 10% owner |
| `insiderTitle` | `string | null` | Role at the company (CEO, CFO, Director...) |
| `insiders` | `number` | Distinct insiders who bought on the open market in the window |
| `investorsCount` | `number | null` | Investors who have already invested |
| `isAmendment` | `boolean` | Form D/A |
| `issuer` | `string` | Filing entity (BofA Finance, Morgan Stanley Finance...) |
| `issuerCik` | `string | null` | Issuer CIK, ten digits |
| `issuerName` | `string` | Issuer name as filed |
| `items` | `any[] | null` | 8-K item numbers (2.02, 5.02...) |
| `latestFiledAt` | `string | null` | When the latest of those filings reached EDGAR |
| `latestTxDate` | `string` | Latest purchase in the window |
| `license` | `string` | Data terms |
| `listed` | `boolean` | Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now |
| `manager` | `string` | Manager |
| `market` | `string` | nasdaq or cboe |
| `meta` | `Record<string, any>` | Who publishes the data and how to credit it |
| `minimumInvestment` | `number | null` | USD minimum accepted from an outside investor |
| `mod` | `string | null` | Modification number; 0 or null is the original award |
| `naicsCode` | `string | null` | Industry code of the work |
| `name` | `string` | Company |
| `netIncome` | `number | null` | Net income for the same fiscal year, USD |
| `noteType` | `string | null` | autocallable, buffered, barrier, or income. |
| `offeringAmount` | `number | null` | Always null; offering amounts are not included |
| `percentOfClass` | `number | null` | Percent of the class owned |
| `personName` | `string` | Person for whose account the shares are to be sold |
| `personType` | `string | null` | Type of reporting person as filed, e.g. |
| `price` | `number | null` | Closing price the SEC reports with the row, USD |
| `priceNote` | `string | null` | "price not stated in the filing" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); "≈ $61.36, midpoint of the stated range $60.86 to $61.85" when the price is the midpoint of… |
| `pricePerShare` | `string | null` | Reported price per share in USD |
| `pricingDate` | `string | null` | Pricing/trade date when stated |
| `principalUsd` | `string | null` | Aggregate principal when stated (final filings) |
| `quantity` | `number` | Shares failed to deliver, as the SEC publishes them |
| `recipientName` | `string` | Recipient legal name as registered |
| `relationship` | `string | null` | Relationship to the issuer, e.g. |
| `reportingCik` | `string | null` | Reporting person's CIK, when filed |
| `reportingPerson` | `string` | Reporting person or entity |
| `revenue` | `number | null` | Revenue for the same fiscal year, USD |
| `revenueRange` | `string | null` | Issuer revenue range or fund net asset value range, as disclosed |
| `securityClass` | `string | null` | Title of the class of securities |
| `securityName` | `string | null` | Security name as listed |
| `securityTypes` | `string | null` | equity, debt, options, pooled fund, other |
| `settlementDate` | `string` | Settlement date |
| `shares` | `string | null` | Shares bought or sold |
| `sharesOwned` | `number | null` | Shares beneficially owned |
| `shortExemptVolume` | `number | null` | Short sales marked exempt |
| `shortQty` | `number | null` | Total shares held short |
| `shortRatio` | `number | null` | shortVolume divided by totalVolume |
| `shortVolume` | `number` | Shares sold short that day, as reported to FINRA's facilities |
| `slug` | `string` | Fund slug for URLs |
| `source` | `string` |  |
| `state` | `string | null` | Issuer state or country code |
| `status` | `string` | reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives) |
| `symbol` | `string | null` | Ticker |
| `ticker` | `string` | Listed ticker |
| `totalAmountSold` | `number | null` | USD sold as of the filing |
| `totalOfferingAmount` | `number | null` | USD; null when indefinite |
| `totalVolume` | `number` | Total shares reported to FINRA's facilities that day (not the consolidated tape) |
| `trades` | `number` | Open-market purchase transactions in the window |
| `txDate` | `string` | Transaction date from the filing, YYYY-MM-DD |
| `underlyings` | `any[] | null` | Parsed underlying symbols (SPX, NDX, NVDA...). |
| `units` | `number | null` | Bitcoin held as tagged in the filing; null when the filing gives no usable count |
| `unitsOutstanding` | `number | null` | Shares or units of the class outstanding |
| `unitsReliable` | `boolean` | true when the filing gives a usable coin count |
| `unitsToSell` | `number | null` | Shares or units to be sold |
| `updatedAt` | `string` | When the response was built; a few dated feeds give the date of their newest row instead |
| `url` | `string` | Hub page |
| `valueUsd` | `number | null` | quantity times price, USD |

#### Example: Load

```ts
const company = await client.Company().load({ slug: 'slug' })
```

#### Example: List

```ts
const companys = await client.Company().list()
```


### Crypto

Create an instance: `const crypto = client.Crypto()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `asset` | `string` | btc or eth |
| `attribution` | `string` |  |
| `aumUsd` | `string | null` | Holdings valued in USD |
| `baseAsset` | `string` | Base asset ticker (BTC, ETH...) |
| `binanceSymbol` | `string | null` | Binance symbol |
| `bitmexSymbol` | `string | null` | Always null, kept so existing clients parse unchanged |
| `bybitSymbol` | `string | null` | Bybit symbol |
| `canonicalUrl` | `string` | The matching page on xoomar.com |
| `count` | `number` | Events |
| `data` | `Record<string, any>` |  |
| `date` | `string` | The as-of date of the issuer file |
| `docs` | `string` |  |
| `exchange` | `string` | binance, bybit, okx, hyperliquid or kraken |
| `flowUsd` | `string | null` | Net flow for the day in USD, derived from the change in the fund's reported holdings |
| `fundingAnnualized` | `number | null` | Annualized rate, simple (not compounded), from the rate and its funding interval |
| `fundingIntervalHours` | `number` | Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken) |
| `fundingRate` | `string | null` | Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval) |
| `fundingRate8h` | `number | null` | The rate scaled to eight hours, comparable across venues |
| `holdings` | `string | null` | Coins held per the issuer file |
| `hour` | `string` | Hour bucket, ISO |
| `hyperliquidCoin` | `string | null` | Hyperliquid coin |
| `id` | `number` | Event id |
| `issuer` | `string` | Issuer name |
| `krakenSymbol` | `string | null` | Kraken Futures symbol |
| `license` | `string` | Data terms |
| `longShortRatio` | `string | null` | Global long/short account ratio where the venue publishes it, else null |
| `longUsd` | `number` | Long liquidations in USD |
| `markPrice` | `string | null` | Latest mark price in USD |
| `maxSingleUsd` | `number` | Largest single event |
| `meta` | `Record<string, any>` | Who publishes the data and how to credit it |
| `nextFundingTime` | `string | null` | ISO timestamp of the next funding settlement |
| `okxInstId` | `string | null` | OKX instrument id |
| `openInterest` | `string | null` | Open interest in contracts |
| `openInterestValue` | `string | null` | Open interest notional in USD |
| `price` | `string` | Liquidation price |
| `priceChangePct24h` | `string | null` | 24h price change as a decimal |
| `qty` | `string` | Quantity in coins |
| `rawSymbol` | `string` | Contract as the exchange names it |
| `shortUsd` | `number` | Short liquidations in USD |
| `side` | `string` | long (forced sale) or short (forced buy) |
| `slug` | `string` | Symbol slug used in URLs (btc, eth, sol...) |
| `source` | `string` |  |
| `symbol` | `string` | Contract (only when filtered) |
| `ticker` | `string` | Fund ticker (IBIT, ETHA...) |
| `totalUsd` | `number` | Total in USD |
| `ts` | `string` | Event time, ISO |
| `updatedAt` | `string` | When the response was built; a few dated feeds give the date of their newest row instead |
| `usdValue` | `string` | Notional in USD |

#### Example: Load

```ts
const crypto = await client.Crypto().load({ coin: 'coin' })
```

#### Example: List

```ts
const cryptos = await client.Crypto().list()
```


### Macro

Create an instance: `const macro = client.Macro()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `actual` | `string | null` | Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...) |
| `assetMgrLong` | `number | null` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assetMgrShort` | `number | null` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assets` | `number` | Fed total assets, USD (WALCL) |
| `attribution` | `string` |  |
| `auctionDate` | `string` | Auction date |
| `bidToCover` | `number | null` | Tendered divided by accepted |
| `canonicalUrl` | `string` | The matching page on xoomar.com |
| `country` | `string` | Economy |
| `countryCode` | `string` | BIS area code |
| `cusip` | `string` | Security CUSIP; a reopening shares the original's CUSIP |
| `data` | `any[]` |  |
| `date` | `string` | H.4.1 Wednesday date |
| `dealerAccepted` | `number | null` | Accepted by primary dealers, USD |
| `dealerLong` | `number | null` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `dealerShare` | `number | null` | Dealer share of accepted, 0 to 1 |
| `dealerShort` | `number | null` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `directAccepted` | `number | null` | Accepted from direct bidders, USD |
| `directShare` | `number | null` | Direct share of accepted, 0 to 1 |
| `docs` | `string` |  |
| `eventName` | `string` | CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ... |
| `forecast` | `string | null` | Always null: consensus forecasts aren't included |
| `group` | `string` | currencies, indices, crypto, metals, energy, bonds, agriculture, other |
| `highRate` | `number | null` | High discount rate (bills) or high discount margin (FRNs), percent |
| `highYield` | `number | null` | Stop-out yield, percent (notes, bonds, TIPS) |
| `importance` | `string` | high, med, or low |
| `indirectAccepted` | `number | null` | Accepted from indirect bidders, USD |
| `indirectShare` | `number | null` | Indirect share of accepted, 0 to 1 |
| `interestRate` | `number | null` | Coupon set at auction, percent |
| `issueDate` | `string | null` | Settlement date |
| `lastChanged` | `string | null` | Date of the most recent move |
| `levFundLong` | `number | null` | Leveraged funds (tff); managed money (disagg) |
| `levFundShort` | `number | null` | Leveraged funds (tff); managed money (disagg) |
| `license` | `string` | Data terms |
| `m1_m6` | `string | null` | 1, 2, 3, 6 month Treasury yields in percent |
| `maturityDate` | `string | null` | Maturity |
| `meta` | `Record<string, any>` | Who publishes the data and how to credit it |
| `name` | `string` | CFTC contract market name |
| `net` | `number` | assets minus tga minus rrp, USD |
| `nonreptLong` | `number | null` | Non-reportable (small trader) positions |
| `nonreptShort` | `number | null` | Non-reportable (small trader) positions |
| `offeringAmount` | `number | null` | Announced size, USD |
| `openInterest` | `number | null` | Total open interest in contracts |
| `otherLong` | `number | null` | Other reportable positions |
| `otherShort` | `number | null` | Other reportable positions |
| `periodLabel` | `string | null` | Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05' |
| `previous` | `string | null` | Prior period on the same basis as actual |
| `rate` | `string` | Policy rate, percent |
| `reopening` | `boolean | null` | True when the auction adds to an existing issue |
| `reportDate` | `string` | CFTC report Tuesday, YYYY-MM-DD |
| `reportType` | `string` | tff (financial futures) or disagg (commodities) |
| `reserves` | `number | null` | Reserve balances with Federal Reserve Banks, USD (WRESBAL) |
| `rrp` | `number` | Overnight reverse repo usage on that date, USD (RRPONTSYD) |
| `scheduledAt` | `string` | Release time, UTC |
| `securityTerm` | `string` | Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening) |
| `securityType` | `string` | Bill, CMB (cash management bill), Note, Bond, TIPS or FRN |
| `slug` | `string` | Market slug for URLs (euro-fx, gold...) |
| `sortRank` | `number` | Display order within the group |
| `source` | `string` | bls, bea, census, fed, dol or treasury (coupon auctions) |
| `tga` | `number` | Treasury General Account, USD (WTREGEN) |
| `totalAccepted` | `number | null` | Accepted, USD (null until results) |
| `totalTendered` | `number | null` | Bids received, USD |
| `unit` | `string | null` | What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance' |
| `updatedAt` | `string` | When the response was built; a few dated feeds give the date of their newest row instead |
| `y1_y30` | `string | null` | 1 to 30 year Treasury yields in percent |

#### Example: Load

```ts
const macro = await client.Macro().load({ country: 'country' })
```

#### Example: List

```ts
const macros = await client.Macro().list()
```

## Features

This SDK ships 4 optional features. Each is **inactive until you
switch it on**, so an SDK you have not configured behaves exactly as if none of
them existed — no retries, no cache, no logging, no measurable overhead.

Activate a feature by name in the client options, alongside the options shown
above:

| Feature | What it does |
|---|---|
| [`ratelimit`](#ratelimit) | Rate limiting |
| [`retry`](#retry) | Retry |
| [`test`](#test) | Test transport |
| [`timeout`](#timeout) | Timeout |

> **Order matters for `ratelimit`, `retry`, `timeout`.** These wrap the
> transport, so each one wraps whatever is already installed: the order you
> activate them in IS the nesting order. Activating them as an ordered list
> rather than a map is what fixes that order.

### ratelimit

Rate limiting.

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

Set `feature.ratelimit.active` to enable it, then override any of the options above.

`ratelimit` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### retry

Retry.

| Option | Default |
|---|---|
| `active` | `false` |
| `factor` | `2` |
| `maxDelay` | `2000` |
| `minDelay` | `50` |
| `retries` | `2` |
| `statuses` | `[408, 425, 429, 500, 502, 503, 504]` |

Set `feature.retry.active` to enable it, then override any of the options above.

`retry` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### test

Test transport.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.test.active` to enable it, then override any of the options above.

### timeout

Timeout.

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

Set `feature.timeout.active` to enable it, then override any of the options above.

`timeout` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.


## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **RatelimitFeature**: Rate limiting
- **RetryFeature**: Retry
- **TestFeature**: Test transport
- **TimeoutFeature**: Timeout

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Module structure

```
xoomar-markets/
├── src/
│   ├── XoomarMarketsSDK.ts        # Main SDK class
│   ├── entity/             # Entity implementations
│   ├── feature/            # Built-in features (Base, Test, Log)
│   └── utility/            # Utility functions
├── test/                   # Test suites
└── dist/                   # Compiled output
```

Import the SDK from the package root:

```ts
import { XoomarMarketsSDK } from '@voxgig-sdk/xoomar-markets-sdk'
```

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const macro = client.Macro()
await macro.list()

// macro.data() now returns the macro data from the last `list`
// macro.match() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
