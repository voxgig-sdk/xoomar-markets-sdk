<?php
declare(strict_types=1);

// Typed models for the XoomarMarkets SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Company entity data model. */
class Company
{
    public mixed $accessionNo = null;
    public ?string $actionDate = null;
    public mixed $actionType = null;
    public mixed $aggregateMarketValue = null;
    public mixed $amendmentNo = null;
    public ?float $amountUsd = null;
    public mixed $approxSaleDate = null;
    public mixed $asOf = null;
    public ?string $attribution = null;
    public mixed $avgDailyVol = null;
    public ?string $awardId = null;
    public mixed $awardType = null;
    public mixed $awardingAgency = null;
    public mixed $awardingSubAgency = null;
    public mixed $barrierPct = null;
    public mixed $basis = null;
    public mixed $broker = null;
    public ?float $buybacks = null;
    public ?array $buyers = null;
    public ?string $canonicalUrl = null;
    public mixed $capPct = null;
    public mixed $changePct = null;
    public ?string $cik = null;
    public ?string $company = null;
    public ?string $companyName = null;
    public mixed $costUsd = null;
    public mixed $coupon = null;
    public ?string $cusip = null;
    public ?array $data = null;
    public ?string $date = null;
    public mixed $dateOfFirstSale = null;
    public mixed $daysToCover = null;
    public mixed $description = null;
    public ?string $docUrl = null;
    public ?string $docs = null;
    public ?string $end = null;
    public mixed $entityType = null;
    public mixed $eventDate = null;
    public mixed $eventLabels = null;
    public mixed $exchange = null;
    public mixed $exemptions = null;
    public mixed $fairValueUsd = null;
    public ?string $filedAt = null;
    public mixed $firstRegistration = null;
    public ?string $firstTxDate = null;
    public mixed $form = null;
    public ?string $formType = null;
    public ?string $frame = null;
    public mixed $fundType = null;
    public mixed $generatedId = null;
    public mixed $impliedPrice = null;
    public mixed $industryGroup = null;
    public ?string $insiderName = null;
    public mixed $insiderTitle = null;
    public ?float $insiders = null;
    public mixed $investorsCount = null;
    public ?bool $isAmendment = null;
    public ?string $issuer = null;
    public mixed $issuerCik = null;
    public ?string $issuerName = null;
    public mixed $items = null;
    public mixed $latestFiledAt = null;
    public ?string $latestTxDate = null;
    public ?string $license = null;
    public ?bool $listed = null;
    public ?string $manager = null;
    public ?string $market = null;
    public ?array $meta = null;
    public mixed $minimumInvestment = null;
    public mixed $mod = null;
    public mixed $naicsCode = null;
    public ?string $name = null;
    public mixed $netIncome = null;
    public mixed $noteType = null;
    public mixed $offeringAmount = null;
    public mixed $percentOfClass = null;
    public ?string $personName = null;
    public mixed $personType = null;
    public mixed $price = null;
    public mixed $priceNote = null;
    public mixed $pricePerShare = null;
    public mixed $pricingDate = null;
    public mixed $principalUsd = null;
    public ?float $quantity = null;
    public ?string $recipientName = null;
    public mixed $relationship = null;
    public mixed $reportingCik = null;
    public ?string $reportingPerson = null;
    public mixed $revenue = null;
    public mixed $revenueRange = null;
    public mixed $securityClass = null;
    public mixed $securityName = null;
    public mixed $securityTypes = null;
    public ?string $settlementDate = null;
    public mixed $shares = null;
    public mixed $sharesOwned = null;
    public mixed $shortExemptVolume = null;
    public mixed $shortQty = null;
    public mixed $shortRatio = null;
    public ?float $shortVolume = null;
    public ?string $slug = null;
    public ?string $source = null;
    public mixed $state = null;
    public ?string $status = null;
    public mixed $symbol = null;
    public ?string $ticker = null;
    public mixed $totalAmountSold = null;
    public mixed $totalOfferingAmount = null;
    public ?float $totalVolume = null;
    public ?float $trades = null;
    public ?string $txDate = null;
    public mixed $underlyings = null;
    public mixed $units = null;
    public mixed $unitsOutstanding = null;
    public ?bool $unitsReliable = null;
    public mixed $unitsToSell = null;
    public ?string $updatedAt = null;
    public ?string $url = null;
    public mixed $valueUsd = null;
}

/** Request payload for Company#load. */
class CompanyLoadMatch
{
    public string $slug;
}

/** Request payload for Company#list. */
class CompanyListMatch
{
    public mixed $accessionNo = null;
    public ?string $actionDate = null;
    public mixed $actionType = null;
    public mixed $aggregateMarketValue = null;
    public mixed $amendmentNo = null;
    public ?float $amountUsd = null;
    public mixed $approxSaleDate = null;
    public mixed $asOf = null;
    public ?string $attribution = null;
    public mixed $avgDailyVol = null;
    public ?string $awardId = null;
    public mixed $awardType = null;
    public mixed $awardingAgency = null;
    public mixed $awardingSubAgency = null;
    public mixed $barrierPct = null;
    public mixed $basis = null;
    public mixed $broker = null;
    public ?float $buybacks = null;
    public ?array $buyers = null;
    public ?string $canonicalUrl = null;
    public mixed $capPct = null;
    public mixed $changePct = null;
    public ?string $cik = null;
    public ?string $company = null;
    public ?string $companyName = null;
    public mixed $costUsd = null;
    public mixed $coupon = null;
    public ?string $cusip = null;
    public ?array $data = null;
    public ?string $date = null;
    public mixed $dateOfFirstSale = null;
    public mixed $daysToCover = null;
    public mixed $description = null;
    public ?string $docUrl = null;
    public ?string $docs = null;
    public ?string $end = null;
    public mixed $entityType = null;
    public mixed $eventDate = null;
    public mixed $eventLabels = null;
    public mixed $exchange = null;
    public mixed $exemptions = null;
    public mixed $fairValueUsd = null;
    public ?string $filedAt = null;
    public mixed $firstRegistration = null;
    public ?string $firstTxDate = null;
    public mixed $form = null;
    public ?string $formType = null;
    public ?string $frame = null;
    public mixed $fundType = null;
    public mixed $generatedId = null;
    public mixed $impliedPrice = null;
    public mixed $industryGroup = null;
    public ?string $insiderName = null;
    public mixed $insiderTitle = null;
    public ?float $insiders = null;
    public mixed $investorsCount = null;
    public ?bool $isAmendment = null;
    public ?string $issuer = null;
    public mixed $issuerCik = null;
    public ?string $issuerName = null;
    public mixed $items = null;
    public mixed $latestFiledAt = null;
    public ?string $latestTxDate = null;
    public ?string $license = null;
    public ?bool $listed = null;
    public ?string $manager = null;
    public ?string $market = null;
    public ?array $meta = null;
    public mixed $minimumInvestment = null;
    public mixed $mod = null;
    public mixed $naicsCode = null;
    public ?string $name = null;
    public mixed $netIncome = null;
    public mixed $noteType = null;
    public mixed $offeringAmount = null;
    public mixed $percentOfClass = null;
    public ?string $personName = null;
    public mixed $personType = null;
    public mixed $price = null;
    public mixed $priceNote = null;
    public mixed $pricePerShare = null;
    public mixed $pricingDate = null;
    public mixed $principalUsd = null;
    public ?float $quantity = null;
    public ?string $recipientName = null;
    public mixed $relationship = null;
    public mixed $reportingCik = null;
    public ?string $reportingPerson = null;
    public mixed $revenue = null;
    public mixed $revenueRange = null;
    public mixed $securityClass = null;
    public mixed $securityName = null;
    public mixed $securityTypes = null;
    public ?string $settlementDate = null;
    public mixed $shares = null;
    public mixed $sharesOwned = null;
    public mixed $shortExemptVolume = null;
    public mixed $shortQty = null;
    public mixed $shortRatio = null;
    public ?float $shortVolume = null;
    public ?string $slug = null;
    public ?string $source = null;
    public mixed $state = null;
    public ?string $status = null;
    public mixed $symbol = null;
    public ?string $ticker = null;
    public mixed $totalAmountSold = null;
    public mixed $totalOfferingAmount = null;
    public ?float $totalVolume = null;
    public ?float $trades = null;
    public ?string $txDate = null;
    public mixed $underlyings = null;
    public mixed $units = null;
    public mixed $unitsOutstanding = null;
    public ?bool $unitsReliable = null;
    public mixed $unitsToSell = null;
    public ?string $updatedAt = null;
    public ?string $url = null;
    public mixed $valueUsd = null;
}

