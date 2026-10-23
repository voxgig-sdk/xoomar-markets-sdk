# XoomarMarkets Ruby SDK



The Ruby SDK for the XoomarMarkets API — an entity-oriented client using idiomatic Ruby conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Company` — with named operations (`list`/`load`) instead of raw URL paths and query strings. Working with resources and verbs keeps call sites self-describing and reduces cognitive load.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to RubyGems. Install it from the
GitHub release tag (`rb/vX.Y.Z`, see [Tags](https://github.com/voxgig-sdk/xoomar-markets-sdk/tags)), or
from a clone:

```bash
git clone https://github.com/voxgig-sdk/xoomar-markets-sdk
```

Then add it to your `Gemfile` by path, and run `bundle install`:

```ruby
gem "voxgig-sdk-xoomar-markets-sdk", path: "./xoomar-markets-sdk/rb"
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record. The client sends the API key in the `x-api-key` header.

### 1. Create a client

```ruby
require_relative "XoomarMarkets_sdk"

client = XoomarMarketsSDK.new({
  "apikey" => ENV["XOOMAR_MARKETS_APIKEY"],
})
```

### 2. List company records

```ruby
begin
  # list returns an Array of Company entities, one per record; data_get reads the record.
  companys = client.Company.list
  companys.each do |item|
    record = item.data_get
    puts "#{record["accessionNo"]}"
  end
rescue => err
  warn "list failed: #{err}"
end
```

### 3. Load a company

```ruby
begin
  # load returns the ENTITY — call data_get for the Company record (raises on error).
  company = client.Company.load({ "slug" => "example_slug" })
  puts company.data_get
rescue => err
  warn "load failed: #{err}"
end
```


## Error handling

Entity operations raise on failure, so rescue them:

```ruby
begin
  macros = client.Macro.list()
rescue => err
  warn "list failed: #{err}"
end
```

`direct` does **not** raise — it returns the result hash. Branch on
`ok`; on failure `status` holds the HTTP status (for error responses) and
`err` holds a transport error, so read both defensively:

```ruby
result = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example_id" },
})

warn "request failed: #{result["err"] || "HTTP #{result["status"]}"}" unless result["ok"]
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ruby
result = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})

if result["ok"]
  puts result["status"]  # 200
  puts result["data"]    # response body
else
  # On an HTTP error status there is no err (only a transport failure sets
  # it), so fall back to the status code.
  warn(result["err"] || "HTTP #{result["status"]}")
end
```

### Prepare a request without sending it

```ruby
begin
  fetchdef = client.prepare({
    "path" => "/api/resource/{id}",
    "method" => "DELETE",
    "params" => { "id" => "example" },
  })
  puts fetchdef["url"]
  puts fetchdef["method"]
  puts fetchdef["headers"]
rescue => err
  warn "prepare failed: #{err}"
end
```

### Use test mode

Create a mock client for unit testing — no server required:

```ruby
client = XoomarMarketsSDK.test

# list returns an Array of Macro entities, one per mock record (raises on
# error); data_get reads each record.
macros = client.Macro.list()
macros.each { |item| puts item.data_get }
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```ruby
mock_fetch = ->(url, init) {
  return {
    "status" => 200,
    "statusText" => "OK",
    "headers" => {},
    "json" => ->() { { "id" => "mock01" } },
  }, nil
}

