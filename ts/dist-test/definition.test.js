"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const node_test_1 = require("node:test");
const __1 = require("..");
const definition_runner_1 = require("./definition-runner");
const utility_1 = require("./utility");
// Generated from the API definition, not from the model this SDK was built
// from: the route, the declared query parameters, the credential the security
// scheme names, and the definition's own response example.
const PLAN = [
    {
        "entity": "company",
        "accessor": "Company",
        "op": "load",
        "method": "GET",
        "path": "/api/markets/funds/{slug}",
        "args": [
            {
                "name": "slug",
                "wire": "slug",
                "value": "berkshire-hathaway"
            }
        ],
        "select": {},
        "headers": [],
        "cookies": [],
        "responseMedia": [
            "application/json"
        ],
        "query": [],
        "queryArgs": [],
        "auth": [],
        "status": 200,
        "sample": {
            "data": {
                "fund": {},
                "quarter": "2026-01-01",
                "holdings": [
                    {
                        "issuerName": "x",
                        "ticker": "x",
                        "cusip": "x",
                        "putCall": "x",
                        "valueUsd": 1,
                        "shares": 1,
                        "pctOfPortfolio": "x",
                        "changeShares": 1,
                        "canonicalUrl": "x"
                    }
                ],
                "canonicalUrl": "x"
            },
            "updatedAt": "2026-01-01T00:00:00Z",
            "source": "x",
            "docs": "x",
            "license": "x",
            "attribution": "x",
            "canonicalUrl": "x",
            "meta": {
                "source": "x",
                "sourceAttribution": "x",
                "notice": "x"
            }
        },
        "idField": "id"
    },
    {
        "entity": "company",
        "accessor": "Company",
        "op": "load",
        "method": "GET",
        "path": "/api/markets/financials",
        "args": [],
        "select": {
            "symbol": "AAPL"
        },
        "headers": [],
        "cookies": [],
        "responseMedia": [
            "application/json"
        ],
        "query": [
            "symbol"
        ],
        "queryArgs": [
            {
                "name": "symbol",
                "wire": "symbol"
            }
        ],
        "auth": [],
        "status": 200,
        "sample": {
            "data": {
                "quarterly": [
                    {
                        "frame": "x",
                        "fiscalPeriod": "x",
                        "fiscalYear": "x",
                        "derived": true,
                        "revenue": 1,
                        "netIncome": 1,
                        "epsDiluted": 1,
                        "canonicalUrl": "x"
                    }
                ],
                "annual": [
                    {
                        "fiscalYear": "x",
                        "operatingCashFlow": 1,
                        "capex": 1,
                        "buybacks": 1,
                        "dividends": 1,
                        "canonicalUrl": "x"
                    }
                ],
                "latest.cash": 1,
                "latest.debt": 1,
                "latest.equity": 1,
                "latest.assets": 1,
                "latest.sharesOutstanding": 1,
                "canonicalUrl": "x"
            },
            "updatedAt": "2026-01-01T00:00:00Z",
            "source": "x",
            "docs": "x",
            "license": "x",
            "attribution": "x",
            "canonicalUrl": "x",
            "meta": {
                "source": "x",
                "sourceAttribution": "x",
                "notice": "x"
            }
        },
        "idField": "id"
    },
    {
        "entity": "crypto",
        "accessor": "Crypto",
        "op": "load",
        "method": "GET",
        "path": "/api/markets/whales/{coin}",
        "args": [
            {
                "name": "coin",
                "wire": "coin",
                "value": "btc"
            }
        ],
        "select": {},
        "headers": [],
        "cookies": [],
        "responseMedia": [
            "application/json"
        ],
        "query": [],
        "queryArgs": [],
        "auth": [],
        "status": 200,
        "sample": {
            "data": {
                "positions": [
                    {
                        "wallet": "x",
                        "coin": "x",
                        "side": "x",
                        "size": 1,
                        "uPnl": 1,
                        "canonicalUrl": "x"
                    }
                ],
                "canonicalUrl": "x"
            },
            "updatedAt": "2026-01-01T00:00:00Z",
            "source": "x",
            "docs": "x",
            "license": "x",
            "attribution": "x",
            "canonicalUrl": "x",
            "meta": {
                "source": "x",
                "sourceAttribution": "x",
                "notice": "x"
            }
        },
        "idField": "id"
    },
    {
        "entity": "macro",
        "accessor": "Macro",
        "op": "load",
        "method": "GET",
        "path": "/api/markets/rates/{country}",
        "args": [
            {
                "name": "country",
                "wire": "country",
                "value": "us"
            }
        ],
        "select": {
            "from": "2026-01-01",
            "to": "2026-01-01"
        },
        "headers": [],
        "cookies": [],
        "responseMedia": [
            "application/json"
        ],
        "query": [
            "from",
            "to"
        ],
        "queryArgs": [
            {
                "name": "from",
                "wire": "from"
            },
            {
                "name": "to",
                "wire": "to"
            }
        ],
        "auth": [],
        "status": 200,
        "sample": {
            "data": [
                {
                    "date": "2026-01-01",
                    "rate": "x",
                    "changed": true,
                    "canonicalUrl": "x"
                }
            ],
            "updatedAt": "2026-01-01T00:00:00Z",
            "source": "x",
            "docs": "x",
            "license": "x",
            "attribution": "x",
            "canonicalUrl": "x",
            "meta": {
                "source": "x",
                "sourceAttribution": "x",
                "notice": "x"
            }
        },
        "idField": "id"
    },
    {
        "entity": "macro",
        "accessor": "Macro",
        "op": "load",
        "method": "GET",
        "path": "/api/markets/cot/{slug}",
        "args": [
            {
                "name": "slug",
                "wire": "slug",
                "value": "e-mini-s-p-500-stock-index"
            }
        ],
        "select": {
            "from": "2026-01-01",
            "to": "2026-01-01"
        },
        "headers": [],
        "cookies": [],
        "responseMedia": [
            "application/json"
        ],
        "query": [
            "from",
            "to"
        ],
        "queryArgs": [
            {
                "name": "from",
                "wire": "from"
            },
            {
                "name": "to",
                "wire": "to"
            }
        ],
        "auth": [],
        "status": 200,
        "sample": {
            "data": [
                {
                    "reportDate": "2026-01-01",
                    "openInterest": 1,
                    "dealerLong": 1,
                    "dealerShort": 1,
                    "assetMgrLong": 1,
                    "assetMgrShort": 1,
                    "levFundLong": 1,
                    "levFundShort": 1,
                    "otherLong": 1,
                    "otherShort": 1,
                    "nonreptLong": 1,
                    "nonreptShort": 1,
                    "canonicalUrl": "x"
                }
            ],
            "updatedAt": "2026-01-01T00:00:00Z",
            "source": "x",
            "docs": "x",
            "license": "x",
            "attribution": "x",
            "canonicalUrl": "x",
            "meta": {
                "source": "x",
                "sourceAttribution": "x",
                "notice": "x"
            }
        },
        "idField": "id"
    }
];
(0, node_test_1.describe)('definition', () => {
    for (const point of PLAN) {
        (0, node_test_1.test)(point.entity + '.' + point.op + ' ' + point.method + ' ' + point.path, async (t) => {
            const control = (0, utility_1.isControlSkipped)('entityOp', point.entity + '.' + point.op, 'definition');
            if (control.skip) {
                t.skip(control.reason || 'skipped via sdk-test-control.json');
                return;
            }
            await (0, definition_runner_1.runDefinitionPoint)(__1.SDK, point);
        });
    }
});
//# sourceMappingURL=definition.test.js.map