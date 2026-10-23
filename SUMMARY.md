# XOOMAR market data API

JSON and CSV over plain GET. Every response carries the same envelope: data, updatedAt, source, docs, license, attribution and meta, whose sourceAttribution line credits the publisher of the data. No key needed to start: 10 requests a minute per IP without a key and 30 a minute with a free account key, with at least six months of history. Data terms: https://xoomar.com/terms. Credit XOOMAR with a link to the dataset page when you republish the data.

## Start here

This guide introduces the API, the client libraries, and the companion tools in this repository. Start with the API capabilities, choose a client for your application, and use the linked reference when you need exact request and response details.

The selected API surface contains 3 entities and 44 HTTP routes. There are 6 SDK targets and 2 companion tools.

An entity groups related API operations. An operation can have several routes with different inputs or authentication requirements. The SDK exposes the entity and its operations using the conventions of the selected language.

## What the API provides

### Company

Results: OK.

SDK operations: `list`, `load`.

Key fields to recognise:

- `accessionNo`: The filing&#39;s accession number for reported rows; null for estimates
- `actionDate`: Date the action was signed
- `actionType`: FPDS action type code
- `aggregateMarketValue`: Aggregate market value of the shares to be sold, USD
- `amendmentNo`: Amendment number; null for the original filing

### Crypto

Results: OK.

SDK operations: `list`, `load`.

Key fields to recognise:

- `asset`: btc or eth
- `aumUsd`: Holdings valued in USD
- `baseAsset`: Base asset ticker (BTC, ETH...)
- `binanceSymbol`: Binance symbol
- `bitmexSymbol`: Always null, kept so existing clients parse unchanged

### Macro

Results: OK.

SDK operations: `list`, `load`.

Key fields to recognise:

- `actual`: Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...)
- `assetMgrLong`: Asset managers and institutional investors (tff); swap dealers (disagg)
- `assetMgrShort`: Asset managers and institutional investors (tff); swap dealers (disagg)
- `assets`: Fed total assets, USD (WALCL)
- `auctionDate`: Auction date

### Route map

Use this map to locate a capability. Consult the entity reference before supplying request data; routes for the same operation can require different fields.

| Entity | SDK operation | HTTP route | Authentication |
| --- | --- | --- | --- |
| Company | `list` | `GET /api/markets/bitcoin-treasuries` | Not required |
| Company | `list` | `GET /api/markets/buybacks` | Not required |
| Company | `list` | `GET /api/markets/earnings` | Not required |
| Company | `list` | `GET /api/markets/events` | Not required |
| Company | `list` | `GET /api/markets/fails-to-deliver` | Not required |
| Company | `list` | `GET /api/markets/federal-contracts` | Not required |
| Company | `list` | `GET /api/markets/funds` | Not required |
| Company | `list` | `GET /api/markets/insiders` | Not required |
| Company | `list` | `GET /api/markets/insiders/clusters` | Not required |
| Company | `list` | `GET /api/markets/ipos` | Not required |
| Company | `list` | `GET /api/markets/large-holders` | Not required |
| Company | `list` | `GET /api/markets/planned-sales` | Not required |
| Company | `list` | `GET /api/markets/short-interest` | Not required |
| Company | `list` | `GET /api/markets/short-volume` | Not required |
| Company | `list` | `GET /api/markets/startup-funding` | Not required |
| Company | `list` | `GET /api/markets/structured-products` | Not required |
| Company | `list` | `GET /api/markets/threshold-list` | Not required |
| Company | `load` | `GET /api/markets/funds/{slug}` | Not required |
| Company | `load` | `GET /api/markets/financials` | Not required |
| Company | `load` | `GET /api/markets/earnings/{ticker}` | Not required |
| Company | `load` | `GET /api/markets/insiders/{ticker}` | Not required |
| Crypto | `list` | `GET /api/markets/etf-flows` | Not required |
| Crypto | `list` | `GET /api/markets/funding-rates` | Not required |
| Crypto | `list` | `GET /api/markets/liquidations/history` | Not required |
| Crypto | `list` | `GET /api/markets/liquidations/recent` | Not required |
| Crypto | `list` | `GET /api/markets/symbols` | Not required |
| Crypto | `load` | `GET /api/markets/whales/{coin}` | Not required |
| Crypto | `load` | `GET /api/markets/options/{currency}` | Not required |
| Crypto | `load` | `GET /api/markets/options/{currency}/dvol` | Not required |
| Crypto | `load` | `GET /api/markets/funding-rates/{slug}` | Not required |
| Crypto | `load` | `GET /api/markets/open-interest/{slug}` | Not required |
| Crypto | `load` | `GET /api/markets/sentiment/{slug}` | Not required |
| Crypto | `load` | `GET /api/markets/signals/{slug}` | Not required |
| Crypto | `load` | `GET /api/markets/liquidations` | Not required |
| Crypto | `load` | `GET /api/markets/sentiment` | Not required |
| Crypto | `load` | `GET /api/markets/whales` | Not required |
| Macro | `list` | `GET /api/markets/calendar` | Not required |
| Macro | `list` | `GET /api/markets/cot` | Not required |
| Macro | `list` | `GET /api/markets/fed-liquidity` | Not required |
| Macro | `list` | `GET /api/markets/macro` | Not required |
| Macro | `list` | `GET /api/markets/rates` | Not required |
| Macro | `list` | `GET /api/markets/treasury-auctions` | Not required |
| Macro | `load` | `GET /api/markets/rates/{country}` | Not required |
| Macro | `load` | `GET /api/markets/cot/{slug}` | Not required |

