# XoomarMarkets PHP SDK Reference

Complete API reference for the XoomarMarkets PHP SDK.


## XoomarMarketsSDK

### Constructor

```php
require_once __DIR__ . '/xoomarmarkets_sdk.php';

$client = new XoomarMarketsSDK($options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$options` | `array` | SDK configuration options. |
| `$options["apikey"]` | `string` | API key for authentication. |
| `$options["base"]` | `string` | Base URL for API requests. |
| `$options["prefix"]` | `string` | URL prefix appended after base. |
| `$options["suffix"]` | `string` | URL suffix appended after path. |
| `$options["headers"]` | `array` | Custom headers for all requests. |
| `$options["feature"]` | `array` | Feature configuration. |
| `$options["system"]` | `array` | System overrides (e.g. custom fetch). |


### Static Methods

#### `XoomarMarketsSDK::test($testopts = null, $sdkopts = null)`

Create a test client with mock features active. Both arguments may be `null`.

```php
$client = XoomarMarketsSDK::test();
```


### Instance Methods

#### `Company($data = null)`

Create a new `CompanyEntity` instance. Pass `null` for no initial data.

#### `Crypto($data = null)`

Create a new `CryptoEntity` instance. Pass `null` for no initial data.

#### `Macro($data = null)`

Create a new `MacroEntity` instance. Pass `null` for no initial data.

#### `options_map(): array`

Return a deep copy of the current SDK options.

#### `get_utility(): XoomarMarketsUtility`

Return a copy of the SDK utility object.

#### `direct(array $fetchargs = []): array`

Make a direct HTTP request to any API endpoint. This is the raw-HTTP escape
hatch: it does **not** throw. It returns a result array
`["ok" => bool, "status" => int, "headers" => array, "data" => mixed]`, or
`["ok" => false, "err" => \Exception]` on failure. Branch on `$result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `$fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `$fetchargs["params"]` | `array` | Path parameter values for `{param}` substitution. |
| `$fetchargs["query"]` | `array` | Query string parameters. |
| `$fetchargs["headers"]` | `array` | Request headers (merged with defaults). |
| `$fetchargs["body"]` | `mixed` | Request body (arrays are JSON-serialized). |
| `$fetchargs["ctrl"]` | `array` | Control options. |

**Returns:** `array` — the result dict (see above); never throws.

#### `prepare(array $fetchargs = []): mixed`

Prepare a fetch definition without sending the request. Returns the
`$fetchdef` array. Throws on error.


---

## CompanyEntity