/** Crypto entity data model. */
class Crypto
{
    public ?string $asset = null;
    public ?string $attribution = null;
    public mixed $aumUsd = null;
    public ?string $baseAsset = null;
    public mixed $binanceSymbol = null;
    public mixed $bitmexSymbol = null;
    public mixed $bybitSymbol = null;
    public ?string $canonicalUrl = null;
    public ?float $count = null;
    public ?array $data = null;
    public ?string $date = null;
    public ?string $docs = null;
    public ?string $exchange = null;
    public mixed $flowUsd = null;
    public mixed $fundingAnnualized = null;
    public ?float $fundingIntervalHours = null;
    public mixed $fundingRate = null;
    public mixed $fundingRate8h = null;
    public mixed $holdings = null;
    public ?string $hour = null;
    public mixed $hyperliquidCoin = null;
    public ?float $id = null;
    public ?string $issuer = null;
    public mixed $krakenSymbol = null;
    public ?string $license = null;
    public mixed $longShortRatio = null;
    public ?float $longUsd = null;
    public mixed $markPrice = null;
    public ?float $maxSingleUsd = null;
    public ?array $meta = null;
    public mixed $nextFundingTime = null;
    public mixed $okxInstId = null;
    public mixed $openInterest = null;
    public mixed $openInterestValue = null;
    public ?string $price = null;
    public mixed $priceChangePct24h = null;
    public ?string $qty = null;
    public ?string $rawSymbol = null;
    public ?float $shortUsd = null;
    public ?string $side = null;
    public ?string $slug = null;
    public ?string $source = null;
    public ?string $symbol = null;
    public ?string $ticker = null;
    public ?float $totalUsd = null;
    public ?string $ts = null;
    public ?string $updatedAt = null;
    public ?string $usdValue = null;
}

/** Request payload for Crypto#load. */
class CryptoLoadMatch
{
    public string $coin;
}

/** Request payload for Crypto#list. */
class CryptoListMatch
{
    public ?string $asset = null;
    public ?int $day = null;
}

/** Macro entity data model. */
class Macro
{
    public mixed $actual = null;
    public mixed $assetMgrLong = null;
    public mixed $assetMgrShort = null;
    public ?float $assets = null;
    public ?string $attribution = null;
    public ?string $auctionDate = null;
    public mixed $bidToCover = null;
    public ?string $canonicalUrl = null;
    public ?string $country = null;
    public ?string $countryCode = null;
    public ?string $cusip = null;
    public ?array $data = null;
    public ?string $date = null;
    public mixed $dealerAccepted = null;
    public mixed $dealerLong = null;
    public mixed $dealerShare = null;
    public mixed $dealerShort = null;
    public mixed $directAccepted = null;
    public mixed $directShare = null;
    public ?string $docs = null;
    public ?string $eventName = null;
    public mixed $forecast = null;
    public ?string $group = null;
    public mixed $highRate = null;
    public mixed $highYield = null;
    public ?string $importance = null;
    public mixed $indirectAccepted = null;
    public mixed $indirectShare = null;
    public mixed $interestRate = null;
    public mixed $issueDate = null;
    public mixed $lastChanged = null;
    public mixed $levFundLong = null;
    public mixed $levFundShort = null;
    public ?string $license = null;
    public mixed $m1_m6 = null;
    public mixed $maturityDate = null;
    public ?array $meta = null;
    public ?string $name = null;
    public ?float $net = null;
    public mixed $nonreptLong = null;
    public mixed $nonreptShort = null;
    public mixed $offeringAmount = null;
    public mixed $openInterest = null;
    public mixed $otherLong = null;
    public mixed $otherShort = null;
    public mixed $periodLabel = null;
    public mixed $previous = null;
    public ?string $rate = null;
    public mixed $reopening = null;
    public ?string $reportDate = null;
    public ?string $reportType = null;
    public mixed $reserves = null;
    public ?float $rrp = null;
    public ?string $scheduledAt = null;
    public ?string $securityTerm = null;
    public ?string $securityType = null;
    public ?string $slug = null;
    public ?float $sortRank = null;
    public ?string $source = null;
    public ?float $tga = null;
    public mixed $totalAccepted = null;
    public mixed $totalTendered = null;
    public mixed $unit = null;
    public ?string $updatedAt = null;
    public mixed $y1_y30 = null;
}

/** Request payload for Macro#load. */
class MacroLoadMatch
{
    public string $country;
    public ?string $from = null;
    public ?string $to = null;
}

/** Request payload for Macro#list. */
class MacroListMatch
{
    public ?string $from = null;
    public ?string $importance = null;
    public ?string $to = null;
}

