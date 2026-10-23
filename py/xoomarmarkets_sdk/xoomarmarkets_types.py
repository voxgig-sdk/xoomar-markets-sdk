# Typed models for the XoomarMarkets SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
# params (op.<name>.points[].g.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.
#
# These are TypedDicts, not dataclasses: the SDK ops return/accept plain dicts
# at runtime, and a TypedDict IS a dict shape, so the types match the runtime.
# Optional (req:false) keys are modelled as TypedDict key-optionality
# (total=False), split into a required base + total=False subclass when a type
# has both required and optional keys.

from __future__ import annotations

from typing import TypedDict, Any


class Company(TypedDict, total=False):
    accessionNo: str | None
    actionDate: str
    actionType: str | None
    aggregateMarketValue: float | None
    amendmentNo: float | None
    amountUsd: float
    approxSaleDate: str | None
    asOf: str | None
    attribution: str
    avgDailyVol: float | None
    awardId: str
    awardType: str | None
    awardingAgency: str | None
    awardingSubAgency: str | None
    barrierPct: str | None
    basis: str | None
    broker: str | None
    buybacks: float
    buyers: list
    canonicalUrl: str
    capPct: str | None
    changePct: str | None
    cik: str
    company: str
    companyName: str
    costUsd: float | None
    coupon: str | None
    cusip: str
    data: dict
    date: str
    dateOfFirstSale: str | None
    daysToCover: str | None
    description: str | None
    docUrl: str
    docs: str
    end: str
    entityType: str | None
    eventDate: str | None
    eventLabels: list | None
    exchange: str | None
    exemptions: str | None
    fairValueUsd: float | None
    filedAt: str
    firstRegistration: str | None
    firstTxDate: str
    form: str | None
    formType: str
    frame: str
    fundType: str | None
    generatedId: str | None
    impliedPrice: float | None
    industryGroup: str | None
    insiderName: str
    insiderTitle: str | None
    insiders: float
    investorsCount: float | None
    isAmendment: bool
    issuer: str
    issuerCik: str | None
    issuerName: str
    items: list | None
    latestFiledAt: str | None
    latestTxDate: str
    license: str
    listed: bool
    manager: str
    market: str
    meta: dict
    minimumInvestment: float | None
    mod: str | None
    naicsCode: str | None
    name: str
    netIncome: float | None
    noteType: str | None
    offeringAmount: float | None
    percentOfClass: float | None
    personName: str
    personType: str | None
    price: float | None
    priceNote: str | None
    pricePerShare: str | None
    pricingDate: str | None
    principalUsd: str | None
    quantity: float
    recipientName: str
    relationship: str | None
    reportingCik: str | None
    reportingPerson: str
    revenue: float | None
    revenueRange: str | None
    securityClass: str | None
    securityName: str | None
    securityTypes: str | None
    settlementDate: str
    shares: str | None
    sharesOwned: float | None
    shortExemptVolume: float | None
    shortQty: float | None
    shortRatio: float | None
    shortVolume: float
    slug: str
    source: str
    state: str | None
    status: str
    symbol: str | None
    ticker: str
    totalAmountSold: float | None
    totalOfferingAmount: float | None
    totalVolume: float
    trades: float
    txDate: str
    underlyings: list | None
    units: float | None
    unitsOutstanding: float | None
    unitsReliable: bool
    unitsToSell: float | None
    updatedAt: str
    url: str
    valueUsd: float | None


class CompanyLoadMatch(TypedDict):
    slug: str