```php
$company = $client->Company();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accessionNo` | `mixed` | No | The filing's accession number for reported rows; null for estimates |
| `actionDate` | `string` | No | Date the action was signed |
| `actionType` | `mixed` | No | FPDS action type code |
| `aggregateMarketValue` | `mixed` | No | Aggregate market value of the shares to be sold, USD |
| `amendmentNo` | `mixed` | No | Amendment number; null for the original filing |
| `amountUsd` | `float` | No | Dollars obligated by this action; negative for de-obligations |
| `approxSaleDate` | `mixed` | No | Approximate date of sale |
| `asOf` | `mixed` | No | Balance sheet date of the figures |
| `attribution` | `string` | No |  |
| `avgDailyVol` | `mixed` | No | Average daily trading volume |
| `awardId` | `string` | No | Contract or order number (PIID) |
| `awardType` | `mixed` | No | Definitive contract, delivery order, BPA call, purchase order |
| `awardingAgency` | `mixed` | No | Awarding department and bureau |
| `awardingSubAgency` | `mixed` | No | Awarding department and bureau |
| `barrierPct` | `mixed` | No | Barrier/threshold as % of initial level. |
| `basis` | `mixed` | No | Reference date for an estimated row; null for reported rows |
| `broker` | `mixed` | No | Broker named in the notice |
| `buybacks` | `float` | No | PaymentsForRepurchaseOfCommonStock for the fiscal year, USD |
| `buyers` | `array` | No | Up to five buyers, largest first |
| `canonicalUrl` | `string` | No | The matching page on xoomar.com |
| `capPct` | `mixed` | No | Maximum return as % of initial level when the note is capped |
| `changePct` | `mixed` | No | Change in short quantity vs the prior report |
| `cik` | `string` | No | SEC CIK, ten digits |
| `company` | `string` | No | Filer name as on the filing |
| `companyName` | `string` | No | Filer name as on EDGAR |
| `costUsd` | `mixed` | No | Cost basis as filed, USD |
| `coupon` | `mixed` | No | Annual coupon %; null on preliminary filings, which are filed before the rate is set |
| `cusip` | `string` | No | CUSIP of the security |
| `data` | `array` | No |  |
| `date` | `string` | No | The reported date (filing date of the 8-K) or the estimated date |
| `dateOfFirstSale` | `mixed` | No | ISO date; null when the first sale has yet to occur |
| `daysToCover` | `mixed` | No | shortQty / avgDailyVol, FINRA-computed |
| `description` | `mixed` | No | Security description as the SEC publishes it |
| `docUrl` | `string` | No | Link to the filing index on sec.gov |
| `docs` | `string` | No |  |
| `end` | `string` | No | Fiscal year end |
| `entityType` | `mixed` | No | Corporation, Limited Partnership, LLC, Trust and so on |
| `eventDate` | `mixed` | No | Date of the event that requires the filing |
| `eventLabels` | `mixed` | No | Readable labels for each item |
| `exchange` | `mixed` | No | Exchange named for the sale |
| `exemptions` | `mixed` | No | Rule items claimed, e.g. |
| `fairValueUsd` | `mixed` | No | Fair value of crypto assets as filed, USD |
| `filedAt` | `string` | No | SEC acceptance timestamp |
| `firstRegistration` | `mixed` | No | Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing |
| `firstTxDate` | `string` | No | Earliest purchase in the window |
| `form` | `mixed` | No | 10-Q or 10-K the figures come from |
| `formType` | `string` | No | S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT |
| `frame` | `string` | No | Fiscal year frame, e.g. |
| `fundType` | `mixed` | No | Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only |
| `generatedId` | `mixed` | No | USAspending award id; https://www.usaspending.gov/award/{generatedId} |
| `impliedPrice` | `mixed` | No | fairValueUsd divided by units, the filing's own valuation per coin |
| `industryGroup` | `mixed` | No | SEC industry category (Pooled Investment Fund for funds) |
| `insiderName` | `string` | No | Reporting officer, director, or 10% owner |
| `insiderTitle` | `mixed` | No | Role at the company (CEO, CFO, Director...) |
| `insiders` | `float` | No | Distinct insiders who bought on the open market in the window |
| `investorsCount` | `mixed` | No | Investors who have already invested |
| `isAmendment` | `bool` | No | Form D/A |
| `issuer` | `string` | No | Filing entity (BofA Finance, Morgan Stanley Finance...) |
| `issuerCik` | `mixed` | No | Issuer CIK, ten digits |
| `issuerName` | `string` | No | Issuer name as filed |
| `items` | `mixed` | No | 8-K item numbers (2.02, 5.02...) |
| `latestFiledAt` | `mixed` | No | When the latest of those filings reached EDGAR |
| `latestTxDate` | `string` | No | Latest purchase in the window |
| `license` | `string` | No | Data terms |
| `listed` | `bool` | No | Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now |
| `manager` | `string` | No | Manager |
| `market` | `string` | No | nasdaq or cboe |
| `meta` | `array` | No | Who publishes the data and how to credit it |
| `minimumInvestment` | `mixed` | No | USD minimum accepted from an outside investor |
| `mod` | `mixed` | No | Modification number; 0 or null is the original award |
| `naicsCode` | `mixed` | No | Industry code of the work |
| `name` | `string` | No | Company |
| `netIncome` | `mixed` | No | Net income for the same fiscal year, USD |
| `noteType` | `mixed` | No | autocallable, buffered, barrier, or income. |
| `offeringAmount` | `mixed` | No | Always null; offering amounts are not included |
| `percentOfClass` | `mixed` | No | Percent of the class owned |
| `personName` | `string` | No | Person for whose account the shares are to be sold |
| `personType` | `mixed` | No | Type of reporting person as filed, e.g. |
| `price` | `mixed` | No | Closing price the SEC reports with the row, USD |
| `priceNote` | `mixed` | No | "price not stated in the filing" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); "≈ $61.36, midpoint of the stated range $60.86 to $61.85" when the price is the midpoint of… |
| `pricePerShare` | `mixed` | No | Reported price per share in USD |
| `pricingDate` | `mixed` | No | Pricing/trade date when stated |
| `principalUsd` | `mixed` | No | Aggregate principal when stated (final filings) |
| `quantity` | `float` | No | Shares failed to deliver, as the SEC publishes them |
| `recipientName` | `string` | No | Recipient legal name as registered |
| `relationship` | `mixed` | No | Relationship to the issuer, e.g. |
| `reportingCik` | `mixed` | No | Reporting person's CIK, when filed |
| `reportingPerson` | `string` | No | Reporting person or entity |
| `revenue` | `mixed` | No | Revenue for the same fiscal year, USD |
| `revenueRange` | `mixed` | No | Issuer revenue range or fund net asset value range, as disclosed |
| `securityClass` | `mixed` | No | Title of the class of securities |
| `securityName` | `mixed` | No | Security name as listed |
| `securityTypes` | `mixed` | No | equity, debt, options, pooled fund, other |
| `settlementDate` | `string` | No | Settlement date |
| `shares` | `mixed` | No | Shares bought or sold |
| `sharesOwned` | `mixed` | No | Shares beneficially owned |
| `shortExemptVolume` | `mixed` | No | Short sales marked exempt |
| `shortQty` | `mixed` | No | Total shares held short |
| `shortRatio` | `mixed` | No | shortVolume divided by totalVolume |
| `shortVolume` | `float` | No | Shares sold short that day, as reported to FINRA's facilities |
| `slug` | `string` | No | Fund slug for URLs |
| `source` | `string` | No |  |
| `state` | `mixed` | No | Issuer state or country code |
| `status` | `string` | No | reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives) |
| `symbol` | `mixed` | No | Ticker |
| `ticker` | `string` | No | Listed ticker |
| `totalAmountSold` | `mixed` | No | USD sold as of the filing |
| `totalOfferingAmount` | `mixed` | No | USD; null when indefinite |
| `totalVolume` | `float` | No | Total shares reported to FINRA's facilities that day (not the consolidated tape) |
| `trades` | `float` | No | Open-market purchase transactions in the window |
| `txDate` | `string` | No | Transaction date from the filing, YYYY-MM-DD |
| `underlyings` | `mixed` | No | Parsed underlying symbols (SPX, NDX, NVDA...). |
| `units` | `mixed` | No | Bitcoin held as tagged in the filing; null when the filing gives no usable count |
| `unitsOutstanding` | `mixed` | No | Shares or units of the class outstanding |
| `unitsReliable` | `bool` | No | true when the filing gives a usable coin count |
| `unitsToSell` | `mixed` | No | Shares or units to be sold |
| `updatedAt` | `string` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `url` | `string` | No | Hub page |
| `valueUsd` | `mixed` | No | quantity times price, USD |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array of entities, one per record, and throws on error.

