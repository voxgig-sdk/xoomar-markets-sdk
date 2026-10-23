# frozen_string_literal: true

# Typed models for the XoomarMarkets SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
# params (op.<name>.points[].g.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# Company entity data model.
#
# @!attribute [rw] accessionNo
#   @return [Object, nil]
#
# @!attribute [rw] actionDate
#   @return [String, nil]
#
# @!attribute [rw] actionType
#   @return [Object, nil]
#
# @!attribute [rw] aggregateMarketValue
#   @return [Object, nil]
#
# @!attribute [rw] amendmentNo
#   @return [Object, nil]
#
# @!attribute [rw] amountUsd
#   @return [Float, nil]
#
# @!attribute [rw] approxSaleDate
#   @return [Object, nil]
#
# @!attribute [rw] asOf
#   @return [Object, nil]
#
# @!attribute [rw] attribution
#   @return [String, nil]
#
# @!attribute [rw] avgDailyVol
#   @return [Object, nil]
#
# @!attribute [rw] awardId
#   @return [String, nil]
#
# @!attribute [rw] awardType
#   @return [Object, nil]
#
# @!attribute [rw] awardingAgency
#   @return [Object, nil]
#
# @!attribute [rw] awardingSubAgency
#   @return [Object, nil]
#
# @!attribute [rw] barrierPct
#   @return [Object, nil]
#
# @!attribute [rw] basis
#   @return [Object, nil]
#
# @!attribute [rw] broker
#   @return [Object, nil]
#
# @!attribute [rw] buybacks
#   @return [Float, nil]
#
# @!attribute [rw] buyers
#   @return [Array, nil]
#
# @!attribute [rw] canonicalUrl
#   @return [String, nil]
#
# @!attribute [rw] capPct
#   @return [Object, nil]
#
# @!attribute [rw] changePct
#   @return [Object, nil]
#
# @!attribute [rw] cik
#   @return [String, nil]
#
# @!attribute [rw] company
#   @return [String, nil]
#
# @!attribute [rw] companyName
#   @return [String, nil]
#
# @!attribute [rw] costUsd
#   @return [Object, nil]
#
# @!attribute [rw] coupon
#   @return [Object, nil]
#
# @!attribute [rw] cusip
#   @return [String, nil]
#
# @!attribute [rw] data
#   @return [Hash, nil]
#
# @!attribute [rw] date
#   @return [String, nil]
#
# @!attribute [rw] dateOfFirstSale
#   @return [Object, nil]
#
# @!attribute [rw] daysToCover
#   @return [Object, nil]
#
# @!attribute [rw] description
#   @return [Object, nil]
#
# @!attribute [rw] docUrl
#   @return [String, nil]
#
# @!attribute [rw] docs
#   @return [String, nil]
#
# @!attribute [rw] end
#   @return [String, nil]
#
# @!attribute [rw] entityType
#   @return [Object, nil]
#
# @!attribute [rw] eventDate
#   @return [Object, nil]
#
# @!attribute [rw] eventLabels
#   @return [Object, nil]
#
# @!attribute [rw] exchange
#   @return [Object, nil]
#
# @!attribute [rw] exemptions
#   @return [Object, nil]
#
# @!attribute [rw] fairValueUsd
#   @return [Object, nil]
#
# @!attribute [rw] filedAt
#   @return [String, nil]
#
# @!attribute [rw] firstRegistration
#   @return [Object, nil]
#
# @!attribute [rw] firstTxDate
#   @return [String, nil]
#
# @!attribute [rw] form
#   @return [Object, nil]
#
# @!attribute [rw] formType
#   @return [String, nil]
#
# @!attribute [rw] frame
#   @return [String, nil]
#
# @!attribute [rw] fundType
#   @return [Object, nil]
#
# @!attribute [rw] generatedId
#   @return [Object, nil]
#
# @!attribute [rw] impliedPrice
#   @return [Object, nil]
#
# @!attribute [rw] industryGroup
#   @return [Object, nil]
#
# @!attribute [rw] insiderName
#   @return [String, nil]
#
# @!attribute [rw] insiderTitle
#   @return [Object, nil]
#
# @!attribute [rw] insiders
#   @return [Float, nil]
#
# @!attribute [rw] investorsCount
#   @return [Object, nil]
#
# @!attribute [rw] isAmendment
#   @return [Boolean, nil]
#
# @!attribute [rw] issuer
#   @return [String, nil]
#
# @!attribute [rw] issuerCik
#   @return [Object, nil]
#
# @!attribute [rw] issuerName
#   @return [String, nil]
#
# @!attribute [rw] items
#   @return [Object, nil]
#
# @!attribute [rw] latestFiledAt
#   @return [Object, nil]
#
# @!attribute [rw] latestTxDate
#   @return [String, nil]
#
# @!attribute [rw] license
#   @return [String, nil]
#
# @!attribute [rw] listed
#   @return [Boolean, nil]
#
# @!attribute [rw] manager
#   @return [String, nil]
#
# @!attribute [rw] market
#   @return [String, nil]
#
# @!attribute [rw] meta
#   @return [Hash, nil]
#
# @!attribute [rw] minimumInvestment
#   @return [Object, nil]
#
# @!attribute [rw] mod
#   @return [Object, nil]
#
# @!attribute [rw] naicsCode
#   @return [Object, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] netIncome
#   @return [Object, nil]
#
# @!attribute [rw] noteType
#   @return [Object, nil]
#
# @!attribute [rw] offeringAmount
#   @return [Object, nil]
#
# @!attribute [rw] percentOfClass
#   @return [Object, nil]
#
# @!attribute [rw] personName
#   @return [String, nil]
#
# @!attribute [rw] personType
#   @return [Object, nil]
#
# @!attribute [rw] price
#   @return [Object, nil]
#
# @!attribute [rw] priceNote
#   @return [Object, nil]
#
# @!attribute [rw] pricePerShare
#   @return [Object, nil]
#
# @!attribute [rw] pricingDate
#   @return [Object, nil]
#
# @!attribute [rw] principalUsd
#   @return [Object, nil]
#
# @!attribute [rw] quantity
#   @return [Float, nil]
#
# @!attribute [rw] recipientName
#   @return [String, nil]
#
# @!attribute [rw] relationship
#   @return [Object, nil]
#
# @!attribute [rw] reportingCik
#   @return [Object, nil]
#
# @!attribute [rw] reportingPerson
#   @return [String, nil]
#
# @!attribute [rw] revenue
#   @return [Object, nil]
#
# @!attribute [rw] revenueRange
#   @return [Object, nil]
#
# @!attribute [rw] securityClass
#   @return [Object, nil]
#
# @!attribute [rw] securityName
#   @return [Object, nil]
#
# @!attribute [rw] securityTypes
#   @return [Object, nil]
#
# @!attribute [rw] settlementDate
#   @return [String, nil]
#
# @!attribute [rw] shares
#   @return [Object, nil]
#
# @!attribute [rw] sharesOwned
#   @return [Object, nil]
#
# @!attribute [rw] shortExemptVolume
#   @return [Object, nil]
#
# @!attribute [rw] shortQty
#   @return [Object, nil]
#
# @!attribute [rw] shortRatio
#   @return [Object, nil]
#
# @!attribute [rw] shortVolume
#   @return [Float, nil]
#
# @!attribute [rw] slug
#   @return [String, nil]
#
# @!attribute [rw] source
#   @return [String, nil]
#
# @!attribute [rw] state
#   @return [Object, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
#
# @!attribute [rw] symbol
#   @return [Object, nil]
#
# @!attribute [rw] ticker
#   @return [String, nil]
#
# @!attribute [rw] totalAmountSold
#   @return [Object, nil]
#
# @!attribute [rw] totalOfferingAmount
#   @return [Object, nil]
#
# @!attribute [rw] totalVolume
#   @return [Float, nil]
#
# @!attribute [rw] trades
#   @return [Float, nil]
#
# @!attribute [rw] txDate
#   @return [String, nil]
#
# @!attribute [rw] underlyings
#   @return [Object, nil]
#
# @!attribute [rw] units
#   @return [Object, nil]
#
# @!attribute [rw] unitsOutstanding
#   @return [Object, nil]
#
# @!attribute [rw] unitsReliable
#   @return [Boolean, nil]
#
# @!attribute [rw] unitsToSell
#   @return [Object, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
#
# @!attribute [rw] valueUsd
#   @return [Object, nil]
Company = Struct.new(
  :accessionNo,
  :actionDate,
  :actionType,
  :aggregateMarketValue,
  :amendmentNo,
  :amountUsd,
  :approxSaleDate,
  :asOf,
  :attribution,
  :avgDailyVol,
  :awardId,
  :awardType,
  :awardingAgency,
  :awardingSubAgency,
  :barrierPct,
  :basis,
  :broker,
  :buybacks,
  :buyers,
  :canonicalUrl,
  :capPct,
  :changePct,
  :cik,
  :company,
  :companyName,
  :costUsd,
  :coupon,
  :cusip,
  :data,
  :date,
  :dateOfFirstSale,
  :daysToCover,
  :description,
  :docUrl,
  :docs,
  :end,
  :entityType,
  :eventDate,
  :eventLabels,
  :exchange,
  :exemptions,
  :fairValueUsd,
  :filedAt,
  :firstRegistration,
  :firstTxDate,
  :form,
  :formType,
  :frame,
  :fundType,
  :generatedId,
  :impliedPrice,
  :industryGroup,
  :insiderName,
  :insiderTitle,
  :insiders,
  :investorsCount,
  :isAmendment,
  :issuer,
  :issuerCik,
  :issuerName,
  :items,
  :latestFiledAt,
  :latestTxDate,
  :license,
  :listed,
  :manager,
  :market,
  :meta,
  :minimumInvestment,
  :mod,
  :naicsCode,
  :name,
  :netIncome,
  :noteType,
  :offeringAmount,
  :percentOfClass,
  :personName,
  :personType,
  :price,
  :priceNote,
  :pricePerShare,
  :pricingDate,
  :principalUsd,
  :quantity,
  :recipientName,
  :relationship,
  :reportingCik,
  :reportingPerson,
  :revenue,
  :revenueRange,
  :securityClass,
  :securityName,
  :securityTypes,
  :settlementDate,
  :shares,
  :sharesOwned,
  :shortExemptVolume,
  :shortQty,
  :shortRatio,
  :shortVolume,
  :slug,
  :source,
  :state,
  :status,
  :symbol,
  :ticker,
  :totalAmountSold,
  :totalOfferingAmount,
  :totalVolume,
  :trades,
  :txDate,
  :underlyings,
  :units,
  :unitsOutstanding,
  :unitsReliable,
  :unitsToSell,
  :updatedAt,
  :url,
  :valueUsd,
  keyword_init: true
)

