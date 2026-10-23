# XoomarMarkets Lua SDK Reference

Complete API reference for the XoomarMarkets Lua SDK.


## XoomarMarketsSDK

### Constructor

```lua
local sdk = require("xoomar-markets_sdk")
local client = sdk.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `table` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `table` | Custom headers for all requests. |
| `options.feature` | `table` | Feature configuration. |
| `options.system` | `table` | System overrides (e.g. custom fetch). |


### Static Methods

#### `sdk.test(testopts?, sdkopts?)`

Create a test client with mock features active. Both arguments are optional.

```lua
local client = sdk.test()
```


### Instance Methods

#### `Company(data)`

Create a new `Company` entity instance. Pass `nil` for no initial data.

#### `Crypto(data)`

Create a new `Crypto` entity instance. Pass `nil` for no initial data.

#### `Macro(data)`

Create a new `Macro` entity instance. Pass `nil` for no initial data.

#### `options_map() -> table`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> table, err`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs.params` | `table` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `table` | Query string parameters. |
| `fetchargs.headers` | `table` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (tables are JSON-serialized). |
| `fetchargs.ctrl` | `table` | Control options (e.g. `{ explain = true }`). |

**Returns:** `table, err`

#### `prepare(fetchargs) -> table, err`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `table, err`


---

## CompanyEntity

```lua
local company = client:Company(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accessionNo` | `string|nil` | No | The filing's accession number for reported rows; null for estimates |
| `actionDate` | `string` | No | Date the action was signed |
| `actionType` | `string|nil` | No | FPDS action type code |
| `aggregateMarketValue` | `number|nil` | No | Aggregate market value of the shares to be sold, USD |
| `amendmentNo` | `number|nil` | No | Amendment number; null for the original filing |
| `amountUsd` | `number` | No | Dollars obligated by this action; negative for de-obligations |
| `approxSaleDate` | `string|nil` | No | Approximate date of sale |
| `asOf` | `string|nil` | No | Balance sheet date of the figures |
| `attribution` | `string` | No |  |
| `avgDailyVol` | `number|nil` | No | Average daily trading volume |
| `awardId` | `string` | No | Contract or order number (PIID) |
| `awardType` | `string|nil` | No | Definitive contract, delivery order, BPA call, purchase order |
| `awardingAgency` | `string|nil` | No | Awarding department and bureau |
| `awardingSubAgency` | `string|nil` | No | Awarding department and bureau |
| `barrierPct` | `string|nil` | No | Barrier/threshold as % of initial level. |
| `basis` | `string|nil` | No | Reference date for an estimated row; null for reported rows |
| `broker` | `string|nil` | No | Broker named in the notice |
| `buybacks` | `number` | No | PaymentsForRepurchaseOfCommonStock for the fiscal year, USD |
| `buyers` | `table` | No | Up to five buyers, largest first |
| `canonicalUrl` | `string` | No | The matching page on xoomar.com |
| `capPct` | `string|nil` | No | Maximum return as % of initial level when the note is capped |
| `changePct` | `string|nil` | No | Change in short quantity vs the prior report |
| `cik` | `string` | No | SEC CIK, ten digits |
| `company` | `string` | No | Filer name as on the filing |
| `companyName` | `string` | No | Filer name as on EDGAR |
| `costUsd` | `number|nil` | No | Cost basis as filed, USD |
| `coupon` | `string|nil` | No | Annual coupon %; null on preliminary filings, which are filed before the rate is set |
| `cusip` | `string` | No | CUSIP of the security |
| `data` | `table` | No |  |
| `date` | `string` | No | The reported date (filing date of the 8-K) or the estimated date |
| `dateOfFirstSale` | `string|nil` | No | ISO date; null when the first sale has yet to occur |
| `daysToCover` | `string|nil` | No | shortQty / avgDailyVol, FINRA-computed |
| `description` | `string|nil` | No | Security description as the SEC publishes it |
| `docUrl` | `string` | No | Link to the filing index on sec.gov |
| `docs` | `string` | No |  |
| `end` | `string` | No | Fiscal year end |
| `entityType` | `string|nil` | No | Corporation, Limited Partnership, LLC, Trust and so on |
| `eventDate` | `string|nil` | No | Date of the event that requires the filing |
| `eventLabels` | `table|nil` | No | Readable labels for each item |
| `exchange` | `string|nil` | No | Exchange named for the sale |
| `exemptions` | `string|nil` | No | Rule items claimed, e.g. |
| `fairValueUsd` | `number|nil` | No | Fair value of crypto assets as filed, USD |
| `filedAt` | `string` | No | SEC acceptance timestamp |
| `firstRegistration` | `string|nil` | No | Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing |
| `firstTxDate` | `string` | No | Earliest purchase in the window |
| `form` | `string|nil` | No | 10-Q or 10-K the figures come from |
| `formType` | `string` | No | S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT |
| `frame` | `string` | No | Fiscal year frame, e.g. |
| `fundType` | `string|nil` | No | Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only |
| `generatedId` | `string|nil` | No | USAspending award id; https://www.usaspending.gov/award/{generatedId} |
| `impliedPrice` | `number|nil` | No | fairValueUsd divided by units, the filing's own valuation per coin |
| `industryGroup` | `string|nil` | No | SEC industry category (Pooled Investment Fund for funds) |
| `insiderName` | `string` | No | Reporting officer, director, or 10% owner |
| `insiderTitle` | `string|nil` | No | Role at the company (CEO, CFO, Director...) |
| `insiders` | `number` | No | Distinct insiders who bought on the open market in the window |
| `investorsCount` | `number|nil` | No | Investors who have already invested |
| `isAmendment` | `boolean` | No | Form D/A |
| `issuer` | `string` | No | Filing entity (BofA Finance, Morgan Stanley Finance...) |
| `issuerCik` | `string|nil` | No | Issuer CIK, ten digits |
| `issuerName` | `string` | No | Issuer name as filed |
| `items` | `table|nil` | No | 8-K item numbers (2.02, 5.02...) |
| `latestFiledAt` | `string|nil` | No | When the latest of those filings reached EDGAR |
| `latestTxDate` | `string` | No | Latest purchase in the window |
| `license` | `string` | No | Data terms |
| `listed` | `boolean` | No | Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now |
| `manager` | `string` | No | Manager |
| `market` | `string` | No | nasdaq or cboe |
| `meta` | `table` | No | Who publishes the data and how to credit it |
| `minimumInvestment` | `number|nil` | No | USD minimum accepted from an outside investor |
| `mod` | `string|nil` | No | Modification number; 0 or null is the original award |
| `naicsCode` | `string|nil` | No | Industry code of the work |
| `name` | `string` | No | Company |
| `netIncome` | `number|nil` | No | Net income for the same fiscal year, USD |
| `noteType` | `string|nil` | No | autocallable, buffered, barrier, or income. |
| `offeringAmount` | `number|nil` | No | Always null; offering amounts are not included |
| `percentOfClass` | `number|nil` | No | Percent of the class owned |
| `personName` | `string` | No | Person for whose account the shares are to be sold |
| `personType` | `string|nil` | No | Type of reporting person as filed, e.g. |
| `price` | `number|nil` | No | Closing price the SEC reports with the row, USD |
| `priceNote` | `string|nil` | No | "price not stated in the filing" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); "≈ $61.36, midpoint of the stated range $60.86 to $61.85" when the price is the midpoint of… |
| `pricePerShare` | `string|nil` | No | Reported price per share in USD |
| `pricingDate` | `string|nil` | No | Pricing/trade date when stated |
| `principalUsd` | `string|nil` | No | Aggregate principal when stated (final filings) |
| `quantity` | `number` | No | Shares failed to deliver, as the SEC publishes them |
| `recipientName` | `string` | No | Recipient legal name as registered |
| `relationship` | `string|nil` | No | Relationship to the issuer, e.g. |
| `reportingCik` | `string|nil` | No | Reporting person's CIK, when filed |
| `reportingPerson` | `string` | No | Reporting person or entity |
| `revenue` | `number|nil` | No | Revenue for the same fiscal year, USD |
| `revenueRange` | `string|nil` | No | Issuer revenue range or fund net asset value range, as disclosed |
| `securityClass` | `string|nil` | No | Title of the class of securities |
| `securityName` | `string|nil` | No | Security name as listed |
| `securityTypes` | `string|nil` | No | equity, debt, options, pooled fund, other |
| `settlementDate` | `string` | No | Settlement date |
| `shares` | `string|nil` | No | Shares bought or sold |
| `sharesOwned` | `number|nil` | No | Shares beneficially owned |
| `shortExemptVolume` | `number|nil` | No | Short sales marked exempt |
| `shortQty` | `number|nil` | No | Total shares held short |
| `shortRatio` | `number|nil` | No | shortVolume divided by totalVolume |
| `shortVolume` | `number` | No | Shares sold short that day, as reported to FINRA's facilities |
| `slug` | `string` | No | Fund slug for URLs |
| `source` | `string` | No |  |
| `state` | `string|nil` | No | Issuer state or country code |
| `status` | `string` | No | reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives) |
| `symbol` | `string|nil` | No | Ticker |
| `ticker` | `string` | No | Listed ticker |
| `totalAmountSold` | `number|nil` | No | USD sold as of the filing |
| `totalOfferingAmount` | `number|nil` | No | USD; null when indefinite |
| `totalVolume` | `number` | No | Total shares reported to FINRA's facilities that day (not the consolidated tape) |
| `trades` | `number` | No | Open-market purchase transactions in the window |
| `txDate` | `string` | No | Transaction date from the filing, YYYY-MM-DD |
| `underlyings` | `table|nil` | No | Parsed underlying symbols (SPX, NDX, NVDA...). |
| `units` | `number|nil` | No | Bitcoin held as tagged in the filing; null when the filing gives no usable count |
| `unitsOutstanding` | `number|nil` | No | Shares or units of the class outstanding |
| `unitsReliable` | `boolean` | No | true when the filing gives a usable coin count |
| `unitsToSell` | `number|nil` | No | Shares or units to be sold |
| `updatedAt` | `string` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `url` | `string` | No | Hub page |
| `valueUsd` | `number|nil` | No | quantity times price, USD |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array of entities, one per record, or `nil` and an error on failure.

```lua
local results, err = client:Company():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, or `nil` and an error on failure.

```lua
local result, err = client:Company():load({ slug = "slug" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CompanyEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## CryptoEntity

```lua
local crypto = client:Crypto(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `asset` | `string` | No | btc or eth |
| `attribution` | `string` | No |  |
| `aumUsd` | `string|nil` | No | Holdings valued in USD |
| `baseAsset` | `string` | No | Base asset ticker (BTC, ETH...) |
| `binanceSymbol` | `string|nil` | No | Binance symbol |
| `bitmexSymbol` | `string|nil` | No | Always null, kept so existing clients parse unchanged |
| `bybitSymbol` | `string|nil` | No | Bybit symbol |
| `canonicalUrl` | `string` | No | The matching page on xoomar.com |
| `count` | `number` | No | Events |
| `data` | `table` | No |  |
| `date` | `string` | No | The as-of date of the issuer file |
| `docs` | `string` | No |  |
| `exchange` | `string` | No | binance, bybit, okx, hyperliquid or kraken |
| `flowUsd` | `string|nil` | No | Net flow for the day in USD, derived from the change in the fund's reported holdings |
| `fundingAnnualized` | `number|nil` | No | Annualized rate, simple (not compounded), from the rate and its funding interval |
| `fundingIntervalHours` | `number` | No | Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken) |
| `fundingRate` | `string|nil` | No | Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval) |
| `fundingRate8h` | `number|nil` | No | The rate scaled to eight hours, comparable across venues |
| `holdings` | `string|nil` | No | Coins held per the issuer file |
| `hour` | `string` | No | Hour bucket, ISO |
| `hyperliquidCoin` | `string|nil` | No | Hyperliquid coin |
| `id` | `number` | No | Event id |
| `issuer` | `string` | No | Issuer name |
| `krakenSymbol` | `string|nil` | No | Kraken Futures symbol |
| `license` | `string` | No | Data terms |
| `longShortRatio` | `string|nil` | No | Global long/short account ratio where the venue publishes it, else null |
| `longUsd` | `number` | No | Long liquidations in USD |
| `markPrice` | `string|nil` | No | Latest mark price in USD |
| `maxSingleUsd` | `number` | No | Largest single event |
| `meta` | `table` | No | Who publishes the data and how to credit it |
| `nextFundingTime` | `string|nil` | No | ISO timestamp of the next funding settlement |
| `okxInstId` | `string|nil` | No | OKX instrument id |
| `openInterest` | `string|nil` | No | Open interest in contracts |
| `openInterestValue` | `string|nil` | No | Open interest notional in USD |
| `price` | `string` | No | Liquidation price |
| `priceChangePct24h` | `string|nil` | No | 24h price change as a decimal |
| `qty` | `string` | No | Quantity in coins |
| `rawSymbol` | `string` | No | Contract as the exchange names it |
| `shortUsd` | `number` | No | Short liquidations in USD |
| `side` | `string` | No | long (forced sale) or short (forced buy) |
| `slug` | `string` | No | Symbol slug used in URLs (btc, eth, sol...) |
| `source` | `string` | No |  |
| `symbol` | `string` | No | Contract (only when filtered) |
| `ticker` | `string` | No | Fund ticker (IBIT, ETHA...) |
| `totalUsd` | `number` | No | Total in USD |
| `ts` | `string` | No | Event time, ISO |
| `updatedAt` | `string` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `usdValue` | `string` | No | Notional in USD |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array of entities, one per record, or `nil` and an error on failure.

