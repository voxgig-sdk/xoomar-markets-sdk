# XoomarMarkets Lua SDK



The Lua SDK for the XoomarMarkets API — an entity-oriented client using Lua conventions.

It exposes the API as capitalised, semantic **Entities** — e.g. `client:Company()` — each with the same small set of operations (`list`, `load`) instead of raw URL paths and query strings. You call meaning, not endpoints, which keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to LuaRocks. Install it from the
GitHub release tag (`lua/vX.Y.Z`, see [Tags](https://github.com/voxgig-sdk/xoomar-markets-sdk/tags)),
or add the source directory to your `LUA_PATH`:

```bash
export LUA_PATH="path/to/lua/?.lua;path/to/lua/?/init.lua;;"
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record. The client sends the API key in the `x-api-key` header.

### 1. Create a client

```lua
local sdk = require("xoomar-markets_sdk")

local client = sdk.new({
  apikey = os.getenv("XOOMAR_MARKETS_APIKEY"),
})
```

### 2. List company records

Entity operations return `(value, err)`. For `list`, `value` is an
array of entities, one per record — iterate it directly (there is no
wrapper), and read each record with `data_get()`.

```lua
local companys, err = client:Company():list()
if err then error(err) end

for _, item in ipairs(companys) do
  for k, val in pairs(item:data_get()) do print(k, val) end
end
```

### 3. Load a company

`load` returns the entity; `data_get()` reads its record.

```lua
local company, err = client:Company():load({ slug = "example_slug" })
if err then error(err) end
for k, val in pairs(company:data_get()) do print(k, val) end
```


## Error handling

Entity operations return `(value, err)`. Check `err` before using
the value:

```lua
local macros, err = client:Macro():list()
if err then error(err) end
```

`direct` follows the same `(value, err)` convention:

```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example_id" },
})
if err then error(err) end
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
if err then error(err) end

if result["ok"] then
  print(result["status"])  -- 200
  print(result["data"])    -- response body
end
```

### Prepare a request without sending it

```lua
local fetchdef, err = client:prepare({
  path = "/api/resource/{id}",
  method = "DELETE",
  params = { id = "example" },
})
if err then error(err) end

print(fetchdef["url"])
print(fetchdef["method"])
print(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```lua
local client = sdk.test()

local result, err = client:Macro():list()
-- result is an array of entities, one per mock record; err is set on failure
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```lua
local function mock_fetch(url, init)
  return {
    status = 200,
    statusText = "OK",
    headers = {},
    json = function()
      return { id = "mock01" }
    end,
  }, nil
end

local client = sdk.new({
  base = "http://localhost:8080",
  system = {
    fetch = mock_fetch,
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
cd lua && busted test/
```


## Reference

### XoomarMarketsSDK

```lua
local sdk = require("xoomar-markets_sdk")
local client = sdk.new(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `table` | Feature activation flags. |
| `extend` | `table` | Additional Feature instances to load. |
| `system` | `table` | System overrides (e.g. custom `fetch` function). |

### test

```lua
local client = sdk.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### XoomarMarketsSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> table` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> table, err` | Build an HTTP request definition without sending. |
| `direct` | `(fetchargs) -> table, err` | Build and send an HTTP request. |
| `Company` | `(data) -> CompanyEntity` | Create a Company entity instance. |
| `Crypto` | `(data) -> CryptoEntity` | Create a Crypto entity instance. |
| `Macro` | `(data) -> MacroEntity` | Create a Macro entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> any, err` | Load a single entity by match criteria, and return it. |
| `list` | `(reqmatch, ctrl) -> any, err` | List entities matching the criteria, one per record. |
| `data_get` | `() -> table` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> table` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> string` | Return the entity name. |

### Result shape

Entity operations return `(value, err)`. The `value` is the entity
itself — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `load` | the entity, whose `data_get()` reads its record (a `table`) |
| `list` | an array (`table`) of entities, one per record |

Check `err` first (it is non-`nil` on failure), then use `value`:

    local company, err = client:Company():load({ slug = "example" })
    if err then error(err) end
    -- company is the loaded entity

Only `direct()` returns a response envelope — a `table` with `ok`,
`status`, `headers`, and `data` keys.

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

Create an instance: `local company = client:Company(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accessionNo` | `string|nil` | The filing's accession number for reported rows; null for estimates |
| `actionDate` | `string` | Date the action was signed |
| `actionType` | `string|nil` | FPDS action type code |
| `aggregateMarketValue` | `number|nil` | Aggregate market value of the shares to be sold, USD |
| `amendmentNo` | `number|nil` | Amendment number; null for the original filing |
| `amountUsd` | `number` | Dollars obligated by this action; negative for de-obligations |
| `approxSaleDate` | `string|nil` | Approximate date of sale |
| `asOf` | `string|nil` | Balance sheet date of the figures |
| `attribution` | `string` |  |
| `avgDailyVol` | `number|nil` | Average daily trading volume |
| `awardId` | `string` | Contract or order number (PIID) |
| `awardType` | `string|nil` | Definitive contract, delivery order, BPA call, purchase order |
| `awardingAgency` | `string|nil` | Awarding department and bureau |
| `awardingSubAgency` | `string|nil` | Awarding department and bureau |
| `barrierPct` | `string|nil` | Barrier/threshold as % of initial level. |
| `basis` | `string|nil` | Reference date for an estimated row; null for reported rows |
| `broker` | `string|nil` | Broker named in the notice |
| `buybacks` | `number` | PaymentsForRepurchaseOfCommonStock for the fiscal year, USD |
| `buyers` | `table` | Up to five buyers, largest first |
| `canonicalUrl` | `string` | The matching page on xoomar.com |
| `capPct` | `string|nil` | Maximum return as % of initial level when the note is capped |
| `changePct` | `string|nil` | Change in short quantity vs the prior report |
| `cik` | `string` | SEC CIK, ten digits |
| `company` | `string` | Filer name as on the filing |
| `companyName` | `string` | Filer name as on EDGAR |
| `costUsd` | `number|nil` | Cost basis as filed, USD |
| `coupon` | `string|nil` | Annual coupon %; null on preliminary filings, which are filed before the rate is set |
| `cusip` | `string` | CUSIP of the security |
| `data` | `table` |  |
| `date` | `string` | The reported date (filing date of the 8-K) or the estimated date |
| `dateOfFirstSale` | `string|nil` | ISO date; null when the first sale has yet to occur |
| `daysToCover` | `string|nil` | shortQty / avgDailyVol, FINRA-computed |
| `description` | `string|nil` | Security description as the SEC publishes it |
| `docUrl` | `string` | Link to the filing index on sec.gov |
| `docs` | `string` |  |
| `end` | `string` | Fiscal year end |
| `entityType` | `string|nil` | Corporation, Limited Partnership, LLC, Trust and so on |
| `eventDate` | `string|nil` | Date of the event that requires the filing |
| `eventLabels` | `table|nil` | Readable labels for each item |
| `exchange` | `string|nil` | Exchange named for the sale |
| `exemptions` | `string|nil` | Rule items claimed, e.g. |
| `fairValueUsd` | `number|nil` | Fair value of crypto assets as filed, USD |
| `filedAt` | `string` | SEC acceptance timestamp |
| `firstRegistration` | `string|nil` | Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing |
| `firstTxDate` | `string` | Earliest purchase in the window |
| `form` | `string|nil` | 10-Q or 10-K the figures come from |
| `formType` | `string` | S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT |
| `frame` | `string` | Fiscal year frame, e.g. |
| `fundType` | `string|nil` | Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only |
| `generatedId` | `string|nil` | USAspending award id; https://www.usaspending.gov/award/{generatedId} |
| `impliedPrice` | `number|nil` | fairValueUsd divided by units, the filing's own valuation per coin |
| `industryGroup` | `string|nil` | SEC industry category (Pooled Investment Fund for funds) |
| `insiderName` | `string` | Reporting officer, director, or 10% owner |
| `insiderTitle` | `string|nil` | Role at the company (CEO, CFO, Director...) |
| `insiders` | `number` | Distinct insiders who bought on the open market in the window |
| `investorsCount` | `number|nil` | Investors who have already invested |
| `isAmendment` | `boolean` | Form D/A |
| `issuer` | `string` | Filing entity (BofA Finance, Morgan Stanley Finance...) |
| `issuerCik` | `string|nil` | Issuer CIK, ten digits |
| `issuerName` | `string` | Issuer name as filed |
| `items` | `table|nil` | 8-K item numbers (2.02, 5.02...) |
| `latestFiledAt` | `string|nil` | When the latest of those filings reached EDGAR |
| `latestTxDate` | `string` | Latest purchase in the window |
| `license` | `string` | Data terms |
| `listed` | `boolean` | Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now |
| `manager` | `string` | Manager |
| `market` | `string` | nasdaq or cboe |
| `meta` | `table` | Who publishes the data and how to credit it |
| `minimumInvestment` | `number|nil` | USD minimum accepted from an outside investor |
| `mod` | `string|nil` | Modification number; 0 or null is the original award |
| `naicsCode` | `string|nil` | Industry code of the work |
| `name` | `string` | Company |
| `netIncome` | `number|nil` | Net income for the same fiscal year, USD |
| `noteType` | `string|nil` | autocallable, buffered, barrier, or income. |
| `offeringAmount` | `number|nil` | Always null; offering amounts are not included |
| `percentOfClass` | `number|nil` | Percent of the class owned |
| `personName` | `string` | Person for whose account the shares are to be sold |
| `personType` | `string|nil` | Type of reporting person as filed, e.g. |
| `price` | `number|nil` | Closing price the SEC reports with the row, USD |
| `priceNote` | `string|nil` | "price not stated in the filing" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); "≈ $61.36, midpoint of the stated range $60.86 to $61.85" when the price is the midpoint of… |
| `pricePerShare` | `string|nil` | Reported price per share in USD |
| `pricingDate` | `string|nil` | Pricing/trade date when stated |
| `principalUsd` | `string|nil` | Aggregate principal when stated (final filings) |
| `quantity` | `number` | Shares failed to deliver, as the SEC publishes them |
| `recipientName` | `string` | Recipient legal name as registered |
| `relationship` | `string|nil` | Relationship to the issuer, e.g. |
| `reportingCik` | `string|nil` | Reporting person's CIK, when filed |
| `reportingPerson` | `string` | Reporting person or entity |
| `revenue` | `number|nil` | Revenue for the same fiscal year, USD |
| `revenueRange` | `string|nil` | Issuer revenue range or fund net asset value range, as disclosed |
| `securityClass` | `string|nil` | Title of the class of securities |
| `securityName` | `string|nil` | Security name as listed |
| `securityTypes` | `string|nil` | equity, debt, options, pooled fund, other |
| `settlementDate` | `string` | Settlement date |
| `shares` | `string|nil` | Shares bought or sold |
| `sharesOwned` | `number|nil` | Shares beneficially owned |
| `shortExemptVolume` | `number|nil` | Short sales marked exempt |
| `shortQty` | `number|nil` | Total shares held short |
| `shortRatio` | `number|nil` | shortVolume divided by totalVolume |
| `shortVolume` | `number` | Shares sold short that day, as reported to FINRA's facilities |
| `slug` | `string` | Fund slug for URLs |
| `source` | `string` |  |
| `state` | `string|nil` | Issuer state or country code |
| `status` | `string` | reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives) |
| `symbol` | `string|nil` | Ticker |
| `ticker` | `string` | Listed ticker |
| `totalAmountSold` | `number|nil` | USD sold as of the filing |
| `totalOfferingAmount` | `number|nil` | USD; null when indefinite |
| `totalVolume` | `number` | Total shares reported to FINRA's facilities that day (not the consolidated tape) |
| `trades` | `number` | Open-market purchase transactions in the window |
| `txDate` | `string` | Transaction date from the filing, YYYY-MM-DD |
| `underlyings` | `table|nil` | Parsed underlying symbols (SPX, NDX, NVDA...). |
| `units` | `number|nil` | Bitcoin held as tagged in the filing; null when the filing gives no usable count |
| `unitsOutstanding` | `number|nil` | Shares or units of the class outstanding |
| `unitsReliable` | `boolean` | true when the filing gives a usable coin count |
| `unitsToSell` | `number|nil` | Shares or units to be sold |
| `updatedAt` | `string` | When the response was built; a few dated feeds give the date of their newest row instead |
| `url` | `string` | Hub page |
| `valueUsd` | `number|nil` | quantity times price, USD |

#### Example: Load

```lua
local company, err = client:Company():load({ slug = "slug" })
```

#### Example: List

```lua
local companys, err = client:Company():list()
```


### Crypto

Create an instance: `local crypto = client:Crypto(nil)`

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
| `aumUsd` | `string|nil` | Holdings valued in USD |
| `baseAsset` | `string` | Base asset ticker (BTC, ETH...) |
| `binanceSymbol` | `string|nil` | Binance symbol |
| `bitmexSymbol` | `string|nil` | Always null, kept so existing clients parse unchanged |
| `bybitSymbol` | `string|nil` | Bybit symbol |
| `canonicalUrl` | `string` | The matching page on xoomar.com |
| `count` | `number` | Events |
| `data` | `table` |  |
| `date` | `string` | The as-of date of the issuer file |
| `docs` | `string` |  |
| `exchange` | `string` | binance, bybit, okx, hyperliquid or kraken |
| `flowUsd` | `string|nil` | Net flow for the day in USD, derived from the change in the fund's reported holdings |
| `fundingAnnualized` | `number|nil` | Annualized rate, simple (not compounded), from the rate and its funding interval |
| `fundingIntervalHours` | `number` | Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken) |
| `fundingRate` | `string|nil` | Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval) |
| `fundingRate8h` | `number|nil` | The rate scaled to eight hours, comparable across venues |
| `holdings` | `string|nil` | Coins held per the issuer file |
| `hour` | `string` | Hour bucket, ISO |
| `hyperliquidCoin` | `string|nil` | Hyperliquid coin |
| `id` | `number` | Event id |
| `issuer` | `string` | Issuer name |
| `krakenSymbol` | `string|nil` | Kraken Futures symbol |
| `license` | `string` | Data terms |
| `longShortRatio` | `string|nil` | Global long/short account ratio where the venue publishes it, else null |
| `longUsd` | `number` | Long liquidations in USD |
| `markPrice` | `string|nil` | Latest mark price in USD |
| `maxSingleUsd` | `number` | Largest single event |
| `meta` | `table` | Who publishes the data and how to credit it |
| `nextFundingTime` | `string|nil` | ISO timestamp of the next funding settlement |
| `okxInstId` | `string|nil` | OKX instrument id |
| `openInterest` | `string|nil` | Open interest in contracts |
| `openInterestValue` | `string|nil` | Open interest notional in USD |
| `price` | `string` | Liquidation price |
| `priceChangePct24h` | `string|nil` | 24h price change as a decimal |
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

```lua
local crypto, err = client:Crypto():load({ coin = "coin" })
```

#### Example: List

```lua
local cryptos, err = client:Crypto():list()
```


### Macro

Create an instance: `local macro = client:Macro(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `actual` | `string|nil` | Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...) |
| `assetMgrLong` | `number|nil` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assetMgrShort` | `number|nil` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assets` | `number` | Fed total assets, USD (WALCL) |
| `attribution` | `string` |  |
| `auctionDate` | `string` | Auction date |
| `bidToCover` | `number|nil` | Tendered divided by accepted |
| `canonicalUrl` | `string` | The matching page on xoomar.com |
| `country` | `string` | Economy |
| `countryCode` | `string` | BIS area code |
| `cusip` | `string` | Security CUSIP; a reopening shares the original's CUSIP |
| `data` | `table` |  |
| `date` | `string` | H.4.1 Wednesday date |
| `dealerAccepted` | `number|nil` | Accepted by primary dealers, USD |
| `dealerLong` | `number|nil` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `dealerShare` | `number|nil` | Dealer share of accepted, 0 to 1 |
| `dealerShort` | `number|nil` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `directAccepted` | `number|nil` | Accepted from direct bidders, USD |
| `directShare` | `number|nil` | Direct share of accepted, 0 to 1 |
| `docs` | `string` |  |
| `eventName` | `string` | CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ... |
| `forecast` | `string|nil` | Always null: consensus forecasts aren't included |
| `group` | `string` | currencies, indices, crypto, metals, energy, bonds, agriculture, other |
| `highRate` | `number|nil` | High discount rate (bills) or high discount margin (FRNs), percent |
| `highYield` | `number|nil` | Stop-out yield, percent (notes, bonds, TIPS) |
| `importance` | `string` | high, med, or low |
| `indirectAccepted` | `number|nil` | Accepted from indirect bidders, USD |
| `indirectShare` | `number|nil` | Indirect share of accepted, 0 to 1 |
| `interestRate` | `number|nil` | Coupon set at auction, percent |
| `issueDate` | `string|nil` | Settlement date |
| `lastChanged` | `string|nil` | Date of the most recent move |
| `levFundLong` | `number|nil` | Leveraged funds (tff); managed money (disagg) |
| `levFundShort` | `number|nil` | Leveraged funds (tff); managed money (disagg) |
| `license` | `string` | Data terms |
| `m1_m6` | `string|nil` | 1, 2, 3, 6 month Treasury yields in percent |
| `maturityDate` | `string|nil` | Maturity |
| `meta` | `table` | Who publishes the data and how to credit it |
| `name` | `string` | CFTC contract market name |
| `net` | `number` | assets minus tga minus rrp, USD |
| `nonreptLong` | `number|nil` | Non-reportable (small trader) positions |
| `nonreptShort` | `number|nil` | Non-reportable (small trader) positions |
| `offeringAmount` | `number|nil` | Announced size, USD |
| `openInterest` | `number|nil` | Total open interest in contracts |
| `otherLong` | `number|nil` | Other reportable positions |
| `otherShort` | `number|nil` | Other reportable positions |
| `periodLabel` | `string|nil` | Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05' |
| `previous` | `string|nil` | Prior period on the same basis as actual |
| `rate` | `string` | Policy rate, percent |
| `reopening` | `boolean|nil` | True when the auction adds to an existing issue |
| `reportDate` | `string` | CFTC report Tuesday, YYYY-MM-DD |
| `reportType` | `string` | tff (financial futures) or disagg (commodities) |
| `reserves` | `number|nil` | Reserve balances with Federal Reserve Banks, USD (WRESBAL) |
| `rrp` | `number` | Overnight reverse repo usage on that date, USD (RRPONTSYD) |
| `scheduledAt` | `string` | Release time, UTC |
| `securityTerm` | `string` | Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening) |
| `securityType` | `string` | Bill, CMB (cash management bill), Note, Bond, TIPS or FRN |
| `slug` | `string` | Market slug for URLs (euro-fx, gold...) |
| `sortRank` | `number` | Display order within the group |
| `source` | `string` | bls, bea, census, fed, dol or treasury (coupon auctions) |
| `tga` | `number` | Treasury General Account, USD (WTREGEN) |
| `totalAccepted` | `number|nil` | Accepted, USD (null until results) |
| `totalTendered` | `number|nil` | Bids received, USD |
| `unit` | `string|nil` | What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance' |
| `updatedAt` | `string` | When the response was built; a few dated feeds give the date of their newest row instead |
| `y1_y30` | `string|nil` | 1 to 30 year Treasury yields in percent |

#### Example: Load

```lua
local macro, err = client:Macro():load({ country = "country" })
```

#### Example: List

```lua
local macros, err = client:Macro():list()
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

Features are the extension mechanism. A feature is a Lua table
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **RatelimitFeature**: Rate limiting
- **RetryFeature**: Retry
- **TestFeature**: Test transport
- **TimeoutFeature**: Timeout

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as tables

The Lua SDK uses plain Lua tables throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `helpers.to_map()` to safely validate that a value is a table.

### Module structure

```
lua/
├── xoomar-markets_sdk.lua    -- Main SDK module
├── config.lua               -- Configuration
├── schema.lua               -- Generated option + entity specs
├── features.lua             -- Feature factory
├── core/                    -- Core types and context
├── entity/                  -- Entity implementations
├── feature/                 -- Built-in features (Base, Test, Log)
├── utility/                 -- Utility functions and struct library
└── test/                    -- Test suites
```

The main module (`xoomar-markets_sdk`) exports the SDK constructor
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally.

```lua
local macro = client:Macro()
macro:list()

-- macro:data_get() now returns the macro data from the last list
-- macro:match_get() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