# Request payload for Company#load.
#
# @!attribute [rw] slug
#   @return [String]
CompanyLoadMatch = Struct.new(
  :slug,
  keyword_init: true
)

# Request payload for Company#list.
#
# @!attribute [rw] accessionNo
#   @return [Object, nil]
#
# @!attribute [rw] actionDate
#   @return [String, nil]
#
# @!attribute [rw] actionType
#   @return [Object, nil]
#
# @!attribute [rw] aggregateMarketValue
#   @return [Object, nil]
#
# @!attribute [rw] amendmentNo
#   @return [Object, nil]
#
# @!attribute [rw] amountUsd
#   @return [Float, nil]
#
# @!attribute [rw] approxSaleDate
#   @return [Object, nil]
#
# @!attribute [rw] asOf
#   @return [Object, nil]
#
# @!attribute [rw] attribution
#   @return [String, nil]
#
# @!attribute [rw] avgDailyVol
#   @return [Object, nil]
#
# @!attribute [rw] awardId
#   @return [String, nil]
#
# @!attribute [rw] awardType
#   @return [Object, nil]
#
# @!attribute [rw] awardingAgency
#   @return [Object, nil]
#
# @!attribute [rw] awardingSubAgency
#   @return [Object, nil]
#
# @!attribute [rw] barrierPct
#   @return [Object, nil]
#
# @!attribute [rw] basis
#   @return [Object, nil]
#
# @!attribute [rw] broker
#   @return [Object, nil]
#
# @!attribute [rw] buybacks
#   @return [Float, nil]
#
# @!attribute [rw] buyers
#   @return [Array, nil]
#
# @!attribute [rw] canonicalUrl
#   @return [String, nil]
#
# @!attribute [rw] capPct
#   @return [Object, nil]
#
# @!attribute [rw] changePct
#   @return [Object, nil]
#
# @!attribute [rw] cik
#   @return [String, nil]
#
# @!attribute [rw] company
#   @return [String, nil]
#
# @!attribute [rw] companyName
#   @return [String, nil]
#
# @!attribute [rw] costUsd
#   @return [Object, nil]
#
# @!attribute [rw] coupon
#   @return [Object, nil]
#
# @!attribute [rw] cusip
#   @return [String, nil]
#
# @!attribute [rw] data
#   @return [Hash, nil]
#
# @!attribute [rw] date
#   @return [String, nil]
#
# @!attribute [rw] dateOfFirstSale
#   @return [Object, nil]
#
# @!attribute [rw] daysToCover
#   @return [Object, nil]
#
# @!attribute [rw] description
#   @return [Object, nil]
#
# @!attribute [rw] docUrl
#   @return [String, nil]
#
# @!attribute [rw] docs
#   @return [String, nil]
#
# @!attribute [rw] end
#   @return [String, nil]
#
# @!attribute [rw] entityType
#   @return [Object, nil]
#
# @!attribute [rw] eventDate
#   @return [Object, nil]
#
# @!attribute [rw] eventLabels
#   @return [Object, nil]
#
# @!attribute [rw] exchange
#   @return [Object, nil]
#
# @!attribute [rw] exemptions
#   @return [Object, nil]
#
# @!attribute [rw] fairValueUsd
#   @return [Object, nil]
#
# @!attribute [rw] filedAt
#   @return [String, nil]
#
# @!attribute [rw] firstRegistration
#   @return [Object, nil]
#
# @!attribute [rw] firstTxDate
#   @return [String, nil]
#
# @!attribute [rw] form
#   @return [Object, nil]
#
# @!attribute [rw] formType
#   @return [String, nil]
#
# @!attribute [rw] frame
#   @return [String, nil]
#
# @!attribute [rw] fundType
#   @return [Object, nil]
#
# @!attribute [rw] generatedId
#   @return [Object, nil]
#
# @!attribute [rw] impliedPrice
#   @return [Object, nil]
#
# @!attribute [rw] industryGroup
#   @return [Object, nil]
#
# @!attribute [rw] insiderName
#   @return [String, nil]
#
# @!attribute [rw] insiderTitle
#   @return [Object, nil]
#
# @!attribute [rw] insiders
#   @return [Float, nil]
#
# @!attribute [rw] investorsCount
#   @return [Object, nil]
#
# @!attribute [rw] isAmendment
#   @return [Boolean, nil]
#
# @!attribute [rw] issuer
#   @return [String, nil]
#
# @!attribute [rw] issuerCik
#   @return [Object, nil]
#
# @!attribute [rw] issuerName
#   @return [String, nil]
#
# @!attribute [rw] items
#   @return [Object, nil]
#
# @!attribute [rw] latestFiledAt
#   @return [Object, nil]
#
# @!attribute [rw] latestTxDate
#   @return [String, nil]
#
# @!attribute [rw] license
#   @return [String, nil]
#
# @!attribute [rw] listed
#   @return [Boolean, nil]
#
# @!attribute [rw] manager
#   @return [String, nil]
#
# @!attribute [rw] market
#   @return [String, nil]
#
# @!attribute [rw] meta
#   @return [Hash, nil]
#
# @!attribute [rw] minimumInvestment
#   @return [Object, nil]
#
# @!attribute [rw] mod
#   @return [Object, nil]
#
# @!attribute [rw] naicsCode
#   @return [Object, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] netIncome
#   @return [Object, nil]
#
# @!attribute [rw] noteType
#   @return [Object, nil]
#
# @!attribute [rw] offeringAmount
#   @return [Object, nil]
#
# @!attribute [rw] percentOfClass
#   @return [Object, nil]
#
# @!attribute [rw] personName
#   @return [String, nil]
#
# @!attribute [rw] personType
#   @return [Object, nil]
#
# @!attribute [rw] price
#   @return [Object, nil]
#
# @!attribute [rw] priceNote
#   @return [Object, nil]
#
# @!attribute [rw] pricePerShare
#   @return [Object, nil]
#
# @!attribute [rw] pricingDate
#   @return [Object, nil]
#
# @!attribute [rw] principalUsd
#   @return [Object, nil]
#
# @!attribute [rw] quantity
#   @return [Float, nil]
#
# @!attribute [rw] recipientName
#   @return [String, nil]
#
# @!attribute [rw] relationship
#   @return [Object, nil]
#
# @!attribute [rw] reportingCik
#   @return [Object, nil]
#
# @!attribute [rw] reportingPerson
#   @return [String, nil]
#
# @!attribute [rw] revenue
#   @return [Object, nil]
#
# @!attribute [rw] revenueRange
#   @return [Object, nil]
#
# @!attribute [rw] securityClass
#   @return [Object, nil]
#
# @!attribute [rw] securityName
#   @return [Object, nil]
#
# @!attribute [rw] securityTypes
#   @return [Object, nil]
#
# @!attribute [rw] settlementDate
#   @return [String, nil]
#
# @!attribute [rw] shares
#   @return [Object, nil]
#
# @!attribute [rw] sharesOwned
#   @return [Object, nil]
#
# @!attribute [rw] shortExemptVolume
#   @return [Object, nil]
#
# @!attribute [rw] shortQty
#   @return [Object, nil]
#
# @!attribute [rw] shortRatio
#   @return [Object, nil]
#
# @!attribute [rw] shortVolume
#   @return [Float, nil]
#
# @!attribute [rw] slug
#   @return [String, nil]
#
# @!attribute [rw] source
#   @return [String, nil]
#
# @!attribute [rw] state
#   @return [Object, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
#
# @!attribute [rw] symbol
#   @return [Object, nil]
#
# @!attribute [rw] ticker
#   @return [String, nil]
#
# @!attribute [rw] totalAmountSold
#   @return [Object, nil]
#
# @!attribute [rw] totalOfferingAmount
#   @return [Object, nil]
#
# @!attribute [rw] totalVolume
#   @return [Float, nil]
#
# @!attribute [rw] trades
#   @return [Float, nil]
#
# @!attribute [rw] txDate
#   @return [String, nil]
#
# @!attribute [rw] underlyings
#   @return [Object, nil]
#
# @!attribute [rw] units
#   @return [Object, nil]
#
# @!attribute [rw] unitsOutstanding
#   @return [Object, nil]
#
# @!attribute [rw] unitsReliable
#   @return [Boolean, nil]
#
# @!attribute [rw] unitsToSell
#   @return [Object, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
#
# @!attribute [rw] valueUsd
#   @return [Object, nil]
CompanyListMatch = Struct.new(
  :accessionNo,
  :actionDate,
  :actionType,
  :aggregateMarketValue,
  :amendmentNo,
  :amountUsd,
  :approxSaleDate,
  :asOf,
  :attribution,
  :avgDailyVol,
  :awardId,
  :awardType,
  :awardingAgency,
  :awardingSubAgency,
  :barrierPct,
  :basis,
  :broker,
  :buybacks,
  :buyers,
  :canonicalUrl,
  :capPct,
  :changePct,
  :cik,
  :company,
  :companyName,
  :costUsd,
  :coupon,
  :cusip,
  :data,
  :date,
  :dateOfFirstSale,
  :daysToCover,
  :description,
  :docUrl,
  :docs,
  :end,
  :entityType,
  :eventDate,
  :eventLabels,
  :exchange,
  :exemptions,
  :fairValueUsd,
  :filedAt,
  :firstRegistration,
  :firstTxDate,
  :form,
  :formType,
  :frame,
  :fundType,
  :generatedId,
  :impliedPrice,
  :industryGroup,
  :insiderName,
  :insiderTitle,
  :insiders,
  :investorsCount,
  :isAmendment,
  :issuer,
  :issuerCik,
  :issuerName,
  :items,
  :latestFiledAt,
  :latestTxDate,
  :license,
  :listed,
  :manager,
  :market,
  :meta,
  :minimumInvestment,
  :mod,
  :naicsCode,
  :name,
  :netIncome,
  :noteType,
  :offeringAmount,
  :percentOfClass,
  :personName,
  :personType,
  :price,
  :priceNote,
  :pricePerShare,
  :pricingDate,
  :principalUsd,
  :quantity,
  :recipientName,
  :relationship,
  :reportingCik,
  :reportingPerson,
  :revenue,
  :revenueRange,
  :securityClass,
  :securityName,
  :securityTypes,
  :settlementDate,
  :shares,
  :sharesOwned,
  :shortExemptVolume,
  :shortQty,
  :shortRatio,
  :shortVolume,
  :slug,
  :source,
  :state,
  :status,
  :symbol,
  :ticker,
  :totalAmountSold,
  :totalOfferingAmount,
  :totalVolume,
  :trades,
  :txDate,
  :underlyings,
  :units,
  :unitsOutstanding,
  :unitsReliable,
  :unitsToSell,
  :updatedAt,
  :url,
  :valueUsd,
  keyword_init: true
)

