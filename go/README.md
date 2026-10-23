# XoomarMarkets Golang SDK



The Golang SDK for the XoomarMarkets API — an entity-oriented client using standard Go conventions. No generics required; data flows as `map[string]any`.

It exposes the API as capitalised, semantic **Entities** — e.g. `client.Company(nil)` — each with the same small set of operations (`List`, `Load`) instead of raw URL paths and query strings. You call meaning, not endpoints, which keeps the cognitive load low.

> Also generated from this model: `go-cli`, `go-mcp`, `lua`, `php`, `py`, `rb`, `ts` — see
> the [top-level README](../README.md).


## Install
```bash
go get github.com/voxgig-sdk/xoomar-markets-sdk/go@latest
```

The Go module proxy resolves the version from the `go/vX.Y.Z` GitHub
release tag — see [Tags](https://github.com/voxgig-sdk/xoomar-markets-sdk/tags) for the available versions.

To vendor from a local checkout instead, clone this repo alongside your
project and add a `replace` directive pointing at the checked-out
`go/` directory:

```bash
go mod edit -replace github.com/voxgig-sdk/xoomar-markets-sdk/go=../xoomar-markets-sdk/go
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record. The client sends the API key in the `x-api-key` header.

### Quickstart

A complete program: create a client, then call the entity operations.
Each operation returns `(value, error)` — the value is the entity, and for
`List` a `[]any` of entities, one per record (there is no `{ok, data}`
wrapper), so check `err` and read a record through the entity's
`Data()`.

```go
package main

import (
    "fmt"
    "os"
    sdk "github.com/voxgig-sdk/xoomar-markets-sdk/go"
)

func main() {
    client := sdk.NewXoomarMarketsSDK(map[string]any{
        "apikey": os.Getenv("XOOMAR_MARKETS_APIKEY"),
    })

    // List company records — the value is a []any of entities, one per record.
    companys, err := client.Company(nil).List(nil, nil)
    if err != nil {
        panic(err)
    }
    for _, item := range companys.([]any) {
        fmt.Println(item.(sdk.Entity).Data())
    }

    // Load a single company — the value is the entity; Data() reads its record.
    company, err := client.Company(nil).Load(map[string]any{"slug": "example_slug"}, nil)
    if err != nil {
        panic(err)
    }
    fmt.Println(company.(sdk.Entity).Data())
}
```


## Error handling

Every entity operation returns `(value, error)`. Check `err` before
using the value — there is no exception to catch:

```go
macros, err := client.Macro(nil).List(nil, nil)
if err != nil {
    // handle err
    return
}
_ = macros
```

`Direct` follows the same `(value, error)` convention:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example_id"},
})
if err != nil {
    // handle err
}
_ = result
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

if result["ok"] == true {
    fmt.Println(result["status"]) // 200
    fmt.Println(result["data"])   // response body
}
```

### Prepare a request without sending it

```go
fetchdef, err := client.Prepare(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "DELETE",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

fmt.Println(fetchdef["url"])
fmt.Println(fetchdef["method"])
fmt.Println(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```go
client := sdk.Test()

macros, err := client.Macro(nil).List(
    nil, nil,
)
if err != nil {
    panic(err)
}
// A []any of entities, one per mock record.
for _, item := range macros.([]any) {
    fmt.Println(item.(sdk.Entity).Data())
}
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```go
mockFetch := func(url string, init map[string]any) (map[string]any, error) {
    return map[string]any{
        "status":     200,
        "statusText": "OK",
        "headers":    map[string]any{},
        "json": (func() any)(func() any {
            return map[string]any{"id": "mock01"}
        }),
    }, nil
}

client := sdk.NewXoomarMarketsSDK(map[string]any{
    "base": "http://localhost:8080",
    "system": map[string]any{
        "fetch": (func(string, map[string]any) (map[string]any, error))(mockFetch),
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
cd go && go test ./test/...
```


## Reference

### NewXoomarMarketsSDK

```go
func NewXoomarMarketsSDK(options map[string]any) *XoomarMarketsSDK
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `"apikey"` | `string` | API key for authentication. |
| `"base"` | `string` | Base URL of the API server. |
| `"prefix"` | `string` | URL path prefix prepended to all requests. |
| `"suffix"` | `string` | URL path suffix appended to all requests. |
| `"feature"` | `map[string]any` | Feature activation flags. |
| `"extend"` | `[]any` | Additional Feature instances to load. |
| `"system"` | `map[string]any` | System overrides (e.g. custom `"fetch"` function). |

### TestSDK

```go
func TestSDK(testopts map[string]any, sdkopts map[string]any) *XoomarMarketsSDK
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### XoomarMarketsSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `OptionsMap` | `() map[string]any` | Deep copy of current SDK options. |
| `GetUtility` | `() *Utility` | Copy of the SDK utility object. |
| `Prepare` | `(fetchargs map[string]any) (map[string]any, error)` | Build an HTTP request definition without sending. |
| `Direct` | `(fetchargs map[string]any) (map[string]any, error)` | Build and send an HTTP request. |
| `Company` | `(data map[string]any) XoomarMarketsEntity` | Create a Company entity instance. |
| `Crypto` | `(data map[string]any) XoomarMarketsEntity` | Create a Crypto entity instance. |
| `Macro` | `(data map[string]any) XoomarMarketsEntity` | Create a Macro entity instance. |

### Entity interface (XoomarMarketsEntity)

All entities implement the `XoomarMarketsEntity` interface.

| Method | Signature | Description |
| --- | --- | --- |
| `Load` | `(reqmatch, ctrl map[string]any) (any, error)` | Load a single entity by match criteria, and return it. |
| `List` | `(reqmatch, ctrl map[string]any) (any, error)` | List entities matching the criteria, one per record. |
| `Data` | `(args ...any) any` | Get or set entity data. |
| `Match` | `(args ...any) any` | Get or set entity match criteria. |
| `Make` | `() Entity` | Create a new instance with the same options. |
| `GetName` | `() string` | Return the entity name. |

### Result shape

Entity operations return `(value, error)`. The `value` is the entity
itself — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `Load` | the entity, whose `Data()` reads its record (`map[string]any`) |
| `List` | a `[]any` of entities, one per record |

Check `err` first, then use the value directly (or the typed
`...Typed` variants, which return the entity's model struct and a typed
slice):

    company, err := client.Company(nil).List(nil, nil)
    if err != nil { /* handle */ }
    // company is a []any of entities, one per record

Only `Direct()` returns a response envelope — a `map[string]any` with
`"ok"`, `"status"`, `"headers"`, and `"data"` keys.

### Entities

#### Company

| Field | Description |
| --- | --- |
| `"accessionNo"` | The filing's accession number for reported rows; null for estimates |
| `"actionDate"` | Date the action was signed |
| `"actionType"` | FPDS action type code |
| `"aggregateMarketValue"` | Aggregate market value of the shares to be sold, USD |
| `"amendmentNo"` | Amendment number; null for the original filing |
| `"amountUsd"` | Dollars obligated by this action; negative for de-obligations |
| `"approxSaleDate"` | Approximate date of sale |
| `"asOf"` | Balance sheet date of the figures |
| `"attribution"` |  |
| `"avgDailyVol"` | Average daily trading volume |
| `"awardId"` | Contract or order number (PIID) |
| `"awardType"` | Definitive contract, delivery order, BPA call, purchase order |
| `"awardingAgency"` | Awarding department and bureau |
| `"awardingSubAgency"` | Awarding department and bureau |
| `"barrierPct"` | Barrier/threshold as % of initial level. |
| `"basis"` | Reference date for an estimated row; null for reported rows |
| `"broker"` | Broker named in the notice |
| `"buybacks"` | PaymentsForRepurchaseOfCommonStock for the fiscal year, USD |
| `"buyers"` | Up to five buyers, largest first |
| `"canonicalUrl"` | The matching page on xoomar.com |
| `"capPct"` | Maximum return as % of initial level when the note is capped |
| `"changePct"` | Change in short quantity vs the prior report |
| `"cik"` | SEC CIK, ten digits |
| `"company"` | Filer name as on the filing |
| `"companyName"` | Filer name as on EDGAR |
| `"costUsd"` | Cost basis as filed, USD |
| `"coupon"` | Annual coupon %; null on preliminary filings, which are filed before the rate is set |
| `"cusip"` | CUSIP of the security |
| `"data"` |  |
| `"date"` | The reported date (filing date of the 8-K) or the estimated date |
| `"dateOfFirstSale"` | ISO date; null when the first sale has yet to occur |
| `"daysToCover"` | shortQty / avgDailyVol, FINRA-computed |
| `"description"` | Security description as the SEC publishes it |
| `"docUrl"` | Link to the filing index on sec.gov |
| `"docs"` |  |
| `"end"` | Fiscal year end |
| `"entityType"` | Corporation, Limited Partnership, LLC, Trust and so on |
| `"eventDate"` | Date of the event that requires the filing |
| `"eventLabels"` | Readable labels for each item |
| `"exchange"` | Exchange named for the sale |
| `"exemptions"` | Rule items claimed, e.g. |
| `"fairValueUsd"` | Fair value of crypto assets as filed, USD |
| `"filedAt"` | SEC acceptance timestamp |
| `"firstRegistration"` | Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing |
| `"firstTxDate"` | Earliest purchase in the window |
| `"form"` | 10-Q or 10-K the figures come from |
| `"formType"` | S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT |
| `"frame"` | Fiscal year frame, e.g. |
| `"fundType"` | Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only |
| `"generatedId"` | USAspending award id; https://www.usaspending.gov/award/{generatedId} |
| `"impliedPrice"` | fairValueUsd divided by units, the filing's own valuation per coin |
| `"industryGroup"` | SEC industry category (Pooled Investment Fund for funds) |
| `"insiderName"` | Reporting officer, director, or 10% owner |
| `"insiderTitle"` | Role at the company (CEO, CFO, Director...) |
| `"insiders"` | Distinct insiders who bought on the open market in the window |
| `"investorsCount"` | Investors who have already invested |
| `"isAmendment"` | Form D/A |
| `"issuer"` | Filing entity (BofA Finance, Morgan Stanley Finance...) |
| `"issuerCik"` | Issuer CIK, ten digits |
| `"issuerName"` | Issuer name as filed |
| `"items"` | 8-K item numbers (2.02, 5.02...) |
| `"latestFiledAt"` | When the latest of those filings reached EDGAR |
| `"latestTxDate"` | Latest purchase in the window |
| `"license"` | Data terms |
| `"listed"` | Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now |
| `"manager"` | Manager |
| `"market"` | nasdaq or cboe |
| `"meta"` | Who publishes the data and how to credit it |
| `"minimumInvestment"` | USD minimum accepted from an outside investor |
| `"mod"` | Modification number; 0 or null is the original award |
| `"naicsCode"` | Industry code of the work |
| `"name"` | Company |
| `"netIncome"` | Net income for the same fiscal year, USD |
| `"noteType"` | autocallable, buffered, barrier, or income. |
| `"offeringAmount"` | Always null; offering amounts are not included |
| `"percentOfClass"` | Percent of the class owned |
| `"personName"` | Person for whose account the shares are to be sold |
| `"personType"` | Type of reporting person as filed, e.g. |
| `"price"` | Closing price the SEC reports with the row, USD |
| `"priceNote"` | "price not stated in the filing" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); "≈ $61.36, midpoint of the stated range $60.86 to $61.85" when the price is the midpoint of… |
| `"pricePerShare"` | Reported price per share in USD |
| `"pricingDate"` | Pricing/trade date when stated |
| `"principalUsd"` | Aggregate principal when stated (final filings) |
| `"quantity"` | Shares failed to deliver, as the SEC publishes them |
| `"recipientName"` | Recipient legal name as registered |
| `"relationship"` | Relationship to the issuer, e.g. |
| `"reportingCik"` | Reporting person's CIK, when filed |
| `"reportingPerson"` | Reporting person or entity |
| `"revenue"` | Revenue for the same fiscal year, USD |
| `"revenueRange"` | Issuer revenue range or fund net asset value range, as disclosed |
| `"securityClass"` | Title of the class of securities |
| `"securityName"` | Security name as listed |
| `"securityTypes"` | equity, debt, options, pooled fund, other |
| `"settlementDate"` | Settlement date |
| `"shares"` | Shares bought or sold |
| `"sharesOwned"` | Shares beneficially owned |
| `"shortExemptVolume"` | Short sales marked exempt |
| `"shortQty"` | Total shares held short |
| `"shortRatio"` | shortVolume divided by totalVolume |
| `"shortVolume"` | Shares sold short that day, as reported to FINRA's facilities |
| `"slug"` | Fund slug for URLs |
| `"source"` |  |
| `"state"` | Issuer state or country code |
| `"status"` | reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives) |
| `"symbol"` | Ticker |
| `"ticker"` | Listed ticker |
| `"totalAmountSold"` | USD sold as of the filing |
| `"totalOfferingAmount"` | USD; null when indefinite |
| `"totalVolume"` | Total shares reported to FINRA's facilities that day (not the consolidated tape) |
| `"trades"` | Open-market purchase transactions in the window |
| `"txDate"` | Transaction date from the filing, YYYY-MM-DD |
| `"underlyings"` | Parsed underlying symbols (SPX, NDX, NVDA...). |
| `"units"` | Bitcoin held as tagged in the filing; null when the filing gives no usable count |
| `"unitsOutstanding"` | Shares or units of the class outstanding |
| `"unitsReliable"` | true when the filing gives a usable coin count |
| `"unitsToSell"` | Shares or units to be sold |
| `"updatedAt"` | When the response was built; a few dated feeds give the date of their newest row instead |
| `"url"` | Hub page |
| `"valueUsd"` | quantity times price, USD |