```php
$results = $client->Company()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and throws on error.

```php
$result = $client->Company()->load(["slug" => "slug"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): CompanyEntity`

Create a new `CompanyEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## CryptoEntity

```php
$crypto = $client->Crypto();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `asset` | `string` | No | btc or eth |
| `attribution` | `string` | No |  |
| `aumUsd` | `mixed` | No | Holdings valued in USD |
| `baseAsset` | `string` | No | Base asset ticker (BTC, ETH...) |
| `binanceSymbol` | `mixed` | No | Binance symbol |
| `bitmexSymbol` | `mixed` | No | Always null, kept so existing clients parse unchanged |
| `bybitSymbol` | `mixed` | No | Bybit symbol |
| `canonicalUrl` | `string` | No | The matching page on xoomar.com |
| `count` | `float` | No | Events |
| `data` | `array` | No |  |
| `date` | `string` | No | The as-of date of the issuer file |
| `docs` | `string` | No |  |
| `exchange` | `string` | No | binance, bybit, okx, hyperliquid or kraken |
| `flowUsd` | `mixed` | No | Net flow for the day in USD, derived from the change in the fund's reported holdings |
| `fundingAnnualized` | `mixed` | No | Annualized rate, simple (not compounded), from the rate and its funding interval |
| `fundingIntervalHours` | `float` | No | Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken) |
| `fundingRate` | `mixed` | No | Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval) |
| `fundingRate8h` | `mixed` | No | The rate scaled to eight hours, comparable across venues |
| `holdings` | `mixed` | No | Coins held per the issuer file |
| `hour` | `string` | No | Hour bucket, ISO |
| `hyperliquidCoin` | `mixed` | No | Hyperliquid coin |
| `id` | `float` | No | Event id |
| `issuer` | `string` | No | Issuer name |
| `krakenSymbol` | `mixed` | No | Kraken Futures symbol |
| `license` | `string` | No | Data terms |
| `longShortRatio` | `mixed` | No | Global long/short account ratio where the venue publishes it, else null |
| `longUsd` | `float` | No | Long liquidations in USD |
| `markPrice` | `mixed` | No | Latest mark price in USD |
| `maxSingleUsd` | `float` | No | Largest single event |
| `meta` | `array` | No | Who publishes the data and how to credit it |
| `nextFundingTime` | `mixed` | No | ISO timestamp of the next funding settlement |
| `okxInstId` | `mixed` | No | OKX instrument id |
| `openInterest` | `mixed` | No | Open interest in contracts |
| `openInterestValue` | `mixed` | No | Open interest notional in USD |
| `price` | `string` | No | Liquidation price |
| `priceChangePct24h` | `mixed` | No | 24h price change as a decimal |
| `qty` | `string` | No | Quantity in coins |
| `rawSymbol` | `string` | No | Contract as the exchange names it |
| `shortUsd` | `float` | No | Short liquidations in USD |
| `side` | `string` | No | long (forced sale) or short (forced buy) |
| `slug` | `string` | No | Symbol slug used in URLs (btc, eth, sol...) |
| `source` | `string` | No |  |
| `symbol` | `string` | No | Contract (only when filtered) |
| `ticker` | `string` | No | Fund ticker (IBIT, ETHA...) |
| `totalUsd` | `float` | No | Total in USD |
| `ts` | `string` | No | Event time, ISO |
| `updatedAt` | `string` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `usdValue` | `string` | No | Notional in USD |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array of entities, one per record, and throws on error.

```php
$results = $client->Crypto()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and throws on error.

```php
$result = $client->Crypto()->load(["coin" => "coin"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): CryptoEntity`

Create a new `CryptoEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## MacroEntity

```php
$macro = $client->Macro();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `actual` | `mixed` | No | Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...) |
| `assetMgrLong` | `mixed` | No | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assetMgrShort` | `mixed` | No | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assets` | `float` | No | Fed total assets, USD (WALCL) |
| `attribution` | `string` | No |  |
| `auctionDate` | `string` | No | Auction date |
| `bidToCover` | `mixed` | No | Tendered divided by accepted |
| `canonicalUrl` | `string` | No | The matching page on xoomar.com |
| `country` | `string` | No | Economy |
| `countryCode` | `string` | No | BIS area code |
| `cusip` | `string` | No | Security CUSIP; a reopening shares the original's CUSIP |
| `data` | `array` | No |  |
| `date` | `string` | No | H.4.1 Wednesday date |
| `dealerAccepted` | `mixed` | No | Accepted by primary dealers, USD |
| `dealerLong` | `mixed` | No | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `dealerShare` | `mixed` | No | Dealer share of accepted, 0 to 1 |
| `dealerShort` | `mixed` | No | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `directAccepted` | `mixed` | No | Accepted from direct bidders, USD |
| `directShare` | `mixed` | No | Direct share of accepted, 0 to 1 |
| `docs` | `string` | No |  |
| `eventName` | `string` | No | CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ... |
| `forecast` | `mixed` | No | Always null: consensus forecasts aren't included |
| `group` | `string` | No | currencies, indices, crypto, metals, energy, bonds, agriculture, other |
| `highRate` | `mixed` | No | High discount rate (bills) or high discount margin (FRNs), percent |
| `highYield` | `mixed` | No | Stop-out yield, percent (notes, bonds, TIPS) |
| `importance` | `string` | No | high, med, or low |
| `indirectAccepted` | `mixed` | No | Accepted from indirect bidders, USD |
| `indirectShare` | `mixed` | No | Indirect share of accepted, 0 to 1 |
| `interestRate` | `mixed` | No | Coupon set at auction, percent |
| `issueDate` | `mixed` | No | Settlement date |
| `lastChanged` | `mixed` | No | Date of the most recent move |
| `levFundLong` | `mixed` | No | Leveraged funds (tff); managed money (disagg) |
| `levFundShort` | `mixed` | No | Leveraged funds (tff); managed money (disagg) |
| `license` | `string` | No | Data terms |
| `m1_m6` | `mixed` | No | 1, 2, 3, 6 month Treasury yields in percent |
| `maturityDate` | `mixed` | No | Maturity |
| `meta` | `array` | No | Who publishes the data and how to credit it |
| `name` | `string` | No | CFTC contract market name |
| `net` | `float` | No | assets minus tga minus rrp, USD |
| `nonreptLong` | `mixed` | No | Non-reportable (small trader) positions |
| `nonreptShort` | `mixed` | No | Non-reportable (small trader) positions |
| `offeringAmount` | `mixed` | No | Announced size, USD |
| `openInterest` | `mixed` | No | Total open interest in contracts |
| `otherLong` | `mixed` | No | Other reportable positions |
| `otherShort` | `mixed` | No | Other reportable positions |
| `periodLabel` | `mixed` | No | Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05' |
| `previous` | `mixed` | No | Prior period on the same basis as actual |
| `rate` | `string` | No | Policy rate, percent |
| `reopening` | `mixed` | No | True when the auction adds to an existing issue |
| `reportDate` | `string` | No | CFTC report Tuesday, YYYY-MM-DD |
| `reportType` | `string` | No | tff (financial futures) or disagg (commodities) |
| `reserves` | `mixed` | No | Reserve balances with Federal Reserve Banks, USD (WRESBAL) |
| `rrp` | `float` | No | Overnight reverse repo usage on that date, USD (RRPONTSYD) |
| `scheduledAt` | `string` | No | Release time, UTC |
| `securityTerm` | `string` | No | Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening) |
| `securityType` | `string` | No | Bill, CMB (cash management bill), Note, Bond, TIPS or FRN |
| `slug` | `string` | No | Market slug for URLs (euro-fx, gold...) |
| `sortRank` | `float` | No | Display order within the group |
| `source` | `string` | No | bls, bea, census, fed, dol or treasury (coupon auctions) |
| `tga` | `float` | No | Treasury General Account, USD (WTREGEN) |
| `totalAccepted` | `mixed` | No | Accepted, USD (null until results) |
| `totalTendered` | `mixed` | No | Bids received, USD |
| `unit` | `mixed` | No | What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance' |
| `updatedAt` | `string` | No | When the response was built; a few dated feeds give the date of their newest row instead |
| `y1_y30` | `mixed` | No | 1 to 30 year Treasury yields in percent |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array of entities, one per record, and throws on error.

```php
$results = $client->Macro()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and throws on error.

```php
$result = $client->Macro()->load(["country" => "country"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): MacroEntity`

Create a new `MacroEntity` instance with the same client and
options.

#### `get_name(): string`

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

```php
$client = new XoomarMarketsSDK([
  "feature" => [
    "ratelimit" => ["active" => true],
    "retry" => ["active" => true],
    "test" => ["active" => true],
    "timeout" => ["active" => true],
  ],
]);
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