## Connect to the API

- API server: `https://xoomar.com`

The default credential is sent in the `x-api-key` header.

Free account key from /account

Check authentication for the route you plan to call. A route that declares no authentication can be used without credentials; this does not change the requirements of other routes. Keep credentials in environment variables or a configured secret provider, and keep them out of source control and logs.

## Make a first request

1. Choose the API server and an operation that matches your task.
2. Check the operation’s required input and authentication. Use values valid for your account and environment.
3. Send one request and inspect the returned data before adding retries, concurrency, or a larger batch.

A read request without required parameters or authentication is `GET /api/markets/bitcoin-treasuries`. For example:

```sh
curl --fail-with-body --silent --show-error 'https://xoomar.com/api/markets/bitcoin-treasuries'
```

Inspect the response using the Company reference. This checks the public route; authenticated operations need their own credentials and request data.

For an SDK call, install or build the chosen client, create a client instance with its documented configuration, and call the required entity operation. Language references describe the argument shape, asynchronous behaviour, and returned values.

## Choose an SDK

Choose the language already used by your application or service. The clients represent the same API model, while package setup, naming, and return types follow each language. Check the selected client’s reference and tests before integrating it into an existing application.

| Client | Repository directory | Distribution |
| --- | --- | --- |
| Golang | `go/` | Build from source |
| Lua | `lua/` | Build from source |
| PHP | `php/` | Build from source |
| Python | `py/` | Build from source |
| Ruby | `rb/` | Build from source |
| TypeScript | `ts/` | Build from source |

Build-from-source entries are not marked as published in the project model. Follow the build instructions in that target’s README, then consume the resulting package using your language’s local dependency mechanism. Published entries give the installation command recorded for that client.

## Companion tools

These targets provide another way to use the API. Their available commands or tools can cover a smaller set of operations than the client libraries.

### Go CLI

Use the command-line interface for shell-based tasks and scripts.

Repository directory: `go-cli/`. Not published. Build from the go-cli directory.


### Go MCP server

Use the MCP server to expose supported API operations to an MCP client.

Repository directory: `go-mcp/`. Not published. Build from the go-mcp directory.

- `xoomar-markets_list`: List records for an entity. Supported entities: `company`, `crypto`, `macro`.
- `xoomar-markets_load`: Load one record for an entity. Supported entities: `company`, `crypto`, `macro`.

## Operational features

Features supply behaviour around API calls, such as request handling, diagnostics, or local testing. Inclusion in this project does not mean a feature is enabled at runtime. Check the selected SDK’s supported features and configuration defaults, then enable the behaviour your application needs.

- `ratelimit`: Client-side rate limiting via a token bucket
- `retry`: Automatic retry of transient failures with exponential backoff
- `test`: In-memory mock transport for testing without a live server
- `timeout`: Per-request timeout with transport abort

Start with the default client configuration. Add request limits and diagnostics as needed, test error paths, and review retry behaviour before using operations that change data. A retry can repeat an operation unless the API provides a suitable guarantee.

## Continue with the documentation

- Follow the first-call guide for the setup sequence.
- Read the authentication guide before using protected routes.
- Use the API reference for request schemas, response formats, and status codes.
- Check the chosen SDK or companion tool reference for its configuration and supported operations.