# Crypto entity data model.
#
# @!attribute [rw] asset
#   @return [String, nil]
#
# @!attribute [rw] attribution
#   @return [String, nil]
#
# @!attribute [rw] aumUsd
#   @return [Object, nil]
#
# @!attribute [rw] baseAsset
#   @return [String, nil]
#
# @!attribute [rw] binanceSymbol
#   @return [Object, nil]
#
# @!attribute [rw] bitmexSymbol
#   @return [Object, nil]
#
# @!attribute [rw] bybitSymbol
#   @return [Object, nil]
#
# @!attribute [rw] canonicalUrl
#   @return [String, nil]
#
# @!attribute [rw] count
#   @return [Float, nil]
#
# @!attribute [rw] data
#   @return [Hash, nil]
#
# @!attribute [rw] date
#   @return [String, nil]
#
# @!attribute [rw] docs
#   @return [String, nil]
#
# @!attribute [rw] exchange
#   @return [String, nil]
#
# @!attribute [rw] flowUsd
#   @return [Object, nil]
#
# @!attribute [rw] fundingAnnualized
#   @return [Object, nil]
#
# @!attribute [rw] fundingIntervalHours
#   @return [Float, nil]
#
# @!attribute [rw] fundingRate
#   @return [Object, nil]
#
# @!attribute [rw] fundingRate8h
#   @return [Object, nil]
#
# @!attribute [rw] holdings
#   @return [Object, nil]
#
# @!attribute [rw] hour
#   @return [String, nil]
#
# @!attribute [rw] hyperliquidCoin
#   @return [Object, nil]
#
# @!attribute [rw] id
#   @return [Float, nil]
#
# @!attribute [rw] issuer
#   @return [String, nil]
#
# @!attribute [rw] krakenSymbol
#   @return [Object, nil]
#
# @!attribute [rw] license
#   @return [String, nil]
#
# @!attribute [rw] longShortRatio
#   @return [Object, nil]
#
# @!attribute [rw] longUsd
#   @return [Float, nil]
#
# @!attribute [rw] markPrice
#   @return [Object, nil]
#
# @!attribute [rw] maxSingleUsd
#   @return [Float, nil]
#
# @!attribute [rw] meta
#   @return [Hash, nil]
#
# @!attribute [rw] nextFundingTime
#   @return [Object, nil]
#
# @!attribute [rw] okxInstId
#   @return [Object, nil]
#
# @!attribute [rw] openInterest
#   @return [Object, nil]
#
# @!attribute [rw] openInterestValue
#   @return [Object, nil]
#
# @!attribute [rw] price
#   @return [String, nil]
#
# @!attribute [rw] priceChangePct24h
#   @return [Object, nil]
#
# @!attribute [rw] qty
#   @return [String, nil]
#
# @!attribute [rw] rawSymbol
#   @return [String, nil]
#
# @!attribute [rw] shortUsd
#   @return [Float, nil]
#
# @!attribute [rw] side
#   @return [String, nil]
#
# @!attribute [rw] slug
#   @return [String, nil]
#
# @!attribute [rw] source
#   @return [String, nil]
#
# @!attribute [rw] symbol
#   @return [String, nil]
#
# @!attribute [rw] ticker
#   @return [String, nil]
#
# @!attribute [rw] totalUsd
#   @return [Float, nil]
#
# @!attribute [rw] ts
#   @return [String, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
#
# @!attribute [rw] usdValue
#   @return [String, nil]
Crypto = Struct.new(
  :asset,
  :attribution,
  :aumUsd,
  :baseAsset,
  :binanceSymbol,
  :bitmexSymbol,
  :bybitSymbol,
  :canonicalUrl,
  :count,
  :data,
  :date,
  :docs,
  :exchange,
  :flowUsd,
  :fundingAnnualized,
  :fundingIntervalHours,
  :fundingRate,
  :fundingRate8h,
  :holdings,
  :hour,
  :hyperliquidCoin,
  :id,
  :issuer,
  :krakenSymbol,
  :license,
  :longShortRatio,
  :longUsd,
  :markPrice,
  :maxSingleUsd,
  :meta,
  :nextFundingTime,
  :okxInstId,
  :openInterest,
  :openInterestValue,
  :price,
  :priceChangePct24h,
  :qty,
  :rawSymbol,
  :shortUsd,
  :side,
  :slug,
  :source,
  :symbol,
  :ticker,
  :totalUsd,
  :ts,
  :updatedAt,
  :usdValue,
  keyword_init: true
)