Operations: List, Load.

API path: `/api/markets/bitcoin-treasuries`

#### Crypto

| Field | Description |
| --- | --- |
| `"asset"` | btc or eth |
| `"attribution"` |  |
| `"aumUsd"` | Holdings valued in USD |
| `"baseAsset"` | Base asset ticker (BTC, ETH...) |
| `"binanceSymbol"` | Binance symbol |
| `"bitmexSymbol"` | Always null, kept so existing clients parse unchanged |
| `"bybitSymbol"` | Bybit symbol |
| `"canonicalUrl"` | The matching page on xoomar.com |
| `"count"` | Events |
| `"data"` |  |
| `"date"` | The as-of date of the issuer file |
| `"docs"` |  |
| `"exchange"` | binance, bybit, okx, hyperliquid or kraken |
| `"flowUsd"` | Net flow for the day in USD, derived from the change in the fund's reported holdings |
| `"fundingAnnualized"` | Annualized rate, simple (not compounded), from the rate and its funding interval |
| `"fundingIntervalHours"` | Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken) |
| `"fundingRate"` | Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval) |
| `"fundingRate8h"` | The rate scaled to eight hours, comparable across venues |
| `"holdings"` | Coins held per the issuer file |
| `"hour"` | Hour bucket, ISO |
| `"hyperliquidCoin"` | Hyperliquid coin |
| `"id"` | Event id |
| `"issuer"` | Issuer name |
| `"krakenSymbol"` | Kraken Futures symbol |
| `"license"` | Data terms |
| `"longShortRatio"` | Global long/short account ratio where the venue publishes it, else null |
| `"longUsd"` | Long liquidations in USD |
| `"markPrice"` | Latest mark price in USD |
| `"maxSingleUsd"` | Largest single event |
| `"meta"` | Who publishes the data and how to credit it |
| `"nextFundingTime"` | ISO timestamp of the next funding settlement |
| `"okxInstId"` | OKX instrument id |
| `"openInterest"` | Open interest in contracts |
| `"openInterestValue"` | Open interest notional in USD |
| `"price"` | Liquidation price |
| `"priceChangePct24h"` | 24h price change as a decimal |
| `"qty"` | Quantity in coins |
| `"rawSymbol"` | Contract as the exchange names it |
| `"shortUsd"` | Short liquidations in USD |
| `"side"` | long (forced sale) or short (forced buy) |
| `"slug"` | Symbol slug used in URLs (btc, eth, sol...) |
| `"source"` |  |
| `"symbol"` | Contract (only when filtered) |
| `"ticker"` | Fund ticker (IBIT, ETHA...) |
| `"totalUsd"` | Total in USD |
| `"ts"` | Event time, ISO |
| `"updatedAt"` | When the response was built; a few dated feeds give the date of their newest row instead |
| `"usdValue"` | Notional in USD |