client = XoomarMarketsSDK.new({
  "base" => "http://localhost:8080",
  "system" => {
    "fetch" => mock_fetch,
  },
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
cd rb && ruby -Itest -e "Dir['test/*_test.rb'].each { |f| require_relative f }"
```


## Reference

### XoomarMarketsSDK

```ruby
require_relative "XoomarMarkets_sdk"
client = XoomarMarketsSDK.new(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `Hash` | Feature activation flags. |
| `extend` | `Hash` | Additional Feature instances to load. |
| `system` | `Hash` | System overrides (e.g. custom `fetch` lambda). |

### test

```ruby
client = XoomarMarketsSDK.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### XoomarMarketsSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> Hash` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Hash` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> Hash` | Build and send an HTTP request. Returns a result hash (`result["ok"]`); does not raise. |
| `Company` | `(data) -> CompanyEntity` | Create a Company entity instance. |
| `Crypto` | `(data) -> CryptoEntity` | Create a Crypto entity instance. |
| `Macro` | `(data) -> MacroEntity` | Create a Macro entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> any` | Load a single entity by match criteria, and return it. Raises on error. |
| `list` | `(reqmatch = nil, ctrl) -> Array` | List entities matching the criteria (call with no argument to list all), one per record. Raises on error. |
| `data_get` | `() -> Hash` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> Hash` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return the entity, and `list` an `Array` of entities, one
per record; an entity's `data_get` reads its record. On failure they raise a
`XoomarMarketsError` (a `StandardError` subclass), so wrap calls in
`begin`/`rescue` where you need to handle errors.

The `direct` escape hatch is the exception: it never raises and instead
returns a result `Hash` with these keys:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Boolean` | `true` if the HTTP status is 2xx. |
| `status` | `Integer` | HTTP status code. |
| `headers` | `Hash` | Response headers. |
| `data` | `any` | Parsed JSON response body. |
| `err` | `Error` | Present when `ok` is `false`. |

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

Operations: List, Load.

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

Operations: List, Load.

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

Operations: List, Load.

API path: `/api/markets/calendar`



## Entities


### Company

Create an instance: `company = client.Company`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accessionNo` | `Object` | The filing's accession number for reported rows; null for estimates |
| `actionDate` | `String` | Date the action was signed |
| `actionType` | `Object` | FPDS action type code |
| `aggregateMarketValue` | `Object` | Aggregate market value of the shares to be sold, USD |
| `amendmentNo` | `Object` | Amendment number; null for the original filing |
| `amountUsd` | `Float` | Dollars obligated by this action; negative for de-obligations |
| `approxSaleDate` | `Object` | Approximate date of sale |
| `asOf` | `Object` | Balance sheet date of the figures |
| `attribution` | `String` |  |
| `avgDailyVol` | `Object` | Average daily trading volume |
| `awardId` | `String` | Contract or order number (PIID) |
| `awardType` | `Object` | Definitive contract, delivery order, BPA call, purchase order |
| `awardingAgency` | `Object` | Awarding department and bureau |
| `awardingSubAgency` | `Object` | Awarding department and bureau |
| `barrierPct` | `Object` | Barrier/threshold as % of initial level. |
| `basis` | `Object` | Reference date for an estimated row; null for reported rows |
| `broker` | `Object` | Broker named in the notice |
| `buybacks` | `Float` | PaymentsForRepurchaseOfCommonStock for the fiscal year, USD |
| `buyers` | `Array` | Up to five buyers, largest first |
| `canonicalUrl` | `String` | The matching page on xoomar.com |
| `capPct` | `Object` | Maximum return as % of initial level when the note is capped |
| `changePct` | `Object` | Change in short quantity vs the prior report |
| `cik` | `String` | SEC CIK, ten digits |
| `company` | `String` | Filer name as on the filing |
| `companyName` | `String` | Filer name as on EDGAR |
| `costUsd` | `Object` | Cost basis as filed, USD |
| `coupon` | `Object` | Annual coupon %; null on preliminary filings, which are filed before the rate is set |
| `cusip` | `String` | CUSIP of the security |
| `data` | `Hash` |  |
| `date` | `String` | The reported date (filing date of the 8-K) or the estimated date |
| `dateOfFirstSale` | `Object` | ISO date; null when the first sale has yet to occur |
| `daysToCover` | `Object` | shortQty / avgDailyVol, FINRA-computed |
| `description` | `Object` | Security description as the SEC publishes it |
| `docUrl` | `String` | Link to the filing index on sec.gov |
| `docs` | `String` |  |
| `end` | `String` | Fiscal year end |
| `entityType` | `Object` | Corporation, Limited Partnership, LLC, Trust and so on |
| `eventDate` | `Object` | Date of the event that requires the filing |
| `eventLabels` | `Object` | Readable labels for each item |
| `exchange` | `Object` | Exchange named for the sale |
| `exemptions` | `Object` | Rule items claimed, e.g. |
| `fairValueUsd` | `Object` | Fair value of crypto assets as filed, USD |
| `filedAt` | `String` | SEC acceptance timestamp |
| `firstRegistration` | `Object` | Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing |
| `firstTxDate` | `String` | Earliest purchase in the window |
| `form` | `Object` | 10-Q or 10-K the figures come from |
| `formType` | `String` | S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT |
| `frame` | `String` | Fiscal year frame, e.g. |
| `fundType` | `Object` | Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only |
| `generatedId` | `Object` | USAspending award id; https://www.usaspending.gov/award/{generatedId} |
| `impliedPrice` | `Object` | fairValueUsd divided by units, the filing's own valuation per coin |
| `industryGroup` | `Object` | SEC industry category (Pooled Investment Fund for funds) |
| `insiderName` | `String` | Reporting officer, director, or 10% owner |
| `insiderTitle` | `Object` | Role at the company (CEO, CFO, Director...) |
| `insiders` | `Float` | Distinct insiders who bought on the open market in the window |
| `investorsCount` | `Object` | Investors who have already invested |
| `isAmendment` | `Boolean` | Form D/A |
| `issuer` | `String` | Filing entity (BofA Finance, Morgan Stanley Finance...) |
| `issuerCik` | `Object` | Issuer CIK, ten digits |
| `issuerName` | `String` | Issuer name as filed |
| `items` | `Object` | 8-K item numbers (2.02, 5.02...) |
| `latestFiledAt` | `Object` | When the latest of those filings reached EDGAR |
| `latestTxDate` | `String` | Latest purchase in the window |
| `license` | `String` | Data terms |
| `listed` | `Boolean` | Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now |
| `manager` | `String` | Manager |
| `market` | `String` | nasdaq or cboe |
| `meta` | `Hash` | Who publishes the data and how to credit it |
| `minimumInvestment` | `Object` | USD minimum accepted from an outside investor |
| `mod` | `Object` | Modification number; 0 or null is the original award |
| `naicsCode` | `Object` | Industry code of the work |
| `name` | `String` | Company |
| `netIncome` | `Object` | Net income for the same fiscal year, USD |
| `noteType` | `Object` | autocallable, buffered, barrier, or income. |
| `offeringAmount` | `Object` | Always null; offering amounts are not included |
| `percentOfClass` | `Object` | Percent of the class owned |
| `personName` | `String` | Person for whose account the shares are to be sold |
| `personType` | `Object` | Type of reporting person as filed, e.g. |
| `price` | `Object` | Closing price the SEC reports with the row, USD |
| `priceNote` | `Object` | "price not stated in the filing" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); "≈ $61.36, midpoint of the stated range $60.86 to $61.85" when the price is the midpoint of… |
| `pricePerShare` | `Object` | Reported price per share in USD |
| `pricingDate` | `Object` | Pricing/trade date when stated |
| `principalUsd` | `Object` | Aggregate principal when stated (final filings) |
| `quantity` | `Float` | Shares failed to deliver, as the SEC publishes them |
| `recipientName` | `String` | Recipient legal name as registered |
| `relationship` | `Object` | Relationship to the issuer, e.g. |
| `reportingCik` | `Object` | Reporting person's CIK, when filed |
| `reportingPerson` | `String` | Reporting person or entity |
| `revenue` | `Object` | Revenue for the same fiscal year, USD |
| `revenueRange` | `Object` | Issuer revenue range or fund net asset value range, as disclosed |
| `securityClass` | `Object` | Title of the class of securities |
| `securityName` | `Object` | Security name as listed |
| `securityTypes` | `Object` | equity, debt, options, pooled fund, other |
| `settlementDate` | `String` | Settlement date |
| `shares` | `Object` | Shares bought or sold |
| `sharesOwned` | `Object` | Shares beneficially owned |
| `shortExemptVolume` | `Object` | Short sales marked exempt |
| `shortQty` | `Object` | Total shares held short |
| `shortRatio` | `Object` | shortVolume divided by totalVolume |
| `shortVolume` | `Float` | Shares sold short that day, as reported to FINRA's facilities |
| `slug` | `String` | Fund slug for URLs |
| `source` | `String` |  |
| `state` | `Object` | Issuer state or country code |
| `status` | `String` | reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives) |
| `symbol` | `Object` | Ticker |
| `ticker` | `String` | Listed ticker |
| `totalAmountSold` | `Object` | USD sold as of the filing |
| `totalOfferingAmount` | `Object` | USD; null when indefinite |
| `totalVolume` | `Float` | Total shares reported to FINRA's facilities that day (not the consolidated tape) |
| `trades` | `Float` | Open-market purchase transactions in the window |
| `txDate` | `String` | Transaction date from the filing, YYYY-MM-DD |
| `underlyings` | `Object` | Parsed underlying symbols (SPX, NDX, NVDA...). |
| `units` | `Object` | Bitcoin held as tagged in the filing; null when the filing gives no usable count |
| `unitsOutstanding` | `Object` | Shares or units of the class outstanding |
| `unitsReliable` | `Boolean` | true when the filing gives a usable coin count |
| `unitsToSell` | `Object` | Shares or units to be sold |
| `updatedAt` | `String` | When the response was built; a few dated feeds give the date of their newest row instead |
| `url` | `String` | Hub page |
| `valueUsd` | `Object` | quantity times price, USD |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Company record (raises on error).
company = client.Company.load({ "slug" => "slug" })
```

#### Example: List

```ruby
# list returns an Array of Company entities, one per record (raises on error).
companys = client.Company.list
companys.each { |item| puts item.data_get }
```


### Crypto

Create an instance: `crypto = client.Crypto`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `asset` | `String` | btc or eth |
| `attribution` | `String` |  |
| `aumUsd` | `Object` | Holdings valued in USD |
| `baseAsset` | `String` | Base asset ticker (BTC, ETH...) |
| `binanceSymbol` | `Object` | Binance symbol |
| `bitmexSymbol` | `Object` | Always null, kept so existing clients parse unchanged |
| `bybitSymbol` | `Object` | Bybit symbol |
| `canonicalUrl` | `String` | The matching page on xoomar.com |
| `count` | `Float` | Events |
| `data` | `Hash` |  |
| `date` | `String` | The as-of date of the issuer file |
| `docs` | `String` |  |
| `exchange` | `String` | binance, bybit, okx, hyperliquid or kraken |
| `flowUsd` | `Object` | Net flow for the day in USD, derived from the change in the fund's reported holdings |
| `fundingAnnualized` | `Object` | Annualized rate, simple (not compounded), from the rate and its funding interval |
| `fundingIntervalHours` | `Float` | Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken) |
| `fundingRate` | `Object` | Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval) |
| `fundingRate8h` | `Object` | The rate scaled to eight hours, comparable across venues |
| `holdings` | `Object` | Coins held per the issuer file |
| `hour` | `String` | Hour bucket, ISO |
| `hyperliquidCoin` | `Object` | Hyperliquid coin |
| `id` | `Float` | Event id |
| `issuer` | `String` | Issuer name |
| `krakenSymbol` | `Object` | Kraken Futures symbol |
| `license` | `String` | Data terms |
| `longShortRatio` | `Object` | Global long/short account ratio where the venue publishes it, else null |
| `longUsd` | `Float` | Long liquidations in USD |
| `markPrice` | `Object` | Latest mark price in USD |
| `maxSingleUsd` | `Float` | Largest single event |
| `meta` | `Hash` | Who publishes the data and how to credit it |
| `nextFundingTime` | `Object` | ISO timestamp of the next funding settlement |
| `okxInstId` | `Object` | OKX instrument id |
| `openInterest` | `Object` | Open interest in contracts |
| `openInterestValue` | `Object` | Open interest notional in USD |
| `price` | `String` | Liquidation price |
| `priceChangePct24h` | `Object` | 24h price change as a decimal |
| `qty` | `String` | Quantity in coins |
| `rawSymbol` | `String` | Contract as the exchange names it |
| `shortUsd` | `Float` | Short liquidations in USD |
| `side` | `String` | long (forced sale) or short (forced buy) |
| `slug` | `String` | Symbol slug used in URLs (btc, eth, sol...) |
| `source` | `String` |  |
| `symbol` | `String` | Contract (only when filtered) |
| `ticker` | `String` | Fund ticker (IBIT, ETHA...) |
| `totalUsd` | `Float` | Total in USD |
| `ts` | `String` | Event time, ISO |
| `updatedAt` | `String` | When the response was built; a few dated feeds give the date of their newest row instead |
| `usdValue` | `String` | Notional in USD |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Crypto record (raises on error).
crypto = client.Crypto.load({ "coin" => "coin" })
```

#### Example: List

```ruby
# list returns an Array of Crypto entities, one per record (raises on error).
cryptos = client.Crypto.list
cryptos.each { |item| puts item.data_get }
```


### Macro

Create an instance: `macro = client.Macro`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `actual` | `Object` | Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...) |
| `assetMgrLong` | `Object` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assetMgrShort` | `Object` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assets` | `Float` | Fed total assets, USD (WALCL) |
| `attribution` | `String` |  |
| `auctionDate` | `String` | Auction date |
| `bidToCover` | `Object` | Tendered divided by accepted |
| `canonicalUrl` | `String` | The matching page on xoomar.com |
| `country` | `String` | Economy |
| `countryCode` | `String` | BIS area code |
| `cusip` | `String` | Security CUSIP; a reopening shares the original's CUSIP |
| `data` | `Array` |  |
| `date` | `String` | H.4.1 Wednesday date |
| `dealerAccepted` | `Object` | Accepted by primary dealers, USD |
| `dealerLong` | `Object` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `dealerShare` | `Object` | Dealer share of accepted, 0 to 1 |
| `dealerShort` | `Object` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `directAccepted` | `Object` | Accepted from direct bidders, USD |
| `directShare` | `Object` | Direct share of accepted, 0 to 1 |
| `docs` | `String` |  |
| `eventName` | `String` | CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ... |
| `forecast` | `Object` | Always null: consensus forecasts aren't included |
| `group` | `String` | currencies, indices, crypto, metals, energy, bonds, agriculture, other |
| `highRate` | `Object` | High discount rate (bills) or high discount margin (FRNs), percent |
| `highYield` | `Object` | Stop-out yield, percent (notes, bonds, TIPS) |
| `importance` | `String` | high, med, or low |
| `indirectAccepted` | `Object` | Accepted from indirect bidders, USD |
| `indirectShare` | `Object` | Indirect share of accepted, 0 to 1 |
| `interestRate` | `Object` | Coupon set at auction, percent |
| `issueDate` | `Object` | Settlement date |
| `lastChanged` | `Object` | Date of the most recent move |
| `levFundLong` | `Object` | Leveraged funds (tff); managed money (disagg) |
| `levFundShort` | `Object` | Leveraged funds (tff); managed money (disagg) |
| `license` | `String` | Data terms |
| `m1_m6` | `Object` | 1, 2, 3, 6 month Treasury yields in percent |
| `maturityDate` | `Object` | Maturity |
| `meta` | `Hash` | Who publishes the data and how to credit it |
| `name` | `String` | CFTC contract market name |
| `net` | `Float` | assets minus tga minus rrp, USD |
| `nonreptLong` | `Object` | Non-reportable (small trader) positions |
| `nonreptShort` | `Object` | Non-reportable (small trader) positions |
| `offeringAmount` | `Object` | Announced size, USD |
| `openInterest` | `Object` | Total open interest in contracts |
| `otherLong` | `Object` | Other reportable positions |
| `otherShort` | `Object` | Other reportable positions |
| `periodLabel` | `Object` | Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05' |
| `previous` | `Object` | Prior period on the same basis as actual |
| `rate` | `String` | Policy rate, percent |
| `reopening` | `Object` | True when the auction adds to an existing issue |
| `reportDate` | `String` | CFTC report Tuesday, YYYY-MM-DD |
| `reportType` | `String` | tff (financial futures) or disagg (commodities) |
| `reserves` | `Object` | Reserve balances with Federal Reserve Banks, USD (WRESBAL) |
| `rrp` | `Float` | Overnight reverse repo usage on that date, USD (RRPONTSYD) |
| `scheduledAt` | `String` | Release time, UTC |
| `securityTerm` | `String` | Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening) |
| `securityType` | `String` | Bill, CMB (cash management bill), Note, Bond, TIPS or FRN |
| `slug` | `String` | Market slug for URLs (euro-fx, gold...) |
| `sortRank` | `Float` | Display order within the group |
| `source` | `String` | bls, bea, census, fed, dol or treasury (coupon auctions) |
| `tga` | `Float` | Treasury General Account, USD (WTREGEN) |
| `totalAccepted` | `Object` | Accepted, USD (null until results) |
| `totalTendered` | `Object` | Bids received, USD |
| `unit` | `Object` | What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance' |
| `updatedAt` | `String` | When the response was built; a few dated feeds give the date of their newest row instead |
| `y1_y30` | `Object` | 1 to 30 year Treasury yields in percent |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Macro record (raises on error).
macro = client.Macro.load({ "country" => "country" })
```

#### Example: List

```ruby
# list returns an Array of Macro entities, one per record (raises on error).
macros = client.Macro.list
macros.each { |item| puts item.data_get }
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

Features are the extension mechanism. A feature is a Ruby class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **RatelimitFeature**: Rate limiting
- **RetryFeature**: Retry
- **TestFeature**: Test transport
- **TimeoutFeature**: Timeout

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as hashes

The Ruby SDK uses plain Ruby hashes throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `Helpers.to_map()` to safely validate that a value is a hash.

### Module structure

```
rb/
├── XoomarMarkets_sdk.rb       -- Main SDK module
├── config.rb                  -- Configuration
├── schema.rb                  -- Generated option + entity specs
├── features.rb                -- Feature factory
├── core/                      -- Core types and context
├── entity/                    -- Entity implementations
├── feature/                   -- Built-in features (Base, Test, Log)
├── utility/                   -- Utility functions and struct library
└── test/                      -- Test suites
```

The main module (`XoomarMarkets_sdk`) exports the SDK class
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally.

```ruby
macro = client.Macro
macro.list()

# macro.data_get now returns the macro data from the last list
# macro.match_get returns the last match criteria
```

Call `make` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