class CompanyListMatch(TypedDict, total=False):
    accessionNo: str | None
    actionDate: str
    actionType: str | None
    aggregateMarketValue: float | None
    amendmentNo: float | None
    amountUsd: float
    approxSaleDate: str | None
    asOf: str | None
    attribution: str
    avgDailyVol: float | None
    awardId: str
    awardType: str | None
    awardingAgency: str | None
    awardingSubAgency: str | None
    barrierPct: str | None
    basis: str | None
    broker: str | None
    buybacks: float
    buyers: list
    canonicalUrl: str
    capPct: str | None
    changePct: str | None
    cik: str
    company: str
    companyName: str
    costUsd: float | None
    coupon: str | None
    cusip: str
    data: dict
    date: str
    dateOfFirstSale: str | None
    daysToCover: str | None
    description: str | None
    docUrl: str
    docs: str
    end: str
    entityType: str | None
    eventDate: str | None
    eventLabels: list | None
    exchange: str | None
    exemptions: str | None
    fairValueUsd: float | None
    filedAt: str
    firstRegistration: str | None
    firstTxDate: str
    form: str | None
    formType: str
    frame: str
    fundType: str | None
    generatedId: str | None
    impliedPrice: float | None
    industryGroup: str | None
    insiderName: str
    insiderTitle: str | None
    insiders: float
    investorsCount: float | None
    isAmendment: bool
    issuer: str
    issuerCik: str | None
    issuerName: str
    items: list | None
    latestFiledAt: str | None
    latestTxDate: str
    license: str
    listed: bool
    manager: str
    market: str
    meta: dict
    minimumInvestment: float | None
    mod: str | None
    naicsCode: str | None
    name: str
    netIncome: float | None
    noteType: str | None
    offeringAmount: float | None
    percentOfClass: float | None
    personName: str
    personType: str | None
    price: float | None
    priceNote: str | None
    pricePerShare: str | None
    pricingDate: str | None
    principalUsd: str | None
    quantity: float
    recipientName: str
    relationship: str | None
    reportingCik: str | None
    reportingPerson: str
    revenue: float | None
    revenueRange: str | None
    securityClass: str | None
    securityName: str | None
    securityTypes: str | None
    settlementDate: str
    shares: str | None
    sharesOwned: float | None
    shortExemptVolume: float | None
    shortQty: float | None
    shortRatio: float | None
    shortVolume: float
    slug: str
    source: str
    state: str | None
    status: str
    symbol: str | None
    ticker: str
    totalAmountSold: float | None
    totalOfferingAmount: float | None
    totalVolume: float
    trades: float
    txDate: str
    underlyings: list | None
    units: float | None
    unitsOutstanding: float | None
    unitsReliable: bool
    unitsToSell: float | None
    updatedAt: str
    url: str
    valueUsd: float | None


class Crypto(TypedDict, total=False):
    asset: str
    attribution: str
    aumUsd: str | None
    baseAsset: str
    binanceSymbol: str | None
    bitmexSymbol: str | None
    bybitSymbol: str | None
    canonicalUrl: str
    count: float
    data: dict
    date: str
    docs: str
    exchange: str
    flowUsd: str | None
    fundingAnnualized: float | None
    fundingIntervalHours: float
    fundingRate: str | None
    fundingRate8h: float | None
    holdings: str | None
    hour: str
    hyperliquidCoin: str | None
    id: float
    issuer: str
    krakenSymbol: str | None
    license: str
    longShortRatio: str | None
    longUsd: float
    markPrice: str | None
    maxSingleUsd: float
    meta: dict
    nextFundingTime: str | None
    okxInstId: str | None
    openInterest: str | None
    openInterestValue: str | None
    price: str
    priceChangePct24h: str | None
    qty: str
    rawSymbol: str
    shortUsd: float
    side: str
    slug: str
    source: str
    symbol: str
    ticker: str
    totalUsd: float
    ts: str
    updatedAt: str
    usdValue: str


class CryptoLoadMatch(TypedDict):
    coin: str


class CryptoListMatch(TypedDict, total=False):
    asset: str
    day: int


class Macro(TypedDict, total=False):
    actual: str | None
    assetMgrLong: float | None
    assetMgrShort: float | None
    assets: float
    attribution: str
    auctionDate: str
    bidToCover: float | None
    canonicalUrl: str
    country: str
    countryCode: str
    cusip: str
    data: list
    date: str
    dealerAccepted: float | None
    dealerLong: float | None
    dealerShare: float | None
    dealerShort: float | None
    directAccepted: float | None
    directShare: float | None
    docs: str
    eventName: str
    forecast: str | None
    group: str
    highRate: float | None
    highYield: float | None
    importance: str
    indirectAccepted: float | None
    indirectShare: float | None
    interestRate: float | None
    issueDate: str | None
    lastChanged: str | None
    levFundLong: float | None
    levFundShort: float | None
    license: str
    m1_m6: str | None
    maturityDate: str | None
    meta: dict
    name: str
    net: float
    nonreptLong: float | None
    nonreptShort: float | None
    offeringAmount: float | None
    openInterest: float | None
    otherLong: float | None
    otherShort: float | None
    periodLabel: str | None
    previous: str | None
    rate: str
    reopening: bool | None
    reportDate: str
    reportType: str
    reserves: float | None
    rrp: float
    scheduledAt: str
    securityTerm: str
    securityType: str
    slug: str
    sortRank: float
    source: str
    tga: float
    totalAccepted: float | None
    totalTendered: float | None
    unit: str | None
    updatedAt: str
    y1_y30: str | None


MacroLoadMatchRequired = TypedDict('MacroLoadMatchRequired', {
    "country": str,
})

MacroLoadMatchOptional = TypedDict('MacroLoadMatchOptional', {
    "from": str,
    "to": str,
}, total=False)


class MacroLoadMatch(MacroLoadMatchRequired, MacroLoadMatchOptional):
    pass


MacroListMatch = TypedDict('MacroListMatch', {
    "from": str,
    "importance": str,
    "to": str,
}, total=False)
