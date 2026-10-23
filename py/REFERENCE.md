# XoomarMarkets Python SDK Reference

Complete API reference for the XoomarMarkets Python SDK.


## XoomarMarketsSDK

### Constructor

```python
from xoomarmarkets_sdk import XoomarMarketsSDK

client = XoomarMarketsSDK(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `dict` | SDK configuration options. |
| `options["apikey"]` | `str` | API key for authentication. |
| `options["base"]` | `str` | Base URL for API requests. |
| `options["prefix"]` | `str` | URL prefix appended after base. |
| `options["suffix"]` | `str` | URL suffix appended after path. |
| `options["headers"]` | `dict` | Custom headers for all requests. |
| `options["feature"]` | `dict` | Feature configuration. |
| `options["system"]` | `dict` | System overrides (e.g. custom fetch). |


### Static Methods

#### `XoomarMarketsSDK.test(testopts=None, sdkopts=None)`

Create a test client with mock features active. Both arguments may be `None`.

```python
client = XoomarMarketsSDK.test()
```


### Instance Methods

#### `Company(data=None)`

Create a new `CompanyEntity` instance. Pass `None` for no initial data.

#### `Crypto(data=None)`

Create a new `CryptoEntity` instance. Pass `None` for no initial data.

#### `Macro(data=None)`

Create a new `MacroEntity` instance. Pass `None` for no initial data.

#### `options_map() -> dict`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs=None) -> dict`

Make a direct HTTP request to any API endpoint. Returns a result `dict` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `str` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `str` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `dict` | Path parameter values. |
| `fetchargs["query"]` | `dict` | Query string parameters. |
| `fetchargs["headers"]` | `dict` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (dicts are JSON-serialized). |

**Returns:** `result_dict`

#### `prepare(fetchargs=None) -> dict`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## CompanyEntity