# Request payload for Crypto#load.
#
# @!attribute [rw] coin
#   @return [String]
CryptoLoadMatch = Struct.new(
  :coin,
  keyword_init: true
)

# Request payload for Crypto#list.
#
# @!attribute [rw] asset
#   @return [String, nil]
#
# @!attribute [rw] day
#   @return [Integer, nil]
CryptoListMatch = Struct.new(
  :asset,
  :day,
  keyword_init: true
)

# Macro entity data model.
#
# @!attribute [rw] actual
#   @return [Object, nil]
#
# @!attribute [rw] assetMgrLong
#   @return [Object, nil]
#
# @!attribute [rw] assetMgrShort
#   @return [Object, nil]
#
# @!attribute [rw] assets
#   @return [Float, nil]
#
# @!attribute [rw] attribution
#   @return [String, nil]
#
# @!attribute [rw] auctionDate
#   @return [String, nil]
#
# @!attribute [rw] bidToCover
#   @return [Object, nil]
#
# @!attribute [rw] canonicalUrl
#   @return [String, nil]
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] countryCode
#   @return [String, nil]
#
# @!attribute [rw] cusip
#   @return [String, nil]
#
# @!attribute [rw] data
#   @return [Array, nil]
#
# @!attribute [rw] date
#   @return [String, nil]
#
# @!attribute [rw] dealerAccepted
#   @return [Object, nil]
#
# @!attribute [rw] dealerLong
#   @return [Object, nil]
#
# @!attribute [rw] dealerShare
#   @return [Object, nil]
#
# @!attribute [rw] dealerShort
#   @return [Object, nil]
#
# @!attribute [rw] directAccepted
#   @return [Object, nil]
#
# @!attribute [rw] directShare
#   @return [Object, nil]
#
# @!attribute [rw] docs
#   @return [String, nil]
#
# @!attribute [rw] eventName
#   @return [String, nil]
#
# @!attribute [rw] forecast
#   @return [Object, nil]
#
# @!attribute [rw] group
#   @return [String, nil]
#
# @!attribute [rw] highRate
#   @return [Object, nil]
#
# @!attribute [rw] highYield
#   @return [Object, nil]
#
# @!attribute [rw] importance
#   @return [String, nil]
#
# @!attribute [rw] indirectAccepted
#   @return [Object, nil]
#
# @!attribute [rw] indirectShare
#   @return [Object, nil]
#
# @!attribute [rw] interestRate
#   @return [Object, nil]
#
# @!attribute [rw] issueDate
#   @return [Object, nil]
#
# @!attribute [rw] lastChanged
#   @return [Object, nil]
#
# @!attribute [rw] levFundLong
#   @return [Object, nil]
#
# @!attribute [rw] levFundShort
#   @return [Object, nil]
#
# @!attribute [rw] license
#   @return [String, nil]
#
# @!attribute [rw] m1_m6
#   @return [Object, nil]
#
# @!attribute [rw] maturityDate
#   @return [Object, nil]
#
# @!attribute [rw] meta
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] net
#   @return [Float, nil]
#
# @!attribute [rw] nonreptLong
#   @return [Object, nil]
#
# @!attribute [rw] nonreptShort
#   @return [Object, nil]
#
# @!attribute [rw] offeringAmount
#   @return [Object, nil]
#
# @!attribute [rw] openInterest
#   @return [Object, nil]
#
# @!attribute [rw] otherLong
#   @return [Object, nil]
#
# @!attribute [rw] otherShort
#   @return [Object, nil]
#
# @!attribute [rw] periodLabel
#   @return [Object, nil]
#
# @!attribute [rw] previous
#   @return [Object, nil]
#
# @!attribute [rw] rate
#   @return [String, nil]
#
# @!attribute [rw] reopening
#   @return [Object, nil]
#
# @!attribute [rw] reportDate
#   @return [String, nil]
#
# @!attribute [rw] reportType
#   @return [String, nil]
#
# @!attribute [rw] reserves
#   @return [Object, nil]
#
# @!attribute [rw] rrp
#   @return [Float, nil]
#
# @!attribute [rw] scheduledAt
#   @return [String, nil]
#
# @!attribute [rw] securityTerm
#   @return [String, nil]
#
# @!attribute [rw] securityType
#   @return [String, nil]
#
# @!attribute [rw] slug
#   @return [String, nil]
#
# @!attribute [rw] sortRank
#   @return [Float, nil]
#
# @!attribute [rw] source
#   @return [String, nil]
#
# @!attribute [rw] tga
#   @return [Float, nil]
#
# @!attribute [rw] totalAccepted
#   @return [Object, nil]
#
# @!attribute [rw] totalTendered
#   @return [Object, nil]
#
# @!attribute [rw] unit
#   @return [Object, nil]
#
# @!attribute [rw] updatedAt
#   @return [String, nil]
#
# @!attribute [rw] y1_y30
#   @return [Object, nil]
Macro = Struct.new(
  :actual,
  :assetMgrLong,
  :assetMgrShort,
  :assets,
  :attribution,
  :auctionDate,
  :bidToCover,
  :canonicalUrl,
  :country,
  :countryCode,
  :cusip,
  :data,
  :date,
  :dealerAccepted,
  :dealerLong,
  :dealerShare,
  :dealerShort,
  :directAccepted,
  :directShare,
  :docs,
  :eventName,
  :forecast,
  :group,
  :highRate,
  :highYield,
  :importance,
  :indirectAccepted,
  :indirectShare,
  :interestRate,
  :issueDate,
  :lastChanged,
  :levFundLong,
  :levFundShort,
  :license,
  :m1_m6,
  :maturityDate,
  :meta,
  :name,
  :net,
  :nonreptLong,
  :nonreptShort,
  :offeringAmount,
  :openInterest,
  :otherLong,
  :otherShort,
  :periodLabel,
  :previous,
  :rate,
  :reopening,
  :reportDate,
  :reportType,
  :reserves,
  :rrp,
  :scheduledAt,
  :securityTerm,
  :securityType,
  :slug,
  :sortRank,
  :source,
  :tga,
  :totalAccepted,
  :totalTendered,
  :unit,
  :updatedAt,
  :y1_y30,
  keyword_init: true
)

# Request payload for Macro#load.
#
# @!attribute [rw] country
#   @return [String]
#
# @!attribute [rw] from
#   @return [String, nil]
#
# @!attribute [rw] to
#   @return [String, nil]
MacroLoadMatch = Struct.new(
  :country,
  :from,
  :to,
  keyword_init: true
)

# Request payload for Macro#list.
#
# @!attribute [rw] from
#   @return [String, nil]
#
# @!attribute [rw] importance
#   @return [String, nil]
#
# @!attribute [rw] to
#   @return [String, nil]
MacroListMatch = Struct.new(
  :from,
  :importance,
  :to,
  keyword_init: true
)