Operations: List, Load.

API path: `/api/markets/etf-flows`

#### Macro

| Field | Description |
| --- | --- |
| `"actual"` | Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...) |
| `"assetMgrLong"` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `"assetMgrShort"` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `"assets"` | Fed total assets, USD (WALCL) |
| `"attribution"` |  |
| `"auctionDate"` | Auction date |
| `"bidToCover"` | Tendered divided by accepted |
| `"canonicalUrl"` | The matching page on xoomar.com |
| `"country"` | Economy |
| `"countryCode"` | BIS area code |
| `"cusip"` | Security CUSIP; a reopening shares the original's CUSIP |
| `"data"` |  |
| `"date"` | H.4.1 Wednesday date |
| `"dealerAccepted"` | Accepted by primary dealers, USD |
| `"dealerLong"` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `"dealerShare"` | Dealer share of accepted, 0 to 1 |
| `"dealerShort"` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `"directAccepted"` | Accepted from direct bidders, USD |
| `"directShare"` | Direct share of accepted, 0 to 1 |
| `"docs"` |  |
| `"eventName"` | CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ... |
| `"forecast"` | Always null: consensus forecasts aren't included |
| `"group"` | currencies, indices, crypto, metals, energy, bonds, agriculture, other |
| `"highRate"` | High discount rate (bills) or high discount margin (FRNs), percent |
| `"highYield"` | Stop-out yield, percent (notes, bonds, TIPS) |
| `"importance"` | high, med, or low |
| `"indirectAccepted"` | Accepted from indirect bidders, USD |
| `"indirectShare"` | Indirect share of accepted, 0 to 1 |
| `"interestRate"` | Coupon set at auction, percent |
| `"issueDate"` | Settlement date |
| `"lastChanged"` | Date of the most recent move |
| `"levFundLong"` | Leveraged funds (tff); managed money (disagg) |
| `"levFundShort"` | Leveraged funds (tff); managed money (disagg) |
| `"license"` | Data terms |
| `"m1_m6"` | 1, 2, 3, 6 month Treasury yields in percent |
| `"maturityDate"` | Maturity |
| `"meta"` | Who publishes the data and how to credit it |
| `"name"` | CFTC contract market name |
| `"net"` | assets minus tga minus rrp, USD |
| `"nonreptLong"` | Non-reportable (small trader) positions |
| `"nonreptShort"` | Non-reportable (small trader) positions |
| `"offeringAmount"` | Announced size, USD |
| `"openInterest"` | Total open interest in contracts |
| `"otherLong"` | Other reportable positions |
| `"otherShort"` | Other reportable positions |
| `"periodLabel"` | Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05' |
| `"previous"` | Prior period on the same basis as actual |
| `"rate"` | Policy rate, percent |
| `"reopening"` | True when the auction adds to an existing issue |
| `"reportDate"` | CFTC report Tuesday, YYYY-MM-DD |
| `"reportType"` | tff (financial futures) or disagg (commodities) |
| `"reserves"` | Reserve balances with Federal Reserve Banks, USD (WRESBAL) |
| `"rrp"` | Overnight reverse repo usage on that date, USD (RRPONTSYD) |
| `"scheduledAt"` | Release time, UTC |
| `"securityTerm"` | Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening) |
| `"securityType"` | Bill, CMB (cash management bill), Note, Bond, TIPS or FRN |
| `"slug"` | Market slug for URLs (euro-fx, gold...) |
| `"sortRank"` | Display order within the group |
| `"source"` | bls, bea, census, fed, dol or treasury (coupon auctions) |
| `"tga"` | Treasury General Account, USD (WTREGEN) |
| `"totalAccepted"` | Accepted, USD (null until results) |
| `"totalTendered"` | Bids received, USD |
| `"unit"` | What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance' |
| `"updatedAt"` | When the response was built; a few dated feeds give the date of their newest row instead |
| `"y1_y30"` | 1 to 30 year Treasury yields in percent |

Operations: List, Load.

API path: `/api/markets/calendar`



## Entities


### Company

Create an instance: `company := client.Company(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accessionNo` | `any` | The filing's accession number for reported rows; null for estimates |
| `actionDate` | `string` | Date the action was signed |
| `actionType` | `any` | FPDS action type code |
| `aggregateMarketValue` | `any` | Aggregate market value of the shares to be sold, USD |
| `amendmentNo` | `any` | Amendment number; null for the original filing |
| `amountUsd` | `float64` | Dollars obligated by this action; negative for de-obligations |
| `approxSaleDate` | `any` | Approximate date of sale |
| `asOf` | `any` | Balance sheet date of the figures |
| `attribution` | `string` |  |
| `avgDailyVol` | `any` | Average daily trading volume |
| `awardId` | `string` | Contract or order number (PIID) |
| `awardType` | `any` | Definitive contract, delivery order, BPA call, purchase order |
| `awardingAgency` | `any` | Awarding department and bureau |
| `awardingSubAgency` | `any` | Awarding department and bureau |
| `barrierPct` | `any` | Barrier/threshold as % of initial level. |
| `basis` | `any` | Reference date for an estimated row; null for reported rows |
| `broker` | `any` | Broker named in the notice |
| `buybacks` | `float64` | PaymentsForRepurchaseOfCommonStock for the fiscal year, USD |
| `buyers` | `[]any` | Up to five buyers, largest first |
| `canonicalUrl` | `string` | The matching page on xoomar.com |
| `capPct` | `any` | Maximum return as % of initial level when the note is capped |
| `changePct` | `any` | Change in short quantity vs the prior report |
| `cik` | `string` | SEC CIK, ten digits |
| `company` | `string` | Filer name as on the filing |
| `companyName` | `string` | Filer name as on EDGAR |
| `costUsd` | `any` | Cost basis as filed, USD |
| `coupon` | `any` | Annual coupon %; null on preliminary filings, which are filed before the rate is set |
| `cusip` | `string` | CUSIP of the security |
| `data` | `map[string]any` |  |
| `date` | `string` | The reported date (filing date of the 8-K) or the estimated date |
| `dateOfFirstSale` | `any` | ISO date; null when the first sale has yet to occur |
| `daysToCover` | `any` | shortQty / avgDailyVol, FINRA-computed |
| `description` | `any` | Security description as the SEC publishes it |
| `docUrl` | `string` | Link to the filing index on sec.gov |
| `docs` | `string` |  |
| `end` | `string` | Fiscal year end |
| `entityType` | `any` | Corporation, Limited Partnership, LLC, Trust and so on |
| `eventDate` | `any` | Date of the event that requires the filing |
| `eventLabels` | `any` | Readable labels for each item |
| `exchange` | `any` | Exchange named for the sale |
| `exemptions` | `any` | Rule items claimed, e.g. |
| `fairValueUsd` | `any` | Fair value of crypto assets as filed, USD |
| `filedAt` | `string` | SEC acceptance timestamp |
| `firstRegistration` | `any` | Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing |
| `firstTxDate` | `string` | Earliest purchase in the window |
| `form` | `any` | 10-Q or 10-K the figures come from |
| `formType` | `string` | S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT |
| `frame` | `string` | Fiscal year frame, e.g. |
| `fundType` | `any` | Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only |
| `generatedId` | `any` | USAspending award id; https://www.usaspending.gov/award/{generatedId} |
| `impliedPrice` | `any` | fairValueUsd divided by units, the filing's own valuation per coin |
| `industryGroup` | `any` | SEC industry category (Pooled Investment Fund for funds) |
| `insiderName` | `string` | Reporting officer, director, or 10% owner |
| `insiderTitle` | `any` | Role at the company (CEO, CFO, Director...) |
| `insiders` | `float64` | Distinct insiders who bought on the open market in the window |
| `investorsCount` | `any` | Investors who have already invested |
| `isAmendment` | `bool` | Form D/A |
| `issuer` | `string` | Filing entity (BofA Finance, Morgan Stanley Finance...) |
| `issuerCik` | `any` | Issuer CIK, ten digits |
| `issuerName` | `string` | Issuer name as filed |
| `items` | `any` | 8-K item numbers (2.02, 5.02...) |
| `latestFiledAt` | `any` | When the latest of those filings reached EDGAR |
| `latestTxDate` | `string` | Latest purchase in the window |
| `license` | `string` | Data terms |
| `listed` | `bool` | Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now |
| `manager` | `string` | Manager |
| `market` | `string` | nasdaq or cboe |
| `meta` | `map[string]any` | Who publishes the data and how to credit it |
| `minimumInvestment` | `any` | USD minimum accepted from an outside investor |
| `mod` | `any` | Modification number; 0 or null is the original award |
| `naicsCode` | `any` | Industry code of the work |
| `name` | `string` | Company |
| `netIncome` | `any` | Net income for the same fiscal year, USD |
| `noteType` | `any` | autocallable, buffered, barrier, or income. |
| `offeringAmount` | `any` | Always null; offering amounts are not included |
| `percentOfClass` | `any` | Percent of the class owned |
| `personName` | `string` | Person for whose account the shares are to be sold |
| `personType` | `any` | Type of reporting person as filed, e.g. |
| `price` | `any` | Closing price the SEC reports with the row, USD |
| `priceNote` | `any` | "price not stated in the filing" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); "≈ $61.36, midpoint of the stated range $60.86 to $61.85" when the price is the midpoint of… |
| `pricePerShare` | `any` | Reported price per share in USD |
| `pricingDate` | `any` | Pricing/trade date when stated |
| `principalUsd` | `any` | Aggregate principal when stated (final filings) |
| `quantity` | `float64` | Shares failed to deliver, as the SEC publishes them |
| `recipientName` | `string` | Recipient legal name as registered |
| `relationship` | `any` | Relationship to the issuer, e.g. |
| `reportingCik` | `any` | Reporting person's CIK, when filed |
| `reportingPerson` | `string` | Reporting person or entity |
| `revenue` | `any` | Revenue for the same fiscal year, USD |
| `revenueRange` | `any` | Issuer revenue range or fund net asset value range, as disclosed |
| `securityClass` | `any` | Title of the class of securities |
| `securityName` | `any` | Security name as listed |
| `securityTypes` | `any` | equity, debt, options, pooled fund, other |
| `settlementDate` | `string` | Settlement date |
| `shares` | `any` | Shares bought or sold |
| `sharesOwned` | `any` | Shares beneficially owned |
| `shortExemptVolume` | `any` | Short sales marked exempt |
| `shortQty` | `any` | Total shares held short |
| `shortRatio` | `any` | shortVolume divided by totalVolume |
| `shortVolume` | `float64` | Shares sold short that day, as reported to FINRA's facilities |
| `slug` | `string` | Fund slug for URLs |
| `source` | `string` |  |
| `state` | `any` | Issuer state or country code |
| `status` | `string` | reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives) |
| `symbol` | `any` | Ticker |
| `ticker` | `string` | Listed ticker |
| `totalAmountSold` | `any` | USD sold as of the filing |
| `totalOfferingAmount` | `any` | USD; null when indefinite |
| `totalVolume` | `float64` | Total shares reported to FINRA's facilities that day (not the consolidated tape) |
| `trades` | `float64` | Open-market purchase transactions in the window |
| `txDate` | `string` | Transaction date from the filing, YYYY-MM-DD |
| `underlyings` | `any` | Parsed underlying symbols (SPX, NDX, NVDA...). |
| `units` | `any` | Bitcoin held as tagged in the filing; null when the filing gives no usable count |
| `unitsOutstanding` | `any` | Shares or units of the class outstanding |
| `unitsReliable` | `bool` | true when the filing gives a usable coin count |
| `unitsToSell` | `any` | Shares or units to be sold |
| `updatedAt` | `string` | When the response was built; a few dated feeds give the date of their newest row instead |
| `url` | `string` | Hub page |
| `valueUsd` | `any` | quantity times price, USD |

#### Example: Load

```go
company, err := client.Company(nil).Load(map[string]any{"slug": "slug"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(company.(sdk.Entity).Data()) // the loaded entity's record
```

#### Example: List

```go
companys, err := client.Company(nil).List(nil, nil)
if err != nil {
    panic(err)
}
// A []any of entities, one per record.
for _, item := range companys.([]any) {
    fmt.Println(item.(sdk.Entity).Data())
}
```


### Crypto

Create an instance: `crypto := client.Crypto(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `asset` | `string` | btc or eth |
| `attribution` | `string` |  |
| `aumUsd` | `any` | Holdings valued in USD |
| `baseAsset` | `string` | Base asset ticker (BTC, ETH...) |
| `binanceSymbol` | `any` | Binance symbol |
| `bitmexSymbol` | `any` | Always null, kept so existing clients parse unchanged |
| `bybitSymbol` | `any` | Bybit symbol |
| `canonicalUrl` | `string` | The matching page on xoomar.com |
| `count` | `float64` | Events |
| `data` | `map[string]any` |  |
| `date` | `string` | The as-of date of the issuer file |
| `docs` | `string` |  |
| `exchange` | `string` | binance, bybit, okx, hyperliquid or kraken |
| `flowUsd` | `any` | Net flow for the day in USD, derived from the change in the fund's reported holdings |
| `fundingAnnualized` | `any` | Annualized rate, simple (not compounded), from the rate and its funding interval |
| `fundingIntervalHours` | `float64` | Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken) |
| `fundingRate` | `any` | Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval) |
| `fundingRate8h` | `any` | The rate scaled to eight hours, comparable across venues |
| `holdings` | `any` | Coins held per the issuer file |
| `hour` | `string` | Hour bucket, ISO |
| `hyperliquidCoin` | `any` | Hyperliquid coin |
| `id` | `float64` | Event id |
| `issuer` | `string` | Issuer name |
| `krakenSymbol` | `any` | Kraken Futures symbol |
| `license` | `string` | Data terms |
| `longShortRatio` | `any` | Global long/short account ratio where the venue publishes it, else null |
| `longUsd` | `float64` | Long liquidations in USD |
| `markPrice` | `any` | Latest mark price in USD |
| `maxSingleUsd` | `float64` | Largest single event |
| `meta` | `map[string]any` | Who publishes the data and how to credit it |
| `nextFundingTime` | `any` | ISO timestamp of the next funding settlement |
| `okxInstId` | `any` | OKX instrument id |
| `openInterest` | `any` | Open interest in contracts |
| `openInterestValue` | `any` | Open interest notional in USD |
| `price` | `string` | Liquidation price |
| `priceChangePct24h` | `any` | 24h price change as a decimal |
| `qty` | `string` | Quantity in coins |
| `rawSymbol` | `string` | Contract as the exchange names it |
| `shortUsd` | `float64` | Short liquidations in USD |
| `side` | `string` | long (forced sale) or short (forced buy) |
| `slug` | `string` | Symbol slug used in URLs (btc, eth, sol...) |
| `source` | `string` |  |
| `symbol` | `string` | Contract (only when filtered) |
| `ticker` | `string` | Fund ticker (IBIT, ETHA...) |
| `totalUsd` | `float64` | Total in USD |
| `ts` | `string` | Event time, ISO |
| `updatedAt` | `string` | When the response was built; a few dated feeds give the date of their newest row instead |
| `usdValue` | `string` | Notional in USD |

#### Example: Load

```go
crypto, err := client.Crypto(nil).Load(map[string]any{"coin": "coin"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(crypto.(sdk.Entity).Data()) // the loaded entity's record
```

#### Example: List

```go
cryptos, err := client.Crypto(nil).List(nil, nil)
if err != nil {
    panic(err)
}
// A []any of entities, one per record.
for _, item := range cryptos.([]any) {
    fmt.Println(item.(sdk.Entity).Data())
}
```


### Macro

Create an instance: `macro := client.Macro(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `actual` | `any` | Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...) |
| `assetMgrLong` | `any` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assetMgrShort` | `any` | Asset managers and institutional investors (tff); swap dealers (disagg) |
| `assets` | `float64` | Fed total assets, USD (WALCL) |
| `attribution` | `string` |  |
| `auctionDate` | `string` | Auction date |
| `bidToCover` | `any` | Tendered divided by accepted |
| `canonicalUrl` | `string` | The matching page on xoomar.com |
| `country` | `string` | Economy |
| `countryCode` | `string` | BIS area code |
| `cusip` | `string` | Security CUSIP; a reopening shares the original's CUSIP |
| `data` | `[]any` |  |
| `date` | `string` | H.4.1 Wednesday date |
| `dealerAccepted` | `any` | Accepted by primary dealers, USD |
| `dealerLong` | `any` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `dealerShare` | `any` | Dealer share of accepted, 0 to 1 |
| `dealerShort` | `any` | Dealers and intermediaries (tff); producers, merchants, processors and users (disagg) |
| `directAccepted` | `any` | Accepted from direct bidders, USD |
| `directShare` | `any` | Direct share of accepted, 0 to 1 |
| `docs` | `string` |  |
| `eventName` | `string` | CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ... |
| `forecast` | `any` | Always null: consensus forecasts aren't included |
| `group` | `string` | currencies, indices, crypto, metals, energy, bonds, agriculture, other |
| `highRate` | `any` | High discount rate (bills) or high discount margin (FRNs), percent |
| `highYield` | `any` | Stop-out yield, percent (notes, bonds, TIPS) |
| `importance` | `string` | high, med, or low |
| `indirectAccepted` | `any` | Accepted from indirect bidders, USD |
| `indirectShare` | `any` | Indirect share of accepted, 0 to 1 |
| `interestRate` | `any` | Coupon set at auction, percent |
| `issueDate` | `any` | Settlement date |
| `lastChanged` | `any` | Date of the most recent move |
| `levFundLong` | `any` | Leveraged funds (tff); managed money (disagg) |
| `levFundShort` | `any` | Leveraged funds (tff); managed money (disagg) |
| `license` | `string` | Data terms |
| `m1_m6` | `any` | 1, 2, 3, 6 month Treasury yields in percent |
| `maturityDate` | `any` | Maturity |
| `meta` | `map[string]any` | Who publishes the data and how to credit it |
| `name` | `string` | CFTC contract market name |
| `net` | `float64` | assets minus tga minus rrp, USD |
| `nonreptLong` | `any` | Non-reportable (small trader) positions |
| `nonreptShort` | `any` | Non-reportable (small trader) positions |
| `offeringAmount` | `any` | Announced size, USD |
| `openInterest` | `any` | Total open interest in contracts |
| `otherLong` | `any` | Other reportable positions |
| `otherShort` | `any` | Other reportable positions |
| `periodLabel` | `any` | Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05' |
| `previous` | `any` | Prior period on the same basis as actual |
| `rate` | `string` | Policy rate, percent |
| `reopening` | `any` | True when the auction adds to an existing issue |
| `reportDate` | `string` | CFTC report Tuesday, YYYY-MM-DD |
| `reportType` | `string` | tff (financial futures) or disagg (commodities) |
| `reserves` | `any` | Reserve balances with Federal Reserve Banks, USD (WRESBAL) |
| `rrp` | `float64` | Overnight reverse repo usage on that date, USD (RRPONTSYD) |
| `scheduledAt` | `string` | Release time, UTC |
| `securityTerm` | `string` | Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening) |
| `securityType` | `string` | Bill, CMB (cash management bill), Note, Bond, TIPS or FRN |
| `slug` | `string` | Market slug for URLs (euro-fx, gold...) |
| `sortRank` | `float64` | Display order within the group |
| `source` | `string` | bls, bea, census, fed, dol or treasury (coupon auctions) |
| `tga` | `float64` | Treasury General Account, USD (WTREGEN) |
| `totalAccepted` | `any` | Accepted, USD (null until results) |
| `totalTendered` | `any` | Bids received, USD |
| `unit` | `any` | What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance' |
| `updatedAt` | `string` | When the response was built; a few dated feeds give the date of their newest row instead |
| `y1_y30` | `any` | 1 to 30 year Treasury yields in percent |

#### Example: Load

```go
macro, err := client.Macro(nil).Load(map[string]any{"country": "country"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(macro.(sdk.Entity).Data()) // the loaded entity's record
```

#### Example: List

```go
macros, err := client.Macro(nil).List(nil, nil)
if err != nil {
    panic(err)
}
// A []any of entities, one per record.
for _, item := range macros.([]any) {
    fmt.Println(item.(sdk.Entity).Data())
}
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

Features are the extension mechanism. A feature implements the
`Feature` interface and provides hooks — functions keyed by pipeline
stage names.

The SDK ships with built-in features:

- **RatelimitFeature**: Rate limiting
- **RetryFeature**: Retry
- **TestFeature**: Test transport
- **TimeoutFeature**: Timeout

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as maps

The Go SDK uses `map[string]any` throughout rather than typed structs.
This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

An operation returns the entity, and its `Data()` returns the record. Use
`core.ToMapAny()` to safely cast that record, or data nested in it, to
`map[string]any`: it returns `nil` for anything else, an entity included.

### Package structure

```
github.com/voxgig-sdk/xoomar-markets-sdk/go/
├── xoomar-markets.go        # Root package — type aliases and constructors
├── core/               # SDK core — client, types, pipeline
├── entity/             # Entity implementations
├── feature/            # Built-in features (Base, Test, Log)
├── utility/            # Utility functions and struct library
└── test/               # Test suites
```

The root package (`github.com/voxgig-sdk/xoomar-markets-sdk/go`) re-exports everything needed
for normal use. Import sub-packages only when you need specific types
like `core.ToMapAny`.

### Entity state

Entity instances are stateful. After a successful `List`, the entity
stores the returned data and match criteria internally.

```go
macro := client.Macro(nil)
macro.List(nil, nil)

// macro.Data() now returns the macro data from the last list
// macro.Match() returns the last match criteria
```

Call `Make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`Direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `Prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
