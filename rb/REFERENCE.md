# XoomarMarkets Ruby SDK Reference

Complete API reference for the XoomarMarkets Ruby SDK.


## XoomarMarketsSDK

### Constructor

```ruby
require_relative 'XoomarMarkets_sdk'

client = XoomarMarketsSDK.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Hash` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Hash` | Custom headers for all requests. |
| `options["feature"]` | `Hash` | Feature configuration. |
| `options["system"]` | `Hash` | System overrides (e.g. custom fetch). |


### Static Methods

#### `XoomarMarketsSDK.test(testopts = nil, sdkopts = nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```ruby
client = XoomarMarketsSDK.test
```


### Instance Methods

#### `Company(data = nil)`

Create a new `Company` entity instance. Pass `nil` for no initial data.

#### `Crypto(data = nil)`

Create a new `Crypto` entity instance. Pass `nil` for no initial data.

#### `Macro(data = nil)`

Create a new `Macro` entity instance. Pass `nil` for no initial data.

#### `options_map -> Hash`

Return a deep copy of the current SDK options.

#### `get_utility -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs = {}) -> Hash`

Make a direct HTTP request to any API endpoint. Returns a result hash
(`{ "ok" => ..., "status" => ..., "data" => ..., "err" => ... }`); it
does not raise — inspect `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Hash` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `Hash` | Query string parameters. |
| `fetchargs["headers"]` | `Hash` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (hashes are JSON-serialized). |
| `fetchargs["ctrl"]` | `Hash` | Control options (e.g. `{ "explain" => true }`). |

**Returns:** `Hash`

#### `prepare(fetchargs = {}) -> Hash`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`. Raises on error.

**Returns:** `Hash` (the fetch definition; raises on error)


---

## CompanyEntity

```ruby
company = client.Company
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accessionNo` | `Object` | No | The filing's accession number for reported rows; null for estimates |
| `actionDate` | `String` | No | Date the action was signed |
| `actionType` | `Object` | No | FPDS action type code |
| `aggregateMarketValue` | `Object` | No | Aggregate market value of the shares to be sold, USD |
| `amendmentNo` | `Object` | No | Amendment number; null for the original filing |
| `amountUsd` | `Float` | No | Dollars obligated by this action; negative for de-obligations |
| `approxSaleDate` | `Object` | No | Approximate date of sale |
| `asOf` | `Object` | No | Balance sheet date of the figures |
| `attribution` | `String` | No |  |
| `avgDailyVol` | `Object` | No | Average daily trading volume |
| `awardId` | `String` | No | Contract or order number (PIID) |
| `awardType` | `Object` | No | Definitive contract, delivery order, BPA call, purchase order |
| `awardingAgency` | `Object` | No | Awarding department and bureau |
| `awardingSubAgency` | `Object` | No | Awarding department and bureau |
| `barrierPct` | `Object` | No | Barrier/threshold as % of initial level. |
| `basis` | `Object` | No | Reference date for an estimated row; null for reported rows |
| `broker` | `Object` | No | Broker named in the notice |
| `buybacks` | `Float` | No | PaymentsForRepurchaseOfCommonStock for the fiscal year, USD |
| `buyers` | `Array` | No | Up to five buyers, largest first |
| `canonicalUrl` | `String` | No | The matching page on xoomar.com |
| `capPct` | `Object` | No | Maximum return as % of initial level when the note is capped |
| `changePct` | `Object` | No | Change in short quantity vs the prior report |
| `cik` | `String` | No | SEC CIK, ten digits |
| `company` | `String` | No | Filer name as on the filing |
| `companyName` | `String` | No | Filer name as on EDGAR |
| `costUsd` | `Object` | No | Cost basis as filed, USD |
| `coupon` | `Object` | No | Annual coupon %; null on preliminary filings, which are filed before the rate is set |
| `cusip` | `String` | No | CUSIP of the security |
| `data` | `Hash` | No |  |
| `date` | `String` | No | The reported date (filing date of the 8-K) or the estimated date |
| `dateOfFirstSale` | `Object` | No | ISO date; null when the first sale has yet to occur |
| `daysToCover` | `Object` | No | shortQty / avgDailyVol, FINRA-computed |
| `description` | `Object` | No | Security description as the SEC publishes it |
| `docUrl` | `String` | No | Link to the filing index on sec.gov |
| `docs` | `String` | No |  |
| `end` | `String` | No | Fiscal year end |
| `entityType` | `Object` | No | Corporation, Limited Partnership, LLC, Trust and so on |
| `eventDate` | `Object` | No | Date of the event that requires the filing |
| `eventLabels` | `Object` | No | Readable labels for each item |
| `exchange` | `Object` | No | Exchange named for the sale |
| `exemptions` | `Object` | No | Rule items claimed, e.g. |
| `fairValueUsd` | `Object` | No | Fair value of crypto assets as filed, USD |
| `filedAt` | `String` | No | SEC acceptance timestamp |
| `firstRegistration` | `Object` | No | Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing |
| `firstTxDate` | `String` | No | Earliest purchase in the window |
| `form` | `Object` | No | 10-Q or 10-K the figures come from |
| `formType` | `String` | No | S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT |
| `frame` | `String` | No | Fiscal year frame, e.g. |
| `fundType` | `Object` | No | Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only |
| `generatedId` | `Object` | No | USAspending award id; https://www.usaspending.gov/award/{generatedId} |
| `impliedPrice` | `Object` | No | fairValueUsd divided by units, the filing's own valuation per coin |
| `industryGroup` | `Object` | No | SEC industry category (Pooled Investment Fund for funds) |
| `insiderName` | `String` | No | Reporting officer, director, or 10% owner |
| `insiderTitle` | `Object` | No | Role at the company (CEO, CFO, Director...) |
| `insiders` | `Float` | No | Distinct insiders who bought on the open market in the window |
| `investorsCount` | `Object` | No | Investors who have already invested |
| `isAmendment` | `Boolean` | No | Form D/A |
| `issuer` | `String` | No | Filing entity (BofA Finance, Morgan Stanley Finance...) |
| `issuerCik` | `Object` | No | Issuer CIK, ten digits |
| `issuerName` | `String` | No | Issuer name as filed |
| `items` | `Object` | No | 8-K item numbers (2.02, 5.02...) |
| `latestFiledAt` | `Object` | No | When the latest of those filings reached EDGAR |
| `latestTxDate` | `String` | No | Latest purchase in the window |
| `license` | `String` | No | Data terms |
| `listed` | `Boolean` | No | Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now |
| `manager` | `String` | No | Manager |
| `market` | `String` | No | nasdaq or cboe |
| `meta` | `Hash` | No | Who publishes the data and how to credit it |
| `minimumInvestment` | `Object` | No | USD minimum accepted from an outside investor |
| `mod` | `Object` | No | Modification number; 0 or null is the original award |
| `naicsCode` | `Object` | No | Industry code of the work |
| `name` | `String` | No | Company |
| `netIncome` | `Object` | No | Net income for the same fiscal year, USD |
| `noteType` | `Object` | No | autocallable, buffered, barrier, or income. |
| `offeringAmount` | `Object` | No | Always null; offering amounts are not included |
| `percentOfClass` | `Object` | No | Percent of the class owned |
| `personName` | `String` | No | Person for whose account the shares are to be sold |
| `personType` | `Object` | No | Type of reporting person as filed, e.g. |
| `price` | `Object` | No | Closing price the SEC reports with the row, USD |
| `priceNote` | `Object` | No | "price not stated in the filing" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); "≈ $61.36, midpoint of the stated range $60.86 to $61.85" when the price is the midpoint of… |
| `pricePerShare` | `Object` | No | Reported price per share in USD |
| `pricingDate` | `Object` | No | Pricing/trade date when stated |
| `principalUsd` | `Object` | No | Aggregate principal when stated (final filings) |
| `quantity` | `Float` | No | Shares failed to deliver, as the SEC publishes them |
| `recipientName` | `String` | No | Recipient legal name as registered |
| `relationship` | `Object` | No | Relationship to the issuer, e.g. |
| `reportingCik` | `Object` | No | Reporting person's CIK, when filed |
| `reportingPerson` | `String` | No | Reporting person or entity |
| `revenue` | `Object` | No | Revenue for the same fiscal year, USD |
| `revenueRange` | `Object` | No | Issuer revenue range or fund net asset value range, as disclosed |
| `securityClass` | `Object` | No | Title of the class of securities |
| `securityName` | `Object` | No | Security name as listed |
| `securityTypes` | `Object` | No | equity, debt, options, pooled fund, other |
| `settlementDate` | `String` | No | Settlement date |
| `shares` | `Object` | No | Shares bought or sold |
| `sharesOwned` | `Object` | No | Shares beneficially owned |
| `shortExemptVolume` | `Object` | No | Short sales marked exempt |
| `shortQty` | `Object` | No | Total shares held short |
| `shortRatio` | `Object` | No | shortVolume divided by totalVolume |
| `shortVolume` | `Float` | No | Shares sold short that day, as reported to FINRA's facilities |
| `slug` | `String` | No | Fund slug for URLs |
| `source` | `String` | No |  |
| `state` | `Object` | No | Issuer state or country code |
| `status` | `String` | No | reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives) |
| `symbol` | `Object` | No | Ticker |
| `ticker` | `String` | No | Listed ticker |
| `totalAmountSold` | `Object` | No | USD sold as of the filing |
| `totalOfferingAmount` | `Object` | No | USD; null when indefinite |
| `totalVolume` | `Float` | No | Total shares reported to FINRA's facilities that day (not the consolidated tape) |
| `trades` | `Float` | No | Open-market purchase transactions in the window |
| `txDate` | `String` | No | Transaction date from the filing, YYYY-MM-DD |
| `underlyings` | `Object` | No | Parsed underlying symbols (SPX, NDX, NVDA...). |
| `units` | `Object` | No | Bitcoin held as tagged in the filing; null when the filing gives no usable count |
| `unitsOutstanding` | `Object` | No | Shares or units of the class outstanding |
| `unitsReliable` | `Boolean` | No | true when the filing gives a usable coin count |
| `unitsToSell` | `Object` | No | Shares or units to be sold |
| `updatedAt` | `String` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `url` | `String` | No | Hub page |
| `valueUsd` | `Object` | No | quantity times price, USD |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array of entities, one per record; `data_get` reads each record. Raises on error.

```ruby
results = client.Company.list
results.each { |item| puts item.data_get }
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get` reads, and raises on error.

```ruby
result = client.Company.load({ "slug" => "slug" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `CompanyEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## CryptoEntity

```ruby
crypto = client.Crypto
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `asset` | `String` | No | btc or eth |
| `attribution` | `String` | No |  |
| `aumUsd` | `Object` | No | Holdings valued in USD |
| `baseAsset` | `String` | No | Base asset ticker (BTC, ETH...) |
| `binanceSymbol` | `Object` | No | Binance symbol |
| `bitmexSymbol` | `Object` | No | Always null, kept so existing clients parse unchanged |
| `bybitSymbol` | `Object` | No | Bybit symbol |
| `canonicalUrl` | `String` | No | The matching page on xoomar.com |
| `count` | `Float` | No | Events |
| `data` | `Hash` | No |  |
| `date` | `String` | No | The as-of date of the issuer file |
| `docs` | `String` | No |  |
| `exchange` | `String` | No | binance, bybit, okx, hyperliquid or kraken |
| `flowUsd` | `Object` | No | Net flow for the day in USD, derived from the change in the fund's reported holdings |
| `fundingAnnualized` | `Object` | No | Annualized rate, simple (not compounded), from the rate and its funding interval |
| `fundingIntervalHours` | `Float` | No | Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken) |
| `fundingRate` | `Object` | No | Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval) |
| `fundingRate8h` | `Object` | No | The rate scaled to eight hours, comparable across venues |
| `holdings` | `Object` | No | Coins held per the issuer file |
| `hour` | `String` | No | Hour bucket, ISO |
| `hyperliquidCoin` | `Object` | No | Hyperliquid coin |
| `id` | `Float` | No | Event id |
| `issuer` | `String` | No | Issuer name |
| `krakenSymbol` | `Object` | No | Kraken Futures symbol |
| `license` | `String` | No | Data terms |
| `longShortRatio` | `Object` | No | Global long/short account ratio where the venue publishes it, else null |
| `longUsd` | `Float` | No | Long liquidations in USD |
| `markPrice` | `Object` | No | Latest mark price in USD |
| `maxSingleUsd` | `Float` | No | Largest single event |
| `meta` | `Hash` | No | Who publishes the data and how to credit it |
| `nextFundingTime` | `Object` | No | ISO timestamp of the next funding settlement |
| `okxInstId` | `Object` | No | OKX instrument id |
| `openInterest` | `Object` | No | Open interest in contracts |
| `openInterestValue` | `Object` | No | Open interest notional in USD |
| `price` | `String` | No | Liquidation price |
| `priceChangePct24h` | `Object` | No | 24h price change as a decimal |
| `qty` | `String` | No | Quantity in coins |
| `rawSymbol` | `String` | No | Contract as the exchange names it |
| `shortUsd` | `Float` | No | Short liquidations in USD |
| `side` | `String` | No | long (forced sale) or short (forced buy) |
| `slug` | `String` | No | Symbol slug used in URLs (btc, eth, sol...) |
| `source` | `String` | No |  |
| `symbol` | `String` | No | Contract (only when filtered) |
| `ticker` | `String` | No | Fund ticker (IBIT, ETHA...) |
| `totalUsd` | `Float` | No | Total in USD |
| `ts` | `String` | No | Event time, ISO |
| `updatedAt` | `String` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `usdValue` | `String` | No | Notional in USD |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array of entities, one per record; `data_get` reads each record. Raises on error.

```ruby
results = client.Crypto.list
results.each { |item| puts item.data_get }
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get` reads, and raises on error.

```ruby
result = client.Crypto.load({ "coin" => "coin" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `CryptoEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## MacroEntity

```ruby
macro = client.Macro
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `actual` | `Object` | No | Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...) |
| `assetMgrLong` | `Object` | No | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assetMgrShort` | `Object` | No | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assets` | `Float` | No | Fed total assets, USD (WALCL) |
| `attribution` | `String` | No |  |
| `auctionDate` | `String` | No | Auction date |
| `bidToCover` | `Object` | No | Tendered divided by accepted |
| `canonicalUrl` | `String` | No | The matching page on xoomar.com |
| `country` | `String` | No | Economy |
| `countryCode` | `String` | No | BIS area code |
| `cusip` | `String` | No | Security CUSIP; a reopening shares the original's CUSIP |
| `data` | `Array` | No |  |
| `date` | `String` | No | H.4.1 Wednesday date |
| `dealerAccepted` | `Object` | No | Accepted by primary dealers, USD |
| `dealerLong` | `Object` | No | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `dealerShare` | `Object` | No | Dealer share of accepted, 0 to 1 |
| `dealerShort` | `Object` | No | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `directAccepted` | `Object` | No | Accepted from direct bidders, USD |
| `directShare` | `Object` | No | Direct share of accepted, 0 to 1 |
| `docs` | `String` | No |  |
| `eventName` | `String` | No | CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ... |
| `forecast` | `Object` | No | Always null: consensus forecasts aren't included |
| `group` | `String` | No | currencies, indices, crypto, metals, energy, bonds, agriculture, other |
| `highRate` | `Object` | No | High discount rate (bills) or high discount margin (FRNs), percent |
| `highYield` | `Object` | No | Stop-out yield, percent (notes, bonds, TIPS) |
| `importance` | `String` | No | high, med, or low |
| `indirectAccepted` | `Object` | No | Accepted from indirect bidders, USD |
| `indirectShare` | `Object` | No | Indirect share of accepted, 0 to 1 |
| `interestRate` | `Object` | No | Coupon set at auction, percent |
| `issueDate` | `Object` | No | Settlement date |
| `lastChanged` | `Object` | No | Date of the most recent move |
| `levFundLong` | `Object` | No | Leveraged funds (tff); managed money (disagg) |
| `levFundShort` | `Object` | No | Leveraged funds (tff); managed money (disagg) |
| `license` | `String` | No | Data terms |
| `m1_m6` | `Object` | No | 1, 2, 3, 6 month Treasury yields in percent |
| `maturityDate` | `Object` | No | Maturity |
| `meta` | `Hash` | No | Who publishes the data and how to credit it |
| `name` | `String` | No | CFTC contract market name |
| `net` | `Float` | No | assets minus tga minus rrp, USD |
| `nonreptLong` | `Object` | No | Non-reportable (small trader) positions |
| `nonreptShort` | `Object` | No | Non-reportable (small trader) positions |
| `offeringAmount` | `Object` | No | Announced size, USD |
| `openInterest` | `Object` | No | Total open interest in contracts |
| `otherLong` | `Object` | No | Other reportable positions |
| `otherShort` | `Object` | No | Other reportable positions |
| `periodLabel` | `Object` | No | Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05' |
| `previous` | `Object` | No | Prior period on the same basis as actual |
| `rate` | `String` | No | Policy rate, percent |
| `reopening` | `Object` | No | True when the auction adds to an existing issue |
| `reportDate` | `String` | No | CFTC report Tuesday, YYYY-MM-DD |
| `reportType` | `String` | No | tff (financial futures) or disagg (commodities) |
| `reserves` | `Object` | No | Reserve balances with Federal Reserve Banks, USD (WRESBAL) |
| `rrp` | `Float` | No | Overnight reverse repo usage on that date, USD (RRPONTSYD) |
| `scheduledAt` | `String` | No | Release time, UTC |
| `securityTerm` | `String` | No | Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening) |
| `securityType` | `String` | No | Bill, CMB (cash management bill), Note, Bond, TIPS or FRN |
| `slug` | `String` | No | Market slug for URLs (euro-fx, gold...) |
| `sortRank` | `Float` | No | Display order within the group |
| `source` | `String` | No | bls, bea, census, fed, dol or treasury (coupon auctions) |
| `tga` | `Float` | No | Treasury General Account, USD (WTREGEN) |
| `totalAccepted` | `Object` | No | Accepted, USD (null until results) |
| `totalTendered` | `Object` | No | Bids received, USD |
| `unit` | `Object` | No | What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance' |
| `updatedAt` | `String` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `y1_y30` | `Object` | No | 1 to 30 year Treasury yields in percent |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array of entities, one per record; `data_get` reads each record. Raises on error.

```ruby
results = client.Macro.list
results.each { |item| puts item.data_get }
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get` reads, and raises on error.

```ruby
result = client.Macro.load({ "country" => "country" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `MacroEntity` instance with the same client and
options.

#### `get_name -> String`

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

```ruby
client = XoomarMarketsSDK.new({
  "feature" => {
    "ratelimit" => { "active" => true },
    "retry" => { "active" => true },
    "test" => { "active" => true },
    "timeout" => { "active" => true },
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