```python
company = client.Company()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accessionNo` | `str | None` | No | The filing's accession number for reported rows; null for estimates |
| `actionDate` | `str` | No | Date the action was signed |
| `actionType` | `str | None` | No | FPDS action type code |
| `aggregateMarketValue` | `float | None` | No | Aggregate market value of the shares to be sold, USD |
| `amendmentNo` | `float | None` | No | Amendment number; null for the original filing |
| `amountUsd` | `float` | No | Dollars obligated by this action; negative for de-obligations |
| `approxSaleDate` | `str | None` | No | Approximate date of sale |
| `asOf` | `str | None` | No | Balance sheet date of the figures |
| `attribution` | `str` | No |  |
| `avgDailyVol` | `float | None` | No | Average daily trading volume |
| `awardId` | `str` | No | Contract or order number (PIID) |
| `awardType` | `str | None` | No | Definitive contract, delivery order, BPA call, purchase order |
| `awardingAgency` | `str | None` | No | Awarding department and bureau |
| `awardingSubAgency` | `str | None` | No | Awarding department and bureau |
| `barrierPct` | `str | None` | No | Barrier/threshold as % of initial level. |
| `basis` | `str | None` | No | Reference date for an estimated row; null for reported rows |
| `broker` | `str | None` | No | Broker named in the notice |
| `buybacks` | `float` | No | PaymentsForRepurchaseOfCommonStock for the fiscal year, USD |
| `buyers` | `list` | No | Up to five buyers, largest first |
| `canonicalUrl` | `str` | No | The matching page on xoomar.com |
| `capPct` | `str | None` | No | Maximum return as % of initial level when the note is capped |
| `changePct` | `str | None` | No | Change in short quantity vs the prior report |
| `cik` | `str` | No | SEC CIK, ten digits |
| `company` | `str` | No | Filer name as on the filing |
| `companyName` | `str` | No | Filer name as on EDGAR |
| `costUsd` | `float | None` | No | Cost basis as filed, USD |
| `coupon` | `str | None` | No | Annual coupon %; null on preliminary filings, which are filed before the rate is set |
| `cusip` | `str` | No | CUSIP of the security |
| `data` | `dict` | No |  |
| `date` | `str` | No | The reported date (filing date of the 8-K) or the estimated date |
| `dateOfFirstSale` | `str | None` | No | ISO date; null when the first sale has yet to occur |
| `daysToCover` | `str | None` | No | shortQty / avgDailyVol, FINRA-computed |
| `description` | `str | None` | No | Security description as the SEC publishes it |
| `docUrl` | `str` | No | Link to the filing index on sec.gov |
| `docs` | `str` | No |  |
| `end` | `str` | No | Fiscal year end |
| `entityType` | `str | None` | No | Corporation, Limited Partnership, LLC, Trust and so on |
| `eventDate` | `str | None` | No | Date of the event that requires the filing |
| `eventLabels` | `list | None` | No | Readable labels for each item |
| `exchange` | `str | None` | No | Exchange named for the sale |
| `exemptions` | `str | None` | No | Rule items claimed, e.g. |
| `fairValueUsd` | `float | None` | No | Fair value of crypto assets as filed, USD |
| `filedAt` | `str` | No | SEC acceptance timestamp |
| `firstRegistration` | `str | None` | No | Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing |
| `firstTxDate` | `str` | No | Earliest purchase in the window |
| `form` | `str | None` | No | 10-Q or 10-K the figures come from |
| `formType` | `str` | No | S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT |
| `frame` | `str` | No | Fiscal year frame, e.g. |
| `fundType` | `str | None` | No | Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only |
| `generatedId` | `str | None` | No | USAspending award id; https://www.usaspending.gov/award/{generatedId} |
| `impliedPrice` | `float | None` | No | fairValueUsd divided by units, the filing's own valuation per coin |
| `industryGroup` | `str | None` | No | SEC industry category (Pooled Investment Fund for funds) |
| `insiderName` | `str` | No | Reporting officer, director, or 10% owner |
| `insiderTitle` | `str | None` | No | Role at the company (CEO, CFO, Director...) |
| `insiders` | `float` | No | Distinct insiders who bought on the open market in the window |
| `investorsCount` | `float | None` | No | Investors who have already invested |
| `isAmendment` | `bool` | No | Form D/A |
| `issuer` | `str` | No | Filing entity (BofA Finance, Morgan Stanley Finance...) |
| `issuerCik` | `str | None` | No | Issuer CIK, ten digits |
| `issuerName` | `str` | No | Issuer name as filed |
| `items` | `list | None` | No | 8-K item numbers (2.02, 5.02...) |
| `latestFiledAt` | `str | None` | No | When the latest of those filings reached EDGAR |
| `latestTxDate` | `str` | No | Latest purchase in the window |
| `license` | `str` | No | Data terms |
| `listed` | `bool` | No | Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now |
| `manager` | `str` | No | Manager |
| `market` | `str` | No | nasdaq or cboe |
| `meta` | `dict` | No | Who publishes the data and how to credit it |
| `minimumInvestment` | `float | None` | No | USD minimum accepted from an outside investor |
| `mod` | `str | None` | No | Modification number; 0 or null is the original award |
| `naicsCode` | `str | None` | No | Industry code of the work |
| `name` | `str` | No | Company |
| `netIncome` | `float | None` | No | Net income for the same fiscal year, USD |
| `noteType` | `str | None` | No | autocallable, buffered, barrier, or income. |
| `offeringAmount` | `float | None` | No | Always null; offering amounts are not included |
| `percentOfClass` | `float | None` | No | Percent of the class owned |
| `personName` | `str` | No | Person for whose account the shares are to be sold |
| `personType` | `str | None` | No | Type of reporting person as filed, e.g. |
| `price` | `float | None` | No | Closing price the SEC reports with the row, USD |
| `priceNote` | `str | None` | No | "price not stated in the filing" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); "≈ $61.36, midpoint of the stated range $60.86 to $61.85" when the price is the midpoint of… |
| `pricePerShare` | `str | None` | No | Reported price per share in USD |
| `pricingDate` | `str | None` | No | Pricing/trade date when stated |
| `principalUsd` | `str | None` | No | Aggregate principal when stated (final filings) |
| `quantity` | `float` | No | Shares failed to deliver, as the SEC publishes them |
| `recipientName` | `str` | No | Recipient legal name as registered |
| `relationship` | `str | None` | No | Relationship to the issuer, e.g. |
| `reportingCik` | `str | None` | No | Reporting person's CIK, when filed |
| `reportingPerson` | `str` | No | Reporting person or entity |
| `revenue` | `float | None` | No | Revenue for the same fiscal year, USD |
| `revenueRange` | `str | None` | No | Issuer revenue range or fund net asset value range, as disclosed |
| `securityClass` | `str | None` | No | Title of the class of securities |
| `securityName` | `str | None` | No | Security name as listed |
| `securityTypes` | `str | None` | No | equity, debt, options, pooled fund, other |
| `settlementDate` | `str` | No | Settlement date |
| `shares` | `str | None` | No | Shares bought or sold |
| `sharesOwned` | `float | None` | No | Shares beneficially owned |
| `shortExemptVolume` | `float | None` | No | Short sales marked exempt |
| `shortQty` | `float | None` | No | Total shares held short |
| `shortRatio` | `float | None` | No | shortVolume divided by totalVolume |
| `shortVolume` | `float` | No | Shares sold short that day, as reported to FINRA's facilities |
| `slug` | `str` | No | Fund slug for URLs |
| `source` | `str` | No |  |
| `state` | `str | None` | No | Issuer state or country code |
| `status` | `str` | No | reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives) |
| `symbol` | `str | None` | No | Ticker |
| `ticker` | `str` | No | Listed ticker |
| `totalAmountSold` | `float | None` | No | USD sold as of the filing |
| `totalOfferingAmount` | `float | None` | No | USD; null when indefinite |
| `totalVolume` | `float` | No | Total shares reported to FINRA's facilities that day (not the consolidated tape) |
| `trades` | `float` | No | Open-market purchase transactions in the window |
| `txDate` | `str` | No | Transaction date from the filing, YYYY-MM-DD |
| `underlyings` | `list | None` | No | Parsed underlying symbols (SPX, NDX, NVDA...). |
| `units` | `float | None` | No | Bitcoin held as tagged in the filing; null when the filing gives no usable count |
| `unitsOutstanding` | `float | None` | No | Shares or units of the class outstanding |
| `unitsReliable` | `bool` | No | true when the filing gives a usable coin count |
| `unitsToSell` | `float | None` | No | Shares or units to be sold |
| `updatedAt` | `str` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `url` | `str` | No | Hub page |
| `valueUsd` | `float | None` | No | quantity times price, USD |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list[CompanyEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.Company().list()
for company in results:
    print(company.data_get())
```

#### `load(reqmatch, ctrl=None) -> CompanyEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.Company().load({"slug": "slug"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CompanyEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## CryptoEntity

```python
crypto = client.Crypto()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `asset` | `str` | No | btc or eth |
| `attribution` | `str` | No |  |
| `aumUsd` | `str | None` | No | Holdings valued in USD |
| `baseAsset` | `str` | No | Base asset ticker (BTC, ETH...) |
| `binanceSymbol` | `str | None` | No | Binance symbol |
| `bitmexSymbol` | `str | None` | No | Always null, kept so existing clients parse unchanged |
| `bybitSymbol` | `str | None` | No | Bybit symbol |
| `canonicalUrl` | `str` | No | The matching page on xoomar.com |
| `count` | `float` | No | Events |
| `data` | `dict` | No |  |
| `date` | `str` | No | The as-of date of the issuer file |
| `docs` | `str` | No |  |
| `exchange` | `str` | No | binance, bybit, okx, hyperliquid or kraken |
| `flowUsd` | `str | None` | No | Net flow for the day in USD, derived from the change in the fund's reported holdings |
| `fundingAnnualized` | `float | None` | No | Annualized rate, simple (not compounded), from the rate and its funding interval |
| `fundingIntervalHours` | `float` | No | Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken) |
| `fundingRate` | `str | None` | No | Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval) |
| `fundingRate8h` | `float | None` | No | The rate scaled to eight hours, comparable across venues |
| `holdings` | `str | None` | No | Coins held per the issuer file |
| `hour` | `str` | No | Hour bucket, ISO |
| `hyperliquidCoin` | `str | None` | No | Hyperliquid coin |
| `id` | `float` | No | Event id |
| `issuer` | `str` | No | Issuer name |
| `krakenSymbol` | `str | None` | No | Kraken Futures symbol |
| `license` | `str` | No | Data terms |
| `longShortRatio` | `str | None` | No | Global long/short account ratio where the venue publishes it, else null |
| `longUsd` | `float` | No | Long liquidations in USD |
| `markPrice` | `str | None` | No | Latest mark price in USD |
| `maxSingleUsd` | `float` | No | Largest single event |
| `meta` | `dict` | No | Who publishes the data and how to credit it |
| `nextFundingTime` | `str | None` | No | ISO timestamp of the next funding settlement |
| `okxInstId` | `str | None` | No | OKX instrument id |
| `openInterest` | `str | None` | No | Open interest in contracts |
| `openInterestValue` | `str | None` | No | Open interest notional in USD |
| `price` | `str` | No | Liquidation price |
| `priceChangePct24h` | `str | None` | No | 24h price change as a decimal |
| `qty` | `str` | No | Quantity in coins |
| `rawSymbol` | `str` | No | Contract as the exchange names it |
| `shortUsd` | `float` | No | Short liquidations in USD |
| `side` | `str` | No | long (forced sale) or short (forced buy) |
| `slug` | `str` | No | Symbol slug used in URLs (btc, eth, sol...) |
| `source` | `str` | No |  |
| `symbol` | `str` | No | Contract (only when filtered) |
| `ticker` | `str` | No | Fund ticker (IBIT, ETHA...) |
| `totalUsd` | `float` | No | Total in USD |
| `ts` | `str` | No | Event time, ISO |
| `updatedAt` | `str` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `usdValue` | `str` | No | Notional in USD |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list[CryptoEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.Crypto().list()
for crypto in results:
    print(crypto.data_get())
```

#### `load(reqmatch, ctrl=None) -> CryptoEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.Crypto().load({"coin": "coin"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CryptoEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## MacroEntity

```python
macro = client.Macro()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `actual` | `str | None` | No | Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...) |
| `assetMgrLong` | `float | None` | No | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assetMgrShort` | `float | None` | No | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assets` | `float` | No | Fed total assets, USD (WALCL) |
| `attribution` | `str` | No |  |
| `auctionDate` | `str` | No | Auction date |
| `bidToCover` | `float | None` | No | Tendered divided by accepted |
| `canonicalUrl` | `str` | No | The matching page on xoomar.com |
| `country` | `str` | No | Economy |
| `countryCode` | `str` | No | BIS area code |
| `cusip` | `str` | No | Security CUSIP; a reopening shares the original's CUSIP |
| `data` | `list` | No |  |
| `date` | `str` | No | H.4.1 Wednesday date |
| `dealerAccepted` | `float | None` | No | Accepted by primary dealers, USD |
| `dealerLong` | `float | None` | No | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `dealerShare` | `float | None` | No | Dealer share of accepted, 0 to 1 |
| `dealerShort` | `float | None` | No | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `directAccepted` | `float | None` | No | Accepted from direct bidders, USD |
| `directShare` | `float | None` | No | Direct share of accepted, 0 to 1 |
| `docs` | `str` | No |  |
| `eventName` | `str` | No | CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ... |
| `forecast` | `str | None` | No | Always null: consensus forecasts aren't included |
| `group` | `str` | No | currencies, indices, crypto, metals, energy, bonds, agriculture, other |
| `highRate` | `float | None` | No | High discount rate (bills) or high discount margin (FRNs), percent |
| `highYield` | `float | None` | No | Stop-out yield, percent (notes, bonds, TIPS) |
| `importance` | `str` | No | high, med, or low |
| `indirectAccepted` | `float | None` | No | Accepted from indirect bidders, USD |
| `indirectShare` | `float | None` | No | Indirect share of accepted, 0 to 1 |
| `interestRate` | `float | None` | No | Coupon set at auction, percent |
| `issueDate` | `str | None` | No | Settlement date |
| `lastChanged` | `str | None` | No | Date of the most recent move |
| `levFundLong` | `float | None` | No | Leveraged funds (tff); managed money (disagg) |
| `levFundShort` | `float | None` | No | Leveraged funds (tff); managed money (disagg) |
| `license` | `str` | No | Data terms |
| `m1_m6` | `str | None` | No | 1, 2, 3, 6 month Treasury yields in percent |
| `maturityDate` | `str | None` | No | Maturity |
| `meta` | `dict` | No | Who publishes the data and how to credit it |
| `name` | `str` | No | CFTC contract market name |
| `net` | `float` | No | assets minus tga minus rrp, USD |
| `nonreptLong` | `float | None` | No | Non-reportable (small trader) positions |
| `nonreptShort` | `float | None` | No | Non-reportable (small trader) positions |
| `offeringAmount` | `float | None` | No | Announced size, USD |
| `openInterest` | `float | None` | No | Total open interest in contracts |
| `otherLong` | `float | None` | No | Other reportable positions |
| `otherShort` | `float | None` | No | Other reportable positions |
| `periodLabel` | `str | None` | No | Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05' |
| `previous` | `str | None` | No | Prior period on the same basis as actual |
| `rate` | `str` | No | Policy rate, percent |
| `reopening` | `bool | None` | No | True when the auction adds to an existing issue |
| `reportDate` | `str` | No | CFTC report Tuesday, YYYY-MM-DD |
| `reportType` | `str` | No | tff (financial futures) or disagg (commodities) |
| `reserves` | `float | None` | No | Reserve balances with Federal Reserve Banks, USD (WRESBAL) |
| `rrp` | `float` | No | Overnight reverse repo usage on that date, USD (RRPONTSYD) |
| `scheduledAt` | `str` | No | Release time, UTC |
| `securityTerm` | `str` | No | Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening) |
| `securityType` | `str` | No | Bill, CMB (cash management bill), Note, Bond, TIPS or FRN |
| `slug` | `str` | No | Market slug for URLs (euro-fx, gold...) |
| `sortRank` | `float` | No | Display order within the group |
| `source` | `str` | No | bls, bea, census, fed, dol or treasury (coupon auctions) |
| `tga` | `float` | No | Treasury General Account, USD (WTREGEN) |
| `totalAccepted` | `float | None` | No | Accepted, USD (null until results) |
| `totalTendered` | `float | None` | No | Bids received, USD |
| `unit` | `str | None` | No | What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance' |
| `updatedAt` | `str` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `y1_y30` | `str | None` | No | 1 to 30 year Treasury yields in percent |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list[MacroEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.Macro().list()
for macro in results:
    print(macro.data_get())
```

#### `load(reqmatch, ctrl=None) -> MacroEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.Macro().load({"country": "country"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `MacroEntity` instance with the same options.

#### `get_name() -> str`

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

```python
client = XoomarMarketsSDK({
    "feature": {
        "ratelimit": {"active": True},
        "retry": {"active": True},
        "test": {"active": True},
        "timeout": {"active": True},
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

