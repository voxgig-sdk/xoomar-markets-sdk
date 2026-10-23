# XoomarMarkets Golang SDK Reference

Complete API reference for the XoomarMarkets Golang SDK.


## XoomarMarketsSDK

### Constructor

```go
func NewXoomarMarketsSDK(options map[string]any) *XoomarMarketsSDK
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `map[string]any` | SDK configuration options. |
| `options["apikey"]` | `string` | API key for authentication. |
| `options["base"]` | `string` | Base URL for API requests. |
| `options["prefix"]` | `string` | URL prefix appended after base. |
| `options["suffix"]` | `string` | URL suffix appended after path. |
| `options["headers"]` | `map[string]any` | Custom headers for all requests. |
| `options["feature"]` | `map[string]any` | Feature configuration. |
| `options["system"]` | `map[string]any` | System overrides (e.g. custom fetch). |


### Static Methods

#### `Test() *XoomarMarketsSDK`

No-arg convenience constructor for the common no-options test case.

```go
client := sdk.Test()
```

#### `TestSDK(testopts, sdkopts map[string]any) *XoomarMarketsSDK`

Test client with options. Both arguments may be `nil`.

```go
client := sdk.TestSDK(testopts, sdkopts)
```


### Instance Methods

#### `Company(data map[string]any) XoomarMarketsEntity`

Create a new `Company` entity instance. Pass `nil` for no initial data.

#### `Crypto(data map[string]any) XoomarMarketsEntity`

Create a new `Crypto` entity instance. Pass `nil` for no initial data.

#### `Macro(data map[string]any) XoomarMarketsEntity`

Create a new `Macro` entity instance. Pass `nil` for no initial data.

#### `OptionsMap() map[string]any`

Return a deep copy of the current SDK options.

#### `GetUtility() *Utility`

Return a copy of the SDK utility object.

#### `Direct(fetchargs map[string]any) (map[string]any, error)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `map[string]any` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `map[string]any` | Query string parameters. |
| `fetchargs["headers"]` | `map[string]any` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (maps are JSON-serialized). |
| `fetchargs["ctrl"]` | `map[string]any` | Control options (e.g. `map[string]any{"explain": true}`). |

**Returns:** `(map[string]any, error)`

#### `Prepare(fetchargs map[string]any) (map[string]any, error)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `Direct()`.

**Returns:** `(map[string]any, error)`


---

## CompanyEntity

