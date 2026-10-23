"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const node_path_1 = __importDefault(require("node:path"));
const Fs = __importStar(require("node:fs"));
const node_test_1 = require("node:test");
const node_assert_1 = __importDefault(require("node:assert"));
const live_runner_1 = require("../../live-runner");
const live_entity_1 = require("../../live-entity");
const __1 = require("../../..");
const utility_1 = require("../../utility");
(0, utility_1.loadEnvLocal)(__dirname + '/../../../.env.local');
(0, node_test_1.describe)('MacroEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when XOOMAR_MARKETS_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('XOOMAR_MARKETS_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.XoomarMarketsSDK.test();
        const ent = testsdk.Macro();
        (0, node_assert_1.default)(null != ent);
    });
    class FailHook extends __1.BaseFeature {
        name = 'failhook';
        version = '0.0.1';
        active = true;
        unexpected = 0;
        init() { }
        PreSpec() { throw new Error('macro hook failed'); }
        PreUnexpected() { this.unexpected++; }
    }
    (0, node_test_1.test)('stream-error', async () => {
        const offline = { net: { offline: true } };
        await node_assert_1.default.rejects(async () => {
            for await (const _item of __1.XoomarMarketsSDK.test(offline).Macro().stream('list')) { }
        }, /offline/);
        for await (const _item of __1.XoomarMarketsSDK.test(offline).Macro()
            .stream('list', undefined, { ctrl: { throw: false } })) { }
        if (null != __1.config.feature?.rbac) {
            const denied = __1.XoomarMarketsSDK.test(undefined, { feature: { rbac: { active: true, deny: true } } });
            await node_assert_1.default.rejects(async () => {
                for await (const _item of denied.Macro().stream('list')) { }
            }, (err) => 'rbac_denied' === err.code);
        }
    });
    (0, node_test_1.test)('stream-ctrl', async () => {
        const explain = {};
        const ctrl = { explain };
        for await (const _item of __1.XoomarMarketsSDK.test().Macro().stream('list', undefined, { ctrl })) { }
        node_assert_1.default.deepStrictEqual(Object.keys(ctrl), ['explain']);
        (0, node_assert_1.default)(explain === ctrl.explain && 0 < Object.keys(explain).length);
    });
    (0, node_test_1.test)('unexpected', async () => {
        const hook = new FailHook();
        const client = new __1.XoomarMarketsSDK({ feature: { test: { active: true } }, extend: [hook] });
        await node_assert_1.default.rejects(client.Macro().list(), /hook failed/);
        (0, node_assert_1.default)(0 < hook.unexpected);
        const fired = hook.unexpected;
        node_assert_1.default.strictEqual(await client.Macro().list(undefined, { throw: false }), undefined);
        (0, node_assert_1.default)(fired < hook.unexpected);
    });
    (0, node_test_1.test)('validate', async (t) => {
        if (null == __1.config.feature?.validate) {
            t.skip('feature not present in this SDK: validate');
            return;
        }
        const client = __1.XoomarMarketsSDK.test(undefined, { feature: { validate: { active: true } } });
        await node_assert_1.default.rejects(client.Macro().list({ "from": 1 }), (err) => 'validate_failed' === err.code);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.XOOMAR_MARKETS_TEST_LIVE;
        for (const op of ['list']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'macro.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": { "actual": { "a": true, "h": "Actual", "n": "actual", "r": false, "sh": "Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...)", "t": ["`$ONE`", ["`$STRING`", "`$NULL`"]], "key$": "actual", "index$": 0 }, "assetMgrLong": { "a": true, "h": "Asset Mgr Long", "n": "assetMgrLong", "r": false, "sh": "Asset managers and institutional investors (tff); swap dealers (disagg)", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "assetMgrLong", "index$": 1 }, "assetMgrShort": { "a": true, "h": "Asset Mgr Short", "n": "assetMgrShort", "r": false, "sh": "Asset managers and institutional investors (tff); swap dealers (disagg)", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "assetMgrShort", "index$": 2 }, "assets": { "a": true, "h": "Assets", "n": "assets", "r": false, "sh": "Fed total assets, USD (WALCL)", "t": "`$NUMBER`", "key$": "assets", "index$": 3 }, "attribution": { "a": true, "h": "Attribution", "n": "attribution", "r": false, "t": "`$STRING`", "key$": "attribution", "index$": 4 }, "auctionDate": { "a": true, "fo": "date", "h": "Auction Date", "n": "auctionDate", "r": false, "sh": "Auction date", "t": "`$STRING`", "key$": "auctionDate", "index$": 5 }, "bidToCover": { "a": true, "h": "Bid To Cover", "n": "bidToCover", "r": false, "sh": "Tendered divided by accepted", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "bidToCover", "index$": 6 }, "canonicalUrl": { "a": true, "fo": "uri", "h": "Canonical Url", "n": "canonicalUrl", "r": false, "sh": "The matching page on xoomar.com", "t": "`$STRING`", "key$": "canonicalUrl", "index$": 7 }, "country": { "a": true, "h": "Country", "n": "country", "r": false, "sh": "Economy", "t": "`$STRING`", "key$": "country", "index$": 8 }, "countryCode": { "a": true, "h": "Country Code", "n": "countryCode", "r": false, "sh": "BIS area code", "t": "`$STRING`", "key$": "countryCode", "index$": 9 }, "cusip": { "a": true, "h": "Cusip", "n": "cusip", "r": false, "sh": "Security CUSIP; a reopening shares the original's CUSIP", "t": "`$STRING`", "key$": "cusip", "index$": 10 }, "data": { "a": true, "h": "Data", "n": "data", "r": false, "t": "`$ARRAY`", "key$": "data", "index$": 11 }, "date": { "a": true, "fo": "date", "h": "Date", "n": "date", "r": false, "sh": "H.4.1 Wednesday date", "t": "`$STRING`", "key$": "date", "index$": 12 }, "dealerAccepted": { "a": true, "h": "Dealer Accepted", "n": "dealerAccepted", "r": false, "sh": "Accepted by primary dealers, USD", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "dealerAccepted", "index$": 13 }, "dealerLong": { "a": true, "h": "Dealer Long", "n": "dealerLong", "r": false, "sh": "Dealers and intermediaries (tff); producers, merchants, processors and users (disagg)", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "dealerLong", "index$": 14 }, "dealerShare": { "a": true, "h": "Dealer Share", "n": "dealerShare", "r": false, "sh": "Dealer share of accepted, 0 to 1", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "dealerShare", "index$": 15 }, "dealerShort": { "a": true, "h": "Dealer Short", "n": "dealerShort", "r": false, "sh": "Dealers and intermediaries (tff); producers, merchants, processors and users (disagg)", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "dealerShort", "index$": 16 }, "directAccepted": { "a": true, "h": "Direct Accepted", "n": "directAccepted", "r": false, "sh": "Accepted from direct bidders, USD", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "directAccepted", "index$": 17 }, "directShare": { "a": true, "h": "Direct Share", "n": "directShare", "r": false, "sh": "Direct share of accepted, 0 to 1", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "directShare", "index$": 18 }, "docs": { "a": true, "h": "Docs", "n": "docs", "r": false, "t": "`$STRING`", "key$": "docs", "index$": 19 }, "eventName": { "a": true, "h": "Event Name", "n": "eventName", "r": false, "sh": "CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ...", "t": "`$STRING`", "key$": "eventName", "index$": 20 }, "forecast": { "a": true, "h": "Forecast", "n": "forecast", "r": false, "sh": "Always null: consensus forecasts aren't included", "t": ["`$ONE`", ["`$STRING`", "`$NULL`"]], "key$": "forecast", "index$": 21 }, "group": { "a": true, "h": "Group", "n": "group", "r": false, "sh": "currencies, indices, crypto, metals, energy, bonds, agriculture, other", "t": "`$STRING`", "key$": "group", "index$": 22 }, "highRate": { "a": true, "h": "High Rate", "n": "highRate", "r": false, "sh": "High discount rate (bills) or high discount margin (FRNs), percent", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "highRate", "index$": 23 }, "highYield": { "a": true, "h": "High Yield", "n": "highYield", "r": false, "sh": "Stop-out yield, percent (notes, bonds, TIPS)", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "highYield", "index$": 24 }, "importance": { "a": true, "h": "Importance", "n": "importance", "r": false, "sh": "high, med, or low", "t": "`$STRING`", "key$": "importance", "index$": 25 }, "indirectAccepted": { "a": true, "h": "Indirect Accepted", "n": "indirectAccepted", "r": false, "sh": "Accepted from indirect bidders, USD", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "indirectAccepted", "index$": 26 }, "indirectShare": { "a": true, "h": "Indirect Share", "n": "indirectShare", "r": false, "sh": "Indirect share of accepted, 0 to 1", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "indirectShare", "index$": 27 }, "interestRate": { "a": true, "h": "Interest Rate", "n": "interestRate", "r": false, "sh": "Coupon set at auction, percent", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "interestRate", "index$": 28 }, "issueDate": { "a": true, "fo": "date", "h": "Issue Date", "n": "issueDate", "r": false, "sh": "Settlement date", "t": ["`$ONE`", ["`$STRING`", "`$NULL`"]], "key$": "issueDate", "index$": 29 }, "lastChanged": { "a": true, "h": "Last Changed", "n": "lastChanged", "r": false, "sh": "Date of the most recent move", "t": ["`$ONE`", ["`$STRING`", "`$NULL`"]], "key$": "lastChanged", "index$": 30 }, "levFundLong": { "a": true, "h": "Lev Fund Long", "n": "levFundLong", "r": false, "sh": "Leveraged funds (tff); managed money (disagg)", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "levFundLong", "index$": 31 }, "levFundShort": { "a": true, "h": "Lev Fund Short", "n": "levFundShort", "r": false, "sh": "Leveraged funds (tff); managed money (disagg)", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "levFundShort", "index$": 32 }, "license": { "a": true, "h": "License", "n": "license", "r": false, "sh": "Data terms", "t": "`$STRING`", "key$": "license", "index$": 33 }, "m1_m6": { "a": true, "h": "M1 M6", "n": "m1_m6", "r": false, "sh": "1, 2, 3, 6 month Treasury yields in percent", "t": ["`$ONE`", ["`$STRING`", "`$NULL`"]], "key$": "m1_m6", "index$": 34 }, "maturityDate": { "a": true, "fo": "date", "h": "Maturity Date", "n": "maturityDate", "r": false, "sh": "Maturity", "t": ["`$ONE`", ["`$STRING`", "`$NULL`"]], "key$": "maturityDate", "index$": 35 }, "meta": { "a": true, "h": "Meta", "n": "meta", "r": false, "sh": "Who publishes the data and how to credit it", "t": "`$OBJECT`", "key$": "meta", "index$": 36 }, "name": { "a": true, "h": "Name", "n": "name", "r": false, "sh": "CFTC contract market name", "t": "`$STRING`", "key$": "name", "index$": 37 }, "net": { "a": true, "h": "Net", "n": "net", "r": false, "sh": "assets minus tga minus rrp, USD", "t": "`$NUMBER`", "key$": "net", "index$": 38 }, "nonreptLong": { "a": true, "h": "Nonrept Long", "n": "nonreptLong", "r": false, "sh": "Non-reportable (small trader) positions", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "nonreptLong", "index$": 39 }, "nonreptShort": { "a": true, "h": "Nonrept Short", "n": "nonreptShort", "r": false, "sh": "Non-reportable (small trader) positions", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "nonreptShort", "index$": 40 }, "offeringAmount": { "a": true, "h": "Offering Amount", "n": "offeringAmount", "r": false, "sh": "Announced size, USD", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "offeringAmount", "index$": 41 }, "openInterest": { "a": true, "h": "Open Interest", "n": "openInterest", "r": false, "sh": "Total open interest in contracts", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "openInterest", "index$": 42 }, "otherLong": { "a": true, "h": "Other Long", "n": "otherLong", "r": false, "sh": "Other reportable positions", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "otherLong", "index$": 43 }, "otherShort": { "a": true, "h": "Other Short", "n": "otherShort", "r": false, "sh": "Other reportable positions", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "otherShort", "index$": 44 }, "periodLabel": { "a": true, "h": "Period Label", "n": "periodLabel", "r": false, "sh": "Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05'", "t": ["`$ONE`", ["`$STRING`", "`$NULL`"]], "key$": "periodLabel", "index$": 45 }, "previous": { "a": true, "h": "Previous", "n": "previous", "r": false, "sh": "Prior period on the same basis as actual", "t": ["`$ONE`", ["`$STRING`", "`$NULL`"]], "key$": "previous", "index$": 46 }, "rate": { "a": true, "h": "Rate", "n": "rate", "r": false, "sh": "Policy rate, percent", "t": "`$STRING`", "key$": "rate", "index$": 47 }, "reopening": { "a": true, "h": "Reopening", "n": "reopening", "r": false, "sh": "True when the auction adds to an existing issue", "t": ["`$ONE`", ["`$BOOLEAN`", "`$NULL`"]], "key$": "reopening", "index$": 48 }, "reportDate": { "a": true, "fo": "date", "h": "Report Date", "n": "reportDate", "r": false, "sh": "CFTC report Tuesday, YYYY-MM-DD", "t": "`$STRING`", "key$": "reportDate", "index$": 49 }, "reportType": { "a": true, "h": "Report Type", "n": "reportType", "r": false, "sh": "tff (financial futures) or disagg (commodities)", "t": "`$STRING`", "key$": "reportType", "index$": 50 }, "reserves": { "a": true, "h": "Reserves", "n": "reserves", "r": false, "sh": "Reserve balances with Federal Reserve Banks, USD (WRESBAL)", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "reserves", "index$": 51 }, "rrp": { "a": true, "h": "Rrp", "n": "rrp", "r": false, "sh": "Overnight reverse repo usage on that date, USD (RRPONTSYD)", "t": "`$NUMBER`", "key$": "rrp", "index$": 52 }, "scheduledAt": { "a": true, "fo": "date-time", "h": "Scheduled At", "n": "scheduledAt", "r": false, "sh": "Release time, UTC", "t": "`$STRING`", "key$": "scheduledAt", "index$": 53 }, "securityTerm": { "a": true, "h": "Security Term", "n": "securityTerm", "r": false, "sh": "Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening)", "t": "`$STRING`", "key$": "securityTerm", "index$": 54 }, "securityType": { "a": true, "h": "Security Type", "n": "securityType", "r": false, "sh": "Bill, CMB (cash management bill), Note, Bond, TIPS or FRN", "t": "`$STRING`", "key$": "securityType", "index$": 55 }, "slug": { "a": true, "h": "Slug", "n": "slug", "r": false, "sh": "Market slug for URLs (euro-fx, gold...)", "t": "`$STRING`", "key$": "slug", "index$": 56 }, "sortRank": { "a": true, "h": "Sort Rank", "n": "sortRank", "r": false, "sh": "Display order within the group", "t": "`$NUMBER`", "key$": "sortRank", "index$": 57 }, "source": { "a": true, "h": "Source", "n": "source", "r": false, "sh": "bls, bea, census, fed, dol or treasury (coupon auctions)", "t": "`$STRING`", "key$": "source", "index$": 58 }, "tga": { "a": true, "h": "Tga", "n": "tga", "r": false, "sh": "Treasury General Account, USD (WTREGEN)", "t": "`$NUMBER`", "key$": "tga", "index$": 59 }, "totalAccepted": { "a": true, "h": "Total Accepted", "n": "totalAccepted", "r": false, "sh": "Accepted, USD (null until results)", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "totalAccepted", "index$": 60 }, "totalTendered": { "a": true, "h": "Total Tendered", "n": "totalTendered", "r": false, "sh": "Bids received, USD", "t": ["`$ONE`", ["`$NUMBER`", "`$NULL`"]], "key$": "totalTendered", "index$": 61 }, "unit": { "a": true, "h": "Unit", "n": "unit", "r": false, "sh": "What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance'", "t": ["`$ONE`", ["`$STRING`", "`$NULL`"]], "key$": "unit", "index$": 62 }, "updatedAt": { "a": true, "fo": "date-time", "h": "Updated At", "n": "updatedAt", "r": false, "sh": "When the response was built; a few dated feeds give the date of their newest row instead", "t": "`$STRING`", "key$": "updatedAt", "index$": 63 }, "y1_y30": { "a": true, "h": "Y1 Y30", "n": "y1_y30", "r": false, "sh": "1 to 30 year Treasury yields in percent", "t": ["`$ONE`", ["`$STRING`", "`$NULL`"]], "key$": "y1_y30", "index$": 64 } }, "name": "macro", "op": { "list": { "input": "data", "name": "list", "points": [{ "a": true, "co": { "id": "GET /api/markets/calendar", "source": "openapi3", "version": 2 }, "g": { "query": [{ "a": true, "ex": "2026-01-01", "k": "query", "n": "from", "or": "from", "r": false, "t": "`$STRING`", "index$": 0 }, { "a": true, "k": "query", "n": "importance", "or": "importance", "r": false, "t": "`$STRING`", "index$": 1 }, { "a": true, "ex": "2026-01-01", "k": "query", "n": "to", "or": "to", "r": false, "t": "`$STRING`", "index$": 2 }] }, "k": "http", "m": "GET", "o": "/api/markets/calendar", "q": {}, "r": {}, "rs": { "kind": "json", "media": "application/json" }, "s": [{ "lit": "api" }, { "lit": "markets" }, { "lit": "calendar" }], "t": { "req": "`reqdata`", "res": "`body.data`" }, "index$": 0 }, { "a": true, "co": { "id": "GET /api/markets/cot", "source": "openapi3", "version": 2 }, "g": {}, "k": "http", "m": "GET", "o": "/api/markets/cot", "q": {}, "r": {}, "rs": { "kind": "json", "media": "application/json" }, "s": [{ "lit": "api" }, { "lit": "markets" }, { "lit": "cot" }], "t": { "req": "`reqdata`", "res": "`body.data`" }, "index$": 1 }, { "a": true, "co": { "id": "GET /api/markets/fed-liquidity", "source": "openapi3", "version": 2 }, "g": { "query": [{ "a": true, "ex": 5000, "k": "query", "n": "limit", "or": "limit", "r": false, "t": "`$INTEGER`", "index$": 0 }, { "a": true, "k": "query", "n": "series", "or": "series", "r": false, "t": "`$STRING`", "index$": 1 }] }, "k": "http", "m": "GET", "o": "/api/markets/fed-liquidity", "q": {}, "r": {}, "rs": { "kind": "json", "media": "application/json" }, "s": [{ "lit": "api" }, { "lit": "markets" }, { "lit": "fed-liquidity" }], "t": { "req": "`reqdata`", "res": "`body.data`" }, "index$": 2 }, { "a": true, "co": { "id": "GET /api/markets/macro", "source": "openapi3", "version": 2 }, "g": { "query": [{ "a": true, "ex": "2026-01-01", "k": "query", "n": "from", "or": "from", "r": false, "t": "`$STRING`", "index$": 0 }, { "a": true, "k": "query", "n": "series", "or": "series", "r": false, "t": "`$STRING`", "index$": 1 }, { "a": true, "ex": "2026-01-01", "k": "query", "n": "to", "or": "to", "r": false, "t": "`$STRING`", "index$": 2 }] }, "k": "http", "m": "GET", "o": "/api/markets/macro", "q": {}, "r": {}, "rs": { "kind": "json", "media": "application/json" }, "s": [{ "lit": "api" }, { "lit": "markets" }, { "lit": "macro" }], "t": { "req": "`reqdata`", "res": "`body.data`" }, "index$": 3 }, { "a": true, "co": { "id": "GET /api/markets/rates", "source": "openapi3", "version": 2 }, "g": {}, "k": "http", "m": "GET", "o": "/api/markets/rates", "q": {}, "r": {}, "rs": { "kind": "json", "media": "application/json" }, "s": [{ "lit": "api" }, { "lit": "markets" }, { "lit": "rates" }], "t": { "req": "`reqdata`", "res": "`body.data`" }, "index$": 4 }, { "a": true, "co": { "id": "GET /api/markets/treasury-auctions", "source": "openapi3", "version": 2 }, "g": { "query": [{ "a": true, "ex": "2026-01-01", "k": "query", "n": "from", "or": "from", "r": false, "t": "`$STRING`", "index$": 0 }, { "a": true, "ex": 100, "k": "query", "n": "limit", "or": "limit", "r": false, "t": "`$INTEGER`", "index$": 1 }, { "a": true, "ex": "10-Year", "k": "query", "n": "term", "or": "term", "r": false, "t": "`$STRING`", "index$": 2 }, { "a": true, "ex": "2026-01-01", "k": "query", "n": "to", "or": "to", "r": false, "t": "`$STRING`", "index$": 3 }, { "a": true, "k": "query", "n": "type", "or": "type", "r": false, "t": "`$STRING`", "index$": 4 }, { "a": true, "k": "query", "n": "upcoming", "or": "upcoming", "r": false, "t": "`$BOOLEAN`", "index$": 5 }] }, "k": "http", "m": "GET", "o": "/api/markets/treasury-auctions", "q": {}, "r": {}, "rs": { "kind": "json", "media": "application/json" }, "s": [{ "lit": "api" }, { "lit": "markets" }, { "lit": "treasury-auctions" }], "t": { "req": "`reqdata`", "res": "`body.data`" }, "index$": 5 }], "key$": "list" }, "load": { "input": "data", "name": "load", "points": [{ "a": true, "co": { "id": "GET /api/markets/rates/{country}", "source": "openapi3", "version": 2 }, "g": { "params": [{ "a": true, "ex": "us", "k": "param", "n": "country", "or": "country", "r": true, "t": "`$STRING`", "index$": 0 }], "query": [{ "a": true, "ex": "2026-01-01", "k": "query", "n": "from", "or": "from", "r": false, "t": "`$STRING`", "index$": 0 }, { "a": true, "ex": "2026-01-01", "k": "query", "n": "to", "or": "to", "r": false, "t": "`$STRING`", "index$": 1 }] }, "k": "http", "m": "GET", "o": "/api/markets/rates/{country}", "q": { "exist": ["country"] }, "r": {}, "rs": { "kind": "json", "media": "application/json" }, "s": [{ "lit": "api" }, { "lit": "markets" }, { "lit": "rates" }, { "var": "country" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }, { "a": true, "co": { "id": "GET /api/markets/cot/{slug}", "source": "openapi3", "version": 2 }, "g": { "params": [{ "a": true, "ex": "e-mini-s-p-500-stock-index", "k": "param", "n": "slug", "or": "slug", "r": true, "t": "`$STRING`", "index$": 0 }], "query": [{ "a": true, "ex": "2026-01-01", "k": "query", "n": "from", "or": "from", "r": false, "t": "`$STRING`", "index$": 0 }, { "a": true, "ex": "2026-01-01", "k": "query", "n": "to", "or": "to", "r": false, "t": "`$STRING`", "index$": 1 }] }, "k": "http", "m": "GET", "o": "/api/markets/cot/{slug}", "q": { "exist": ["slug"] }, "r": {}, "rs": { "kind": "json", "media": "application/json" }, "s": [{ "lit": "api" }, { "lit": "markets" }, { "lit": "cot" }, { "var": "slug" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 1 }], "key$": "load" } }, "relations": { "ancestors": [] }, "key$": "macro", "name__orig": "macro", "Name": "Macro", "name_": "macro", "name-": "macro", "NAME": "MACRO", "index$": 2 }, { "active": true, "entity": "macro", "key$": "BasicMacroFlow", "kind": "basic", "name": "BasicMacroFlow", "param": {}, "step": [{ "a": true, "d": {}, "i": {}, "m": {}, "o": "list", "s": [], "v": [{ "apply": "ItemExists", "def": { "ref": "macro_ref01" } }], "index$": 0 }, { "a": false, "d": {}, "i": { "ref": "macro_ref01", "srcdatavar": "macro_ref01_data", "suffix": "_dt0" }, "m": { "id": "macro01" }, "o": "load", "s": [], "v": [{ "apply": "TextFieldMark", "def": { "mark": "Mark01-macro_ref01" } }], "unreachable": true }] }, 'Macro', { "GET /api/markets/calendar": { "protocol": "http", "parameters": [{ "name": "from", "in": "query", "required": false, "description": "First release date (default 7 days ago) (YYYY-MM-DD)", "schema": { "type": "string" }, "example": "2026-01-01", "index$": 0 }, { "name": "to", "in": "query", "required": false, "description": "Last release date (default 30 days ahead) (YYYY-MM-DD)", "schema": { "type": "string" }, "example": "2026-01-01", "index$": 1 }, { "name": "importance", "in": "query", "required": false, "description": "Importance filter", "schema": { "type": "string", "enum": ["high", "med", "low"] }, "index$": 2 }] }, "GET /api/markets/cot": { "protocol": "http", "parameters": [] }, "GET /api/markets/fed-liquidity": { "protocol": "http", "parameters": [{ "name": "series", "in": "query", "required": false, "description": "One series instead, by its id (WALCL, RRPONTSYD, WTREGEN, SOFR, IORB...)", "schema": { "type": "string" }, "index$": 0 }, { "name": "limit", "in": "query", "required": false, "description": "Rows returned, newest first inside the window (default 5000, max 10000)", "schema": { "type": "integer" }, "example": 5000, "index$": 1 }] }, "GET /api/markets/macro": { "protocol": "http", "parameters": [{ "name": "series", "in": "query", "required": false, "description": "yield-curve (default, daily), spreads (weekly 10y-2y and 10y-3m) or stablecoins (daily total supply, data by DefiLlama)", "schema": { "type": "string", "enum": ["yield-curve", "spreads", "stablecoins"] }, "index$": 0 }, { "name": "from", "in": "query", "required": false, "description": "First date (YYYY-MM-DD)", "schema": { "type": "string" }, "example": "2026-01-01", "index$": 1 }, { "name": "to", "in": "query", "required": false, "description": "Last date (YYYY-MM-DD)", "schema": { "type": "string" }, "example": "2026-01-01", "index$": 2 }] }, "GET /api/markets/rates": { "protocol": "http", "parameters": [] }, "GET /api/markets/treasury-auctions": { "protocol": "http", "parameters": [{ "name": "type", "in": "query", "required": false, "description": "Security type (default: coupon auctions)", "schema": { "type": "string", "enum": ["Note", "Bond", "TIPS", "FRN", "Bill", "CMB", "all"] }, "index$": 0 }, { "name": "term", "in": "query", "required": false, "description": "One term", "schema": { "type": "string" }, "example": "10-Year", "index$": 1 }, { "name": "from", "in": "query", "required": false, "description": "First auction date (YYYY-MM-DD)", "schema": { "type": "string" }, "example": "2026-01-01", "index$": 2 }, { "name": "to", "in": "query", "required": false, "description": "Last auction date (YYYY-MM-DD)", "schema": { "type": "string" }, "example": "2026-01-01", "index$": 3 }, { "name": "upcoming", "in": "query", "required": false, "description": "Announced auctions not yet run, soonest first", "schema": { "type": "boolean" }, "index$": 4 }, { "name": "limit", "in": "query", "required": false, "description": "Rows returned, newest first inside the window (default 100, max 5000)", "schema": { "type": "integer" }, "example": 100, "index$": 5 }] }, "GET /api/markets/rates/{country}": { "protocol": "http", "parameters": [{ "name": "country", "in": "path", "required": true, "description": "BIS area code: us, xm for the euro area, gb, jp and so on", "schema": { "type": "string" }, "example": "us", "index$": 0 }, { "name": "from", "in": "query", "required": false, "description": "First date (YYYY-MM-DD)", "schema": { "type": "string" }, "example": "2026-01-01", "index$": 1 }, { "name": "to", "in": "query", "required": false, "description": "Last date (YYYY-MM-DD)", "schema": { "type": "string" }, "example": "2026-01-01", "index$": 2 }] }, "GET /api/markets/cot/{slug}": { "protocol": "http", "parameters": [{ "name": "slug", "in": "path", "required": true, "description": "Market slug from /api/markets/cot", "schema": { "type": "string" }, "example": "e-mini-s-p-500-stock-index", "index$": 0 }, { "name": "from", "in": "query", "required": false, "description": "First report date (YYYY-MM-DD)", "schema": { "type": "string" }, "example": "2026-01-01", "index$": 1 }, { "name": "to", "in": "query", "required": false, "description": "Last report date (YYYY-MM-DD)", "schema": { "type": "string" }, "example": "2026-01-01", "index$": 2 }] } }, { strict: LIVE_STRICT, t });
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        let macro_ref01_data = Object.values(setup.data.existing.macro)[0];
        // LIST
        const macro_ref01_ent = client.Macro();
        const macro_ref01_match = {};
        const macro_ref01_list = (await macro_ref01_ent.list(macro_ref01_match)).map((e) => e.data());
    });
});
// main.kit.test.live.strict is true (the default is true): a live
// request that fails, or a live test missing an input it needs,
// fails the test.
// An account with no record for a test to read skips it either way.
const LIVE_STRICT = true;
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/macro/MacroTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.XoomarMarketsSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['macro01', 'macro02', 'macro03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'XOOMAR_MARKETS_TEST_MACRO_ENTID': idmap,
        'XOOMAR_MARKETS_TEST_LIVE': 'FALSE',
        'XOOMAR_MARKETS_TEST_EXPLAIN': 'FALSE',
        'XOOMAR_MARKETS_APIKEY': '',
    });
    idmap = env['XOOMAR_MARKETS_TEST_MACRO_ENTID'];
    const live = 'TRUE' === env.XOOMAR_MARKETS_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['XOOMAR_MARKETS_TEST_MACRO_ENTID'];
        idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {};
        if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
            throw new Error('Live ENTID must be a JSON object');
        }
        client = new __1.XoomarMarketsSDK(merge([
            // FIRST, so the generated fields below win: sdk-test-control.json's
            // test.client.options adds to the live client, it does not redirect it.
            (0, utility_1.liveClientOptions)(),
            {
                apikey: env.XOOMAR_MARKETS_APIKEY,
            },
            // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
            // last entry is undefined, and basicSetup is normally called with no
            // argument at all - so a bare 'extra' silently discarded the apikey
            // and server values above and handed the SDK undefined. Harmless
            // while there was nothing in that object; not harmless now.
            extra || {},
            { system: { fetch: transport.fetch } }
        ]));
    }
    const setup = {
        idmap,
        env,
        options,
        client,
        struct,
        data: entityData,
        explain: 'TRUE' === env.XOOMAR_MARKETS_TEST_EXPLAIN,
        live,
        transport,
        now: Date.now(),
    };
    return setup;
}
//# sourceMappingURL=MacroEntity.test.js.map