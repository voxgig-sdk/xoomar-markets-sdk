# XoomarMarkets Python SDK



The Python SDK for the XoomarMarkets API — an entity-oriented client following Pythonic conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Company()` — each
carrying a small, uniform set of operations (`list`, `load`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to PyPI. Install it from the GitHub
release tag (`py/vX.Y.Z`, see [Tags](https://github.com/voxgig-sdk/xoomar-markets-sdk/tags)) or
from a source checkout:

```bash
pip install -e .
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record. The client sends the API key in the `x-api-key` header.

### 1. Create a client

```python
import os
from xoomarmarkets_sdk import XoomarMarketsSDK

client = XoomarMarketsSDK({
    "apikey": os.environ.get("XOOMAR_MARKETS_APIKEY"),
})
```

### 2. List company records

`list()` returns a `list` of entities, one per record, and raises on
error; an entity's `data_get()` reads its record (a `dict`).

```python
try:
    companys = client.Company().list()
    for company in companys:
        print(company.data_get())
except Exception as err:
    print(f"list failed: {err}")
```

### 3. Load a company

`load()` returns the ENTITY — call data_get() for the record — and raises on error.

```python
try:
    company = client.Company().load({"slug": "example_slug"})
    print(company.data_get())
except Exception as err:
    print(f"load failed: {err}")
```


## Error handling

Entity operations raise on failure, so wrap them in `try` / `except`:

```python
try:
    macros = client.Macro().list()
    print([item.data_get() for item in macros])
except Exception as err:
    print(f"list failed: {err}")
```

`direct()` does **not** raise — it returns the result envelope. Branch
on `ok`; on failure `status` holds the HTTP status (for error responses)
and `err` holds a transport error, so read both defensively:

```python
result = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example_id"},
})

if not result["ok"]:
    print("request failed:", result.get("status"), result.get("err"))
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```python
result = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})

if result["ok"]:
    print(result["status"])  # 200
    print(result["data"])    # response body
else:
    # A non-2xx response carries status + data (the error body); a
    # transport-level failure carries err instead. Only one is present, so
    # read both with .get() rather than indexing a key that may be absent.
    print(result.get("status"), result.get("err"))
```

### Prepare a request without sending it

```python
# prepare() returns the fetch definition and raises on error.
fetchdef = client.prepare({
    "path": "/api/resource/{id}",
    "method": "DELETE",
    "params": {"id": "example"},
})

print(fetchdef["url"])
print(fetchdef["method"])
print(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```python
client = XoomarMarketsSDK.test()

# Entity ops return the entity, and list one per record; they raise on error.
macro = client.Macro().list()
# data_get() on an entity reads its mock response record
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```python
def mock_fetch(url, init):
    return {
        "status": 200,
        "statusText": "OK",
        "headers": {},
        "json": lambda: {"id": "mock01"},
    }, None

client = XoomarMarketsSDK({
    "base": "http://localhost:8080",
    "system": {
        "fetch": mock_fetch,
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
cd py && pytest test/
```


## Reference

### XoomarMarketsSDK

```python
from xoomarmarkets_sdk import XoomarMarketsSDK

client = XoomarMarketsSDK(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `str` | API key for authentication. |
| `base` | `str` | Base URL of the API server. |
| `prefix` | `str` | URL path prefix prepended to all requests. |
| `suffix` | `str` | URL path suffix appended to all requests. |
| `feature` | `dict` | Feature activation flags. |
| `extend` | `list` | Additional Feature instances to load. |
| `system` | `dict` | System overrides (e.g. custom `fetch` function). |

### test

```python
client = XoomarMarketsSDK.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `None`.

### XoomarMarketsSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> dict` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> dict` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> dict` | Build and send an HTTP request. Returns a result dict (branch on `ok`). |
| `Company` | `(data) -> CompanyEntity` | Create a Company entity instance. |
| `Crypto` | `(data) -> CryptoEntity` | Create a Crypto entity instance. |
| `Macro` | `(data) -> MacroEntity` | Create a Macro entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> any` | Load a single entity by match criteria, and return it. Raises on error. |
| `list` | `(reqmatch, ctrl) -> list` | List entities matching the criteria, one per record. Raises on error. |
| `data_get` | `() -> dict` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> dict` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> str` | Return the entity name. |

### Result shape

Entity operations return the entity, and `list` a `list` of entities, one
per record; an entity's `data_get()` reads its record (a `dict`). They raise
on error, so wrap calls in `try`/`except` to handle failures.

The `direct()` escape hatch never raises — it returns a result `dict`
you branch on via `result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `True` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `dict` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `False` and `err` contains the error value.

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

Create an instance: `company = client.Company()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accessionNo` | `str | None` | The filing's accession number for reported rows; null for estimates |
| `actionDate` | `str` | Date the action was signed |
| `actionType` | `str | None` | FPDS action type code |
| `aggregateMarketValue` | `float | None` | Aggregate market value of the shares to be sold, USD |
| `amendmentNo` | `float | None` | Amendment number; null for the original filing |
| `amountUsd` | `float` | Dollars obligated by this action; negative for de-obligations |
| `approxSaleDate` | `str | None` | Approximate date of sale |
| `asOf` | `str | None` | Balance sheet date of the figures |
| `attribution` | `str` |  |
| `avgDailyVol` | `float | None` | Average daily trading volume |
| `awardId` | `str` | Contract or order number (PIID) |
| `awardType` | `str | None` | Definitive contract, delivery order, BPA call, purchase order |
| `awardingAgency` | `str | None` | Awarding department and bureau |
| `awardingSubAgency` | `str | None` | Awarding department and bureau |
| `barrierPct` | `str | None` | Barrier/threshold as % of initial level. |
| `basis` | `str | None` | Reference date for an estimated row; null for reported rows |
| `broker` | `str | None` | Broker named in the notice |
| `buybacks` | `float` | PaymentsForRepurchaseOfCommonStock for the fiscal year, USD |
| `buyers` | `list` | Up to five buyers, largest first |
| `canonicalUrl` | `str` | The matching page on xoomar.com |
| `capPct` | `str | None` | Maximum return as % of initial level when the note is capped |
| `changePct` | `str | None` | Change in short quantity vs the prior report |
| `cik` | `str` | SEC CIK, ten digits |
| `company` | `str` | Filer name as on the filing |
| `companyName` | `str` | Filer name as on EDGAR |
| `costUsd` | `float | None` | Cost basis as filed, USD |
| `coupon` | `str | None` | Annual coupon %; null on preliminary filings, which are filed before the rate is set |
| `cusip` | `str` | CUSIP of the security |
| `data` | `dict` |  |
| `date` | `str` | The reported date (filing date of the 8-K) or the estimated date |
| `dateOfFirstSale` | `str | None` | ISO date; null when the first sale has yet to occur |
| `daysToCover` | `str | None` | shortQty / avgDailyVol, FINRA-computed |
| `description` | `str | None` | Security description as the SEC publishes it |
| `docUrl` | `str` | Link to the filing index on sec.gov |
| `docs` | `str` |  |
| `end` | `str` | Fiscal year end |
| `entityType` | `str | None` | Corporation, Limited Partnership, LLC, Trust and so on |
| `eventDate` | `str | None` | Date of the event that requires the filing |
| `eventLabels` | `list | None` | Readable labels for each item |
| `exchange` | `str | None` | Exchange named for the sale |
| `exemptions` | `str | None` | Rule items claimed, e.g. |
| `fairValueUsd` | `float | None` | Fair value of crypto assets as filed, USD |
| `filedAt` | `str` | SEC acceptance timestamp |
| `firstRegistration` | `str | None` | Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing |
| `firstTxDate` | `str` | Earliest purchase in the window |
| `form` | `str | None` | 10-Q or 10-K the figures come from |
| `formType` | `str` | S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT |
| `frame` | `str` | Fiscal year frame, e.g. |
| `fundType` | `str | None` | Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only |
| `generatedId` | `str | None` | USAspending award id; https://www.usaspending.gov/award/{generatedId} |
| `impliedPrice` | `float | None` | fairValueUsd divided by units, the filing's own valuation per coin |
| `industryGroup` | `str | None` | SEC industry category (Pooled Investment Fund for funds) |
| `insiderName` | `str` | Reporting officer, director, or 10% owner |
| `insiderTitle` | `str | None` | Role at the company (CEO, CFO, Director...) |
| `insiders` | `float` | Distinct insiders who bought on the open market in the window |
| `investorsCount` | `float | None` | Investors who have already invested |
| `isAmendment` | `bool` | Form D/A |
| `issuer` | `str` | Filing entity (BofA Finance, Morgan Stanley Finance...) |
| `issuerCik` | `str | None` | Issuer CIK, ten digits |
| `issuerName` | `str` | Issuer name as filed |
| `items` | `list | None` | 8-K item numbers (2.02, 5.02...) |
| `latestFiledAt` | `str | None` | When the latest of those filings reached EDGAR |
| `latestTxDate` | `str` | Latest purchase in the window |
| `license` | `str` | Data terms |
| `listed` | `bool` | Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now |
| `manager` | `str` | Manager |
| `market` | `str` | nasdaq or cboe |
| `meta` | `dict` | Who publishes the data and how to credit it |
| `minimumInvestment` | `float | None` | USD minimum accepted from an outside investor |
| `mod` | `str | None` | Modification number; 0 or null is the original award |
| `naicsCode` | `str | None` | Industry code of the work |
| `name` | `str` | Company |
| `netIncome` | `float | None` | Net income for the same fiscal year, USD |
| `noteType` | `str | None` | autocallable, buffered, barrier, or income. |
| `offeringAmount` | `float | None` | Always null; offering amounts are not included |
| `percentOfClass` | `float | None` | Percent of the class owned |
| `personName` | `str` | Person for whose account the shares are to be sold |
| `personType` | `str | None` | Type of reporting person as filed, e.g. |
| `price` | `float | None` | Closing price the SEC reports with the row, USD |
| `priceNote` | `str | None` | "price not stated in the filing" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); "≈ $61.36, midpoint of the stated range $60.86 to $61.85" when the price is the midpoint of… |
| `pricePerShare` | `str | None` | Reported price per share in USD |
| `pricingDate` | `str | None` | Pricing/trade date when stated |
| `principalUsd` | `str | None` | Aggregate principal when stated (final filings) |
| `quantity` | `float` | Shares failed to deliver, as the SEC publishes them |
| `recipientName` | `str` | Recipient legal name as registered |
| `relationship` | `str | None` | Relationship to the issuer, e.g. |
| `reportingCik` | `str | None` | Reporting person's CIK, when filed |
| `reportingPerson` | `str` | Reporting person or entity |
| `revenue` | `float | None` | Revenue for the same fiscal year, USD |
| `revenueRange` | `str | None` | Issuer revenue range or fund net asset value range, as disclosed |
| `securityClass` | `str | None` | Title of the class of securities |
| `securityName` | `str | None` | Security name as listed |
| `securityTypes` | `str | None` | equity, debt, options, pooled fund, other |
| `settlementDate` | `str` | Settlement date |
| `shares` | `str | None` | Shares bought or sold |
| `sharesOwned` | `float | None` | Shares beneficially owned |
| `shortExemptVolume` | `float | None` | Short sales marked exempt |
| `shortQty` | `float | None` | Total shares held short |
| `shortRatio` | `float | None` | shortVolume divided by totalVolume |
| `shortVolume` | `float` | Shares sold short that day, as reported to FINRA's facilities |
| `slug` | `str` | Fund slug for URLs |
| `source` | `str` |  |
| `state` | `str | None` | Issuer state or country code |
| `status` | `str` | reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives) |
| `symbol` | `str | None` | Ticker |
| `ticker` | `str` | Listed ticker |
| `totalAmountSold` | `float | None` | USD sold as of the filing |
| `totalOfferingAmount` | `float | None` | USD; null when indefinite |
| `totalVolume` | `float` | Total shares reported to FINRA's facilities that day (not the consolidated tape) |
| `trades` | `float` | Open-market purchase transactions in the window |
| `txDate` | `str` | Transaction date from the filing, YYYY-MM-DD |
| `underlyings` | `list | None` | Parsed underlying symbols (SPX, NDX, NVDA...). |
| `units` | `float | None` | Bitcoin held as tagged in the filing; null when the filing gives no usable count |
| `unitsOutstanding` | `float | None` | Shares or units of the class outstanding |
| `unitsReliable` | `bool` | true when the filing gives a usable coin count |
| `unitsToSell` | `float | None` | Shares or units to be sold |
| `updatedAt` | `str` | When the response was built; a few dated feeds give the date of their newest row instead |
| `url` | `str` | Hub page |
| `valueUsd` | `float | None` | quantity times price, USD |

#### Example: Load

```python
company = client.Company().load({"slug": "slug"})
```

#### Example: List

```python
companys = client.Company().list()
```


### Crypto

Create an instance: `crypto = client.Crypto()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `asset` | `str` | btc or eth |
| `attribution` | `str` |  |
| `aumUsd` | `str | None` | Holdings valued in USD |
| `baseAsset` | `str` | Base asset ticker (BTC, ETH...) |
| `binanceSymbol` | `str | None` | Binance symbol |
| `bitmexSymbol` | `str | None` | Always null, kept so existing clients parse unchanged |
| `bybitSymbol` | `str | None` | Bybit symbol |
| `canonicalUrl` | `str` | The matching page on xoomar.com |
| `count` | `float` | Events |
| `data` | `dict` |  |
| `date` | `str` | The as-of date of the issuer file |
| `docs` | `str` |  |
| `exchange` | `str` | binance, bybit, okx, hyperliquid or kraken |
| `flowUsd` | `str | None` | Net flow for the day in USD, derived from the change in the fund's reported holdings |
| `fundingAnnualized` | `float | None` | Annualized rate, simple (not compounded), from the rate and its funding interval |
| `fundingIntervalHours` | `float` | Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken) |
| `fundingRate` | `str | None` | Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval) |
| `fundingRate8h` | `float | None` | The rate scaled to eight hours, comparable across venues |
| `holdings` | `str | None` | Coins held per the issuer file |
| `hour` | `str` | Hour bucket, ISO |
| `hyperliquidCoin` | `str | None` | Hyperliquid coin |
| `id` | `float` | Event id |
| `issuer` | `str` | Issuer name |
| `krakenSymbol` | `str | None` | Kraken Futures symbol |
| `license` | `str` | Data terms |
| `longShortRatio` | `str | None` | Global long/short account ratio where the venue publishes it, else null |
| `longUsd` | `float` | Long liquidations in USD |
| `markPrice` | `str | None` | Latest mark price in USD |
| `maxSingleUsd` | `float` | Largest single event |
| `meta` | `dict` | Who publishes the data and how to credit it |
| `nextFundingTime` | `str | None` | ISO timestamp of the next funding settlement |
| `okxInstId` | `str | None` | OKX instrument id |
| `openInterest` | `str | None` | Open interest in contracts |
| `openInterestValue` | `str | None` | Open interest notional in USD |
| `price` | `str` | Liquidation price |
| `priceChangePct24h` | `str | None` | 24h price change as a decimal |
| `qty` | `str` | Quantity in coins |
| `rawSymbol` | `str` | Contract as the exchange names it |
| `shortUsd` | `float` | Short liquidations in USD |
| `side` | `str` | long (forced sale) or short (forced buy) |
| `slug` | `str` | Symbol slug used in URLs (btc, eth, sol...) |
| `source` | `str` |  |
| `symbol` | `str` | Contract (only when filtered) |
| `ticker` | `str` | Fund ticker (IBIT, ETHA...) |
| `totalUsd` | `float` | Total in USD |
| `ts` | `str` | Event time, ISO |
| `updatedAt` | `str` | When the response was built; a few dated feeds give the date of their newest row instead |
| `usdValue` | `str` | Notional in USD |

#### Example: Load

```python
crypto = client.Crypto().load({"coin": "coin"})
```

#### Example: List

```python
cryptos = client.Crypto().list()
```


### Macro

Create an instance: `macro = client.Macro()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `actual` | `str | None` | Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...) |
| `assetMgrLong` | `float | None` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assetMgrShort` | `float | None` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assets` | `float` | Fed total assets, USD (WALCL) |
| `attribution` | `str` |  |
| `auctionDate` | `str` | Auction date |
| `bidToCover` | `float | None` | Tendered divided by accepted |
| `canonicalUrl` | `str` | The matching page on xoomar.com |
| `country` | `str` | Economy |
| `countryCode` | `str` | BIS area code |
| `cusip` | `str` | Security CUSIP; a reopening shares the original's CUSIP |
| `data` | `list` |  |
| `date` | `str` | H.4.1 Wednesday date |
| `dealerAccepted` | `float | None` | Accepted by primary dealers, USD |
| `dealerLong` | `float | None` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `dealerShare` | `float | None` | Dealer share of accepted, 0 to 1 |
| `dealerShort` | `float | None` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `directAccepted` | `float | None` | Accepted from direct bidders, USD |
| `directShare` | `float | None` | Direct share of accepted, 0 to 1 |
| `docs` | `str` |  |
| `eventName` | `str` | CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ... |
| `forecast` | `str | None` | Always null: consensus forecasts aren't included |
| `group` | `str` | currencies, indices, crypto, metals, energy, bonds, agriculture, other |
| `highRate` | `float | None` | High discount rate (bills) or high discount margin (FRNs), percent |
| `highYield` | `float | None` | Stop-out yield, percent (notes, bonds, TIPS) |
| `importance` | `str` | high, med, or low |
| `indirectAccepted` | `float | None` | Accepted from indirect bidders, USD |
| `indirectShare` | `float | None` | Indirect share of accepted, 0 to 1 |
| `interestRate` | `float | None` | Coupon set at auction, percent |
| `issueDate` | `str | None` | Settlement date |
| `lastChanged` | `str | None` | Date of the most recent move |
| `levFundLong` | `float | None` | Leveraged funds (tff); managed money (disagg) |
| `levFundShort` | `float | None` | Leveraged funds (tff); managed money (disagg) |
| `license` | `str` | Data terms |
| `m1_m6` | `str | None` | 1, 2, 3, 6 month Treasury yields in percent |
| `maturityDate` | `str | None` | Maturity |
| `meta` | `dict` | Who publishes the data and how to credit it |
| `name` | `str` | CFTC contract market name |
| `net` | `float` | assets minus tga minus rrp, USD |
| `nonreptLong` | `float | None` | Non-reportable (small trader) positions |
| `nonreptShort` | `float | None` | Non-reportable (small trader) positions |
| `offeringAmount` | `float | None` | Announced size, USD |
| `openInterest` | `float | None` | Total open interest in contracts |
| `otherLong` | `float | None` | Other reportable positions |
| `otherShort` | `float | None` | Other reportable positions |
| `periodLabel` | `str | None` | Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05' |
| `previous` | `str | None` | Prior period on the same basis as actual |
| `rate` | `str` | Policy rate, percent |
| `reopening` | `bool | None` | True when the auction adds to an existing issue |
| `reportDate` | `str` | CFTC report Tuesday, YYYY-MM-DD |
| `reportType` | `str` | tff (financial futures) or disagg (commodities) |
| `reserves` | `float | None` | Reserve balances with Federal Reserve Banks, USD (WRESBAL) |
| `rrp` | `float` | Overnight reverse repo usage on that date, USD (RRPONTSYD) |
| `scheduledAt` | `str` | Release time, UTC |
| `securityTerm` | `str` | Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening) |
| `securityType` | `str` | Bill, CMB (cash management bill), Note, Bond, TIPS or FRN |
| `slug` | `str` | Market slug for URLs (euro-fx, gold...) |
| `sortRank` | `float` | Display order within the group |
| `source` | `str` | bls, bea, census, fed, dol or treasury (coupon auctions) |
| `tga` | `float` | Treasury General Account, USD (WTREGEN) |
| `totalAccepted` | `float | None` | Accepted, USD (null until results) |
| `totalTendered` | `float | None` | Bids received, USD |
| `unit` | `str | None` | What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance' |
| `updatedAt` | `str` | When the response was built; a few dated feeds give the date of their newest row instead |
| `y1_y30` | `str | None` | 1 to 30 year Treasury yields in percent |

#### Example: Load

```python
macro = client.Macro().load({"country": "country"})
```

#### Example: List

```python
macros = client.Macro().list()
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

Features are the extension mechanism. A feature is a Python class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **RatelimitFeature**: Rate limiting
- **RetryFeature**: Retry
- **TestFeature**: Test transport
- **TimeoutFeature**: Timeout

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as dicts

The Python SDK uses plain dicts throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `helpers.to_map()` to safely validate that a value is a dict.

### Module structure

```
py/
├── xoomarmarkets_sdk.py         -- Main SDK module
├── config.py                    -- Configuration
├── schema.py                    -- Generated option + entity specs
├── features.py                  -- Feature factory
├── core/                        -- Core types and context
├── entity/                      -- Entity implementations
├── feature/                     -- Built-in features (Base, Test, Log)
├── utility/                     -- Utility functions and struct library
└── test/                        -- Test suites
```

The main module (`xoomarmarkets_sdk`) exports the SDK class.
Import entity or utility modules directly only when needed.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally.

```python
macro = client.Macro()
macro.list()

# macro.data_get() now returns the macro data from the last list
# macro.match_get() returns the last match criteria
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