```go
company := client.Company(nil)
fmt.Println(company.GetName()) // "company"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accessionNo` | `any` | No | The filing's accession number for reported rows; null for estimates |
| `actionDate` | `string` | No | Date the action was signed |
| `actionType` | `any` | No | FPDS action type code |
| `aggregateMarketValue` | `any` | No | Aggregate market value of the shares to be sold, USD |
| `amendmentNo` | `any` | No | Amendment number; null for the original filing |
| `amountUsd` | `float64` | No | Dollars obligated by this action; negative for de-obligations |
| `approxSaleDate` | `any` | No | Approximate date of sale |
| `asOf` | `any` | No | Balance sheet date of the figures |
| `attribution` | `string` | No |  |
| `avgDailyVol` | `any` | No | Average daily trading volume |
| `awardId` | `string` | No | Contract or order number (PIID) |
| `awardType` | `any` | No | Definitive contract, delivery order, BPA call, purchase order |
| `awardingAgency` | `any` | No | Awarding department and bureau |
| `awardingSubAgency` | `any` | No | Awarding department and bureau |
| `barrierPct` | `any` | No | Barrier/threshold as % of initial level. |
| `basis` | `any` | No | Reference date for an estimated row; null for reported rows |
| `broker` | `any` | No | Broker named in the notice |
| `buybacks` | `float64` | No | PaymentsForRepurchaseOfCommonStock for the fiscal year, USD |
| `buyers` | `[]any` | No | Up to five buyers, largest first |
| `canonicalUrl` | `string` | No | The matching page on xoomar.com |
| `capPct` | `any` | No | Maximum return as % of initial level when the note is capped |
| `changePct` | `any` | No | Change in short quantity vs the prior report |
| `cik` | `string` | No | SEC CIK, ten digits |
| `company` | `string` | No | Filer name as on the filing |
| `companyName` | `string` | No | Filer name as on EDGAR |
| `costUsd` | `any` | No | Cost basis as filed, USD |
| `coupon` | `any` | No | Annual coupon %; null on preliminary filings, which are filed before the rate is set |
| `cusip` | `string` | No | CUSIP of the security |
| `data` | `map[string]any` | No |  |
| `date` | `string` | No | The reported date (filing date of the 8-K) or the estimated date |
| `dateOfFirstSale` | `any` | No | ISO date; null when the first sale has yet to occur |
| `daysToCover` | `any` | No | shortQty / avgDailyVol, FINRA-computed |
| `description` | `any` | No | Security description as the SEC publishes it |
| `docUrl` | `string` | No | Link to the filing index on sec.gov |
| `docs` | `string` | No |  |
| `end` | `string` | No | Fiscal year end |
| `entityType` | `any` | No | Corporation, Limited Partnership, LLC, Trust and so on |
| `eventDate` | `any` | No | Date of the event that requires the filing |
| `eventLabels` | `any` | No | Readable labels for each item |
| `exchange` | `any` | No | Exchange named for the sale |
| `exemptions` | `any` | No | Rule items claimed, e.g. |
| `fairValueUsd` | `any` | No | Fair value of crypto assets as filed, USD |
| `filedAt` | `string` | No | SEC acceptance timestamp |
| `firstRegistration` | `any` | No | Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing |
| `firstTxDate` | `string` | No | Earliest purchase in the window |
| `form` | `any` | No | 10-Q or 10-K the figures come from |
| `formType` | `string` | No | S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT |
| `frame` | `string` | No | Fiscal year frame, e.g. |
| `fundType` | `any` | No | Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only |
| `generatedId` | `any` | No | USAspending award id; https://www.usaspending.gov/award/{generatedId} |
| `impliedPrice` | `any` | No | fairValueUsd divided by units, the filing's own valuation per coin |
| `industryGroup` | `any` | No | SEC industry category (Pooled Investment Fund for funds) |
| `insiderName` | `string` | No | Reporting officer, director, or 10% owner |
| `insiderTitle` | `any` | No | Role at the company (CEO, CFO, Director...) |
| `insiders` | `float64` | No | Distinct insiders who bought on the open market in the window |
| `investorsCount` | `any` | No | Investors who have already invested |
| `isAmendment` | `bool` | No | Form D/A |
| `issuer` | `string` | No | Filing entity (BofA Finance, Morgan Stanley Finance...) |
| `issuerCik` | `any` | No | Issuer CIK, ten digits |
| `issuerName` | `string` | No | Issuer name as filed |
| `items` | `any` | No | 8-K item numbers (2.02, 5.02...) |
| `latestFiledAt` | `any` | No | When the latest of those filings reached EDGAR |
| `latestTxDate` | `string` | No | Latest purchase in the window |
| `license` | `string` | No | Data terms |
| `listed` | `bool` | No | Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now |
| `manager` | `string` | No | Manager |
| `market` | `string` | No | nasdaq or cboe |
| `meta` | `map[string]any` | No | Who publishes the data and how to credit it |
| `minimumInvestment` | `any` | No | USD minimum accepted from an outside investor |
| `mod` | `any` | No | Modification number; 0 or null is the original award |
| `naicsCode` | `any` | No | Industry code of the work |
| `name` | `string` | No | Company |
| `netIncome` | `any` | No | Net income for the same fiscal year, USD |
| `noteType` | `any` | No | autocallable, buffered, barrier, or income. |
| `offeringAmount` | `any` | No | Always null; offering amounts are not included |
| `percentOfClass` | `any` | No | Percent of the class owned |
| `personName` | `string` | No | Person for whose account the shares are to be sold |
| `personType` | `any` | No | Type of reporting person as filed, e.g. |
| `price` | `any` | No | Closing price the SEC reports with the row, USD |
| `priceNote` | `any` | No | "price not stated in the filing" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); "≈ $61.36, midpoint of the stated range $60.86 to $61.85" when the price is the midpoint of… |
| `pricePerShare` | `any` | No | Reported price per share in USD |
| `pricingDate` | `any` | No | Pricing/trade date when stated |
| `principalUsd` | `any` | No | Aggregate principal when stated (final filings) |
| `quantity` | `float64` | No | Shares failed to deliver, as the SEC publishes them |
| `recipientName` | `string` | No | Recipient legal name as registered |
| `relationship` | `any` | No | Relationship to the issuer, e.g. |
| `reportingCik` | `any` | No | Reporting person's CIK, when filed |
| `reportingPerson` | `string` | No | Reporting person or entity |
| `revenue` | `any` | No | Revenue for the same fiscal year, USD |
| `revenueRange` | `any` | No | Issuer revenue range or fund net asset value range, as disclosed |
| `securityClass` | `any` | No | Title of the class of securities |
| `securityName` | `any` | No | Security name as listed |
| `securityTypes` | `any` | No | equity, debt, options, pooled fund, other |
| `settlementDate` | `string` | No | Settlement date |
| `shares` | `any` | No | Shares bought or sold |
| `sharesOwned` | `any` | No | Shares beneficially owned |
| `shortExemptVolume` | `any` | No | Short sales marked exempt |
| `shortQty` | `any` | No | Total shares held short |
| `shortRatio` | `any` | No | shortVolume divided by totalVolume |
| `shortVolume` | `float64` | No | Shares sold short that day, as reported to FINRA's facilities |
| `slug` | `string` | No | Fund slug for URLs |
| `source` | `string` | No |  |
| `state` | `any` | No | Issuer state or country code |
| `status` | `string` | No | reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives) |
| `symbol` | `any` | No | Ticker |
| `ticker` | `string` | No | Listed ticker |
| `totalAmountSold` | `any` | No | USD sold as of the filing |
| `totalOfferingAmount` | `any` | No | USD; null when indefinite |
| `totalVolume` | `float64` | No | Total shares reported to FINRA's facilities that day (not the consolidated tape) |
| `trades` | `float64` | No | Open-market purchase transactions in the window |
| `txDate` | `string` | No | Transaction date from the filing, YYYY-MM-DD |
| `underlyings` | `any` | No | Parsed underlying symbols (SPX, NDX, NVDA...). |
| `units` | `any` | No | Bitcoin held as tagged in the filing; null when the filing gives no usable count |
| `unitsOutstanding` | `any` | No | Shares or units of the class outstanding |
| `unitsReliable` | `bool` | No | true when the filing gives a usable coin count |
| `unitsToSell` | `any` | No | Shares or units to be sold |
| `updatedAt` | `string` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `url` | `string` | No | Hub page |
| `valueUsd` | `any` | No | quantity times price, USD |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns a `[]any` of entities, one per record; `err` is non-nil on failure.