```lua
local results, err = client:Crypto():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, or `nil` and an error on failure.

```lua
local result, err = client:Crypto():load({ coin = "coin" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CryptoEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## MacroEntity

```lua
local macro = client:Macro(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `actual` | `string|nil` | No | Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...) |
| `assetMgrLong` | `number|nil` | No | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assetMgrShort` | `number|nil` | No | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assets` | `number` | No | Fed total assets, USD (WALCL) |
| `attribution` | `string` | No |  |
| `auctionDate` | `string` | No | Auction date |
| `bidToCover` | `number|nil` | No | Tendered divided by accepted |
| `canonicalUrl` | `string` | No | The matching page on xoomar.com |
| `country` | `string` | No | Economy |
| `countryCode` | `string` | No | BIS area code |
| `cusip` | `string` | No | Security CUSIP; a reopening shares the original's CUSIP |
| `data` | `table` | No |  |
| `date` | `string` | No | H.4.1 Wednesday date |
| `dealerAccepted` | `number|nil` | No | Accepted by primary dealers, USD |
| `dealerLong` | `number|nil` | No | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `dealerShare` | `number|nil` | No | Dealer share of accepted, 0 to 1 |
| `dealerShort` | `number|nil` | No | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `directAccepted` | `number|nil` | No | Accepted from direct bidders, USD |
| `directShare` | `number|nil` | No | Direct share of accepted, 0 to 1 |
| `docs` | `string` | No |  |
| `eventName` | `string` | No | CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ... |
| `forecast` | `string|nil` | No | Always null: consensus forecasts aren't included |
| `group` | `string` | No | currencies, indices, crypto, metals, energy, bonds, agriculture, other |
| `highRate` | `number|nil` | No | High discount rate (bills) or high discount margin (FRNs), percent |
| `highYield` | `number|nil` | No | Stop-out yield, percent (notes, bonds, TIPS) |
| `importance` | `string` | No | high, med, or low |
| `indirectAccepted` | `number|nil` | No | Accepted from indirect bidders, USD |
| `indirectShare` | `number|nil` | No | Indirect share of accepted, 0 to 1 |
| `interestRate` | `number|nil` | No | Coupon set at auction, percent |
| `issueDate` | `string|nil` | No | Settlement date |
| `lastChanged` | `string|nil` | No | Date of the most recent move |
| `levFundLong` | `number|nil` | No | Leveraged funds (tff); managed money (disagg) |
| `levFundShort` | `number|nil` | No | Leveraged funds (tff); managed money (disagg) |
| `license` | `string` | No | Data terms |
| `m1_m6` | `string|nil` | No | 1, 2, 3, 6 month Treasury yields in percent |
| `maturityDate` | `string|nil` | No | Maturity |
| `meta` | `table` | No | Who publishes the data and how to credit it |
| `name` | `string` | No | CFTC contract market name |
| `net` | `number` | No | assets minus tga minus rrp, USD |
| `nonreptLong` | `number|nil` | No | Non-reportable (small trader) positions |
| `nonreptShort` | `number|nil` | No | Non-reportable (small trader) positions |
| `offeringAmount` | `number|nil` | No | Announced size, USD |
| `openInterest` | `number|nil` | No | Total open interest in contracts |
| `otherLong` | `number|nil` | No | Other reportable positions |
| `otherShort` | `number|nil` | No | Other reportable positions |
| `periodLabel` | `string|nil` | No | Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05' |
| `previous` | `string|nil` | No | Prior period on the same basis as actual |
| `rate` | `string` | No | Policy rate, percent |
| `reopening` | `boolean|nil` | No | True when the auction adds to an existing issue |
| `reportDate` | `string` | No | CFTC report Tuesday, YYYY-MM-DD |
| `reportType` | `string` | No | tff (financial futures) or disagg (commodities) |
| `reserves` | `number|nil` | No | Reserve balances with Federal Reserve Banks, USD (WRESBAL) |
| `rrp` | `number` | No | Overnight reverse repo usage on that date, USD (RRPONTSYD) |
| `scheduledAt` | `string` | No | Release time, UTC |
| `securityTerm` | `string` | No | Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening) |
| `securityType` | `string` | No | Bill, CMB (cash management bill), Note, Bond, TIPS or FRN |
| `slug` | `string` | No | Market slug for URLs (euro-fx, gold...) |
| `sortRank` | `number` | No | Display order within the group |
| `source` | `string` | No | bls, bea, census, fed, dol or treasury (coupon auctions) |
| `tga` | `number` | No | Treasury General Account, USD (WTREGEN) |
| `totalAccepted` | `number|nil` | No | Accepted, USD (null until results) |
| `totalTendered` | `number|nil` | No | Bids received, USD |
| `unit` | `string|nil` | No | What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance' |
| `updatedAt` | `string` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `y1_y30` | `string|nil` | No | 1 to 30 year Treasury yields in percent |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array of entities, one per record, or `nil` and an error on failure.

```lua
local results, err = client:Macro():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, or `nil` and an error on failure.

```lua
local result, err = client:Macro():load({ country = "country" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `MacroEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `ratelimit` | 0.0.1 | Rate limiting |
| `retry` | 0.0.1 | Retry |
| `test` | 0.0.1 | Test transport |
| `timeout` | 0.0.1 | Timeout |


Features are activated via the `feature` option:

```lua
local client = sdk.new({
  feature = {
    ratelimit = { active = true },
    retry = { active = true },
    test = { active = true },
    timeout = { active = true },
  },
})
```


### Configuring features

Each feature is inactive until switched on, and an SDK with no feature
configured does no feature work at all. Every option below keeps its default
unless you name it.

The array form of \`feature\` is significant: several features wrap the
transport, and the order you list them in is the order they nest.

#### Ordering

`ratelimit`, `retry`, `timeout` wrap the transport. Each
wraps whatever is already installed, so **activation order is nesting order**:
a feature activated later sits OUTSIDE one activated earlier, and sees the call
first.

That decides behaviour, not just sequence: a feature that short-circuits the
call, such as a cache serving a hit, stops every feature nested inside it from
ever seeing that call.

`test` attach to pipeline hooks
rather than the transport, so their order does not affect what they observe.

#### `ratelimit`

Rate limiting.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

| Option | Type |
|---|---|
| `now` | function |
| `sleep` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.ratelimit.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `retry`

Retry.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `factor` | `2` |
| `maxDelay` | `2000` |
| `minDelay` | `50` |
| `retries` | `2` |
| `statuses` | `[408, 425, 429, 500, 502, 503, 504]` |

| Option | Type |
|---|---|
| `jitter` | boolean |
| `sleep` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.retry.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `test`

Test transport.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

| Option | Type |
|---|---|
| `entity` | map |
| `net` | map |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.test.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Installs the BASE transport that the wrapping features wrap, so it must be
  activated before them.
- Inactive by default: leaving it out costs nothing at runtime.

#### `timeout`

Timeout.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

| Option | Type |
|---|---|
| `clearTimer` | function |
| `now` | function |
| `setTimer` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.timeout.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