```go
results, err := client.Company(nil).List(nil, nil)
if err != nil {
    panic(err)
}
for _, item := range results.([]any) {
    fmt.Println(item.(sdk.Entity).Data())
}
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria. Returns the entity, whose record `Data()` reads; `err` is non-nil on failure.

```go
result, err := client.Company(nil).Load(map[string]any{"slug": "slug"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result.(sdk.Entity).Data())
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `CompanyEntity` instance with the same client and
options.

#### `Stream(action string, args map[string]any, callopts map[string]any) <-chan StreamItem`

Run an operation through the pipeline and send its result items on the
returned channel, which closes when the stream ends. A `StreamItem` holds
one item in `Item`, or in `Err` the error that ended the stream: the
error the operation itself would return, sent as the last value. Under
`throw: false` in `callopts["ctrl"]`, no error is sent.

#### `GetName() string`

Return the entity name.


---

## CryptoEntity

```go
crypto := client.Crypto(nil)
fmt.Println(crypto.GetName()) // "crypto"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `asset` | `string` | No | btc or eth |
| `attribution` | `string` | No |  |
| `aumUsd` | `any` | No | Holdings valued in USD |
| `baseAsset` | `string` | No | Base asset ticker (BTC, ETH...) |
| `binanceSymbol` | `any` | No | Binance symbol |
| `bitmexSymbol` | `any` | No | Always null, kept so existing clients parse unchanged |
| `bybitSymbol` | `any` | No | Bybit symbol |
| `canonicalUrl` | `string` | No | The matching page on xoomar.com |
| `count` | `float64` | No | Events |
| `data` | `map[string]any` | No |  |
| `date` | `string` | No | The as-of date of the issuer file |
| `docs` | `string` | No |  |
| `exchange` | `string` | No | binance, bybit, okx, hyperliquid or kraken |
| `flowUsd` | `any` | No | Net flow for the day in USD, derived from the change in the fund's reported holdings |
| `fundingAnnualized` | `any` | No | Annualized rate, simple (not compounded), from the rate and its funding interval |
| `fundingIntervalHours` | `float64` | No | Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken) |
| `fundingRate` | `any` | No | Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval) |
| `fundingRate8h` | `any` | No | The rate scaled to eight hours, comparable across venues |
| `holdings` | `any` | No | Coins held per the issuer file |
| `hour` | `string` | No | Hour bucket, ISO |
| `hyperliquidCoin` | `any` | No | Hyperliquid coin |
| `id` | `float64` | No | Event id |
| `issuer` | `string` | No | Issuer name |
| `krakenSymbol` | `any` | No | Kraken Futures symbol |
| `license` | `string` | No | Data terms |
| `longShortRatio` | `any` | No | Global long/short account ratio where the venue publishes it, else null |
| `longUsd` | `float64` | No | Long liquidations in USD |
| `markPrice` | `any` | No | Latest mark price in USD |
| `maxSingleUsd` | `float64` | No | Largest single event |
| `meta` | `map[string]any` | No | Who publishes the data and how to credit it |
| `nextFundingTime` | `any` | No | ISO timestamp of the next funding settlement |
| `okxInstId` | `any` | No | OKX instrument id |
| `openInterest` | `any` | No | Open interest in contracts |
| `openInterestValue` | `any` | No | Open interest notional in USD |
| `price` | `string` | No | Liquidation price |
| `priceChangePct24h` | `any` | No | 24h price change as a decimal |
| `qty` | `string` | No | Quantity in coins |
| `rawSymbol` | `string` | No | Contract as the exchange names it |
| `shortUsd` | `float64` | No | Short liquidations in USD |
| `side` | `string` | No | long (forced sale) or short (forced buy) |
| `slug` | `string` | No | Symbol slug used in URLs (btc, eth, sol...) |
| `source` | `string` | No |  |
| `symbol` | `string` | No | Contract (only when filtered) |
| `ticker` | `string` | No | Fund ticker (IBIT, ETHA...) |
| `totalUsd` | `float64` | No | Total in USD |
| `ts` | `string` | No | Event time, ISO |
| `updatedAt` | `string` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `usdValue` | `string` | No | Notional in USD |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns a `[]any` of entities, one per record; `err` is non-nil on failure.

```go
results, err := client.Crypto(nil).List(nil, nil)
if err != nil {
    panic(err)
}
for _, item := range results.([]any) {
    fmt.Println(item.(sdk.Entity).Data())
}
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria. Returns the entity, whose record `Data()` reads; `err` is non-nil on failure.

```go
result, err := client.Crypto(nil).Load(map[string]any{"coin": "coin"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result.(sdk.Entity).Data())
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `CryptoEntity` instance with the same client and
options.

#### `Stream(action string, args map[string]any, callopts map[string]any) <-chan StreamItem`

Run an operation through the pipeline and send its result items on the
returned channel, which closes when the stream ends. A `StreamItem` holds
one item in `Item`, or in `Err` the error that ended the stream: the
error the operation itself would return, sent as the last value. Under
`throw: false` in `callopts["ctrl"]`, no error is sent.

#### `GetName() string`

Return the entity name.


---

## MacroEntity

```go
macro := client.Macro(nil)
fmt.Println(macro.GetName()) // "macro"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `actual` | `any` | No | Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...) |
| `assetMgrLong` | `any` | No | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assetMgrShort` | `any` | No | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assets` | `float64` | No | Fed total assets, USD (WALCL) |
| `attribution` | `string` | No |  |
| `auctionDate` | `string` | No | Auction date |
| `bidToCover` | `any` | No | Tendered divided by accepted |
| `canonicalUrl` | `string` | No | The matching page on xoomar.com |
| `country` | `string` | No | Economy |
| `countryCode` | `string` | No | BIS area code |
| `cusip` | `string` | No | Security CUSIP; a reopening shares the original's CUSIP |
| `data` | `[]any` | No |  |
| `date` | `string` | No | H.4.1 Wednesday date |
| `dealerAccepted` | `any` | No | Accepted by primary dealers, USD |
| `dealerLong` | `any` | No | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `dealerShare` | `any` | No | Dealer share of accepted, 0 to 1 |
| `dealerShort` | `any` | No | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `directAccepted` | `any` | No | Accepted from direct bidders, USD |
| `directShare` | `any` | No | Direct share of accepted, 0 to 1 |
| `docs` | `string` | No |  |
| `eventName` | `string` | No | CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ... |
| `forecast` | `any` | No | Always null: consensus forecasts aren't included |
| `group` | `string` | No | currencies, indices, crypto, metals, energy, bonds, agriculture, other |
| `highRate` | `any` | No | High discount rate (bills) or high discount margin (FRNs), percent |
| `highYield` | `any` | No | Stop-out yield, percent (notes, bonds, TIPS) |
| `importance` | `string` | No | high, med, or low |
| `indirectAccepted` | `any` | No | Accepted from indirect bidders, USD |
| `indirectShare` | `any` | No | Indirect share of accepted, 0 to 1 |
| `interestRate` | `any` | No | Coupon set at auction, percent |
| `issueDate` | `any` | No | Settlement date |
| `lastChanged` | `any` | No | Date of the most recent move |
| `levFundLong` | `any` | No | Leveraged funds (tff); managed money (disagg) |
| `levFundShort` | `any` | No | Leveraged funds (tff); managed money (disagg) |
| `license` | `string` | No | Data terms |
| `m1_m6` | `any` | No | 1, 2, 3, 6 month Treasury yields in percent |
| `maturityDate` | `any` | No | Maturity |
| `meta` | `map[string]any` | No | Who publishes the data and how to credit it |
| `name` | `string` | No | CFTC contract market name |
| `net` | `float64` | No | assets minus tga minus rrp, USD |
| `nonreptLong` | `any` | No | Non-reportable (small trader) positions |
| `nonreptShort` | `any` | No | Non-reportable (small trader) positions |
| `offeringAmount` | `any` | No | Announced size, USD |
| `openInterest` | `any` | No | Total open interest in contracts |
| `otherLong` | `any` | No | Other reportable positions |
| `otherShort` | `any` | No | Other reportable positions |
| `periodLabel` | `any` | No | Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05' |
| `previous` | `any` | No | Prior period on the same basis as actual |
| `rate` | `string` | No | Policy rate, percent |
| `reopening` | `any` | No | True when the auction adds to an existing issue |
| `reportDate` | `string` | No | CFTC report Tuesday, YYYY-MM-DD |
| `reportType` | `string` | No | tff (financial futures) or disagg (commodities) |
| `reserves` | `any` | No | Reserve balances with Federal Reserve Banks, USD (WRESBAL) |
| `rrp` | `float64` | No | Overnight reverse repo usage on that date, USD (RRPONTSYD) |
| `scheduledAt` | `string` | No | Release time, UTC |
| `securityTerm` | `string` | No | Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening) |
| `securityType` | `string` | No | Bill, CMB (cash management bill), Note, Bond, TIPS or FRN |
| `slug` | `string` | No | Market slug for URLs (euro-fx, gold...) |
| `sortRank` | `float64` | No | Display order within the group |
| `source` | `string` | No | bls, bea, census, fed, dol or treasury (coupon auctions) |
| `tga` | `float64` | No | Treasury General Account, USD (WTREGEN) |
| `totalAccepted` | `any` | No | Accepted, USD (null until results) |
| `totalTendered` | `any` | No | Bids received, USD |
| `unit` | `any` | No | What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance' |
| `updatedAt` | `string` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `y1_y30` | `any` | No | 1 to 30 year Treasury yields in percent |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns a `[]any` of entities, one per record; `err` is non-nil on failure.

```go
results, err := client.Macro(nil).List(nil, nil)
if err != nil {
    panic(err)
}
for _, item := range results.([]any) {
    fmt.Println(item.(sdk.Entity).Data())
}
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria. Returns the entity, whose record `Data()` reads; `err` is non-nil on failure.

```go
result, err := client.Macro(nil).Load(map[string]any{"country": "country"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result.(sdk.Entity).Data())
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `MacroEntity` instance with the same client and
options.

#### `Stream(action string, args map[string]any, callopts map[string]any) <-chan StreamItem`

Run an operation through the pipeline and send its result items on the
returned channel, which closes when the stream ends. A `StreamItem` holds
one item in `Item`, or in `Err` the error that ended the stream: the
error the operation itself would return, sent as the last value. Under
`throw: false` in `callopts["ctrl"]`, no error is sent.

#### `GetName() string`

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

```go
client := sdk.NewXoomarMarketsSDK(map[string]any{
    "feature": map[string]any{
        "ratelimit": map[string]any{"active": true},
        "retry": map[string]any{"active": true},
        "test": map[string]any{"active": true},
        "timeout": map[string]any{"active": true},
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

