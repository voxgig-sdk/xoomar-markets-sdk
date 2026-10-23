// Typed models for the XoomarMarkets SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import (
	"encoding/json"

	"github.com/voxgig-sdk/xoomar-markets-sdk/go/core"
)

// Company is the typed data model for the company entity.
type Company struct {
}

// CompanyLoadMatch is the typed request payload for Company.LoadTyped.
type CompanyLoadMatch struct {
	Slug string `json:"slug"`
}

// CompanyListMatch is the typed request payload for Company.ListTyped.
type CompanyListMatch struct {
	AccessionNo *any `json:"accessionNo,omitempty"`
	ActionDate *string `json:"actionDate,omitempty"`
	ActionType *any `json:"actionType,omitempty"`
	AggregateMarketValue *any `json:"aggregateMarketValue,omitempty"`
	AmendmentNo *any `json:"amendmentNo,omitempty"`
	AmountUsd *float64 `json:"amountUsd,omitempty"`
	ApproxSaleDate *any `json:"approxSaleDate,omitempty"`
	AsOf *any `json:"asOf,omitempty"`
	Attribution *string `json:"attribution,omitempty"`
	AvgDailyVol *any `json:"avgDailyVol,omitempty"`
	AwardId *string `json:"awardId,omitempty"`
	AwardType *any `json:"awardType,omitempty"`
	AwardingAgency *any `json:"awardingAgency,omitempty"`
	AwardingSubAgency *any `json:"awardingSubAgency,omitempty"`
	BarrierPct *any `json:"barrierPct,omitempty"`
	Basis *any `json:"basis,omitempty"`
	Broker *any `json:"broker,omitempty"`
	Buybacks *float64 `json:"buybacks,omitempty"`
	Buyers *[]any `json:"buyers,omitempty"`
	CanonicalUrl *string `json:"canonicalUrl,omitempty"`
	CapPct *any `json:"capPct,omitempty"`
	ChangePct *any `json:"changePct,omitempty"`
	Cik *string `json:"cik,omitempty"`
	Company *string `json:"company,omitempty"`
	CompanyName *string `json:"companyName,omitempty"`
	CostUsd *any `json:"costUsd,omitempty"`
	Coupon *any `json:"coupon,omitempty"`
	Cusip *string `json:"cusip,omitempty"`
	Data *map[string]any `json:"data,omitempty"`
	Date *string `json:"date,omitempty"`
	DateOfFirstSale *any `json:"dateOfFirstSale,omitempty"`
	DaysToCover *any `json:"daysToCover,omitempty"`
	Description *any `json:"description,omitempty"`
	DocUrl *string `json:"docUrl,omitempty"`
	Docs *string `json:"docs,omitempty"`
	End *string `json:"end,omitempty"`
	EntityType *any `json:"entityType,omitempty"`
	EventDate *any `json:"eventDate,omitempty"`
	EventLabels *any `json:"eventLabels,omitempty"`
	Exchange *any `json:"exchange,omitempty"`
	Exemptions *any `json:"exemptions,omitempty"`
	FairValueUsd *any `json:"fairValueUsd,omitempty"`
	FiledAt *string `json:"filedAt,omitempty"`
	FirstRegistration *any `json:"firstRegistration,omitempty"`
	FirstTxDate *string `json:"firstTxDate,omitempty"`
	Form *any `json:"form,omitempty"`
	FormType *string `json:"formType,omitempty"`
	Frame *string `json:"frame,omitempty"`
	FundType *any `json:"fundType,omitempty"`
	GeneratedId *any `json:"generatedId,omitempty"`
	ImpliedPrice *any `json:"impliedPrice,omitempty"`
	IndustryGroup *any `json:"industryGroup,omitempty"`
	InsiderName *string `json:"insiderName,omitempty"`
	InsiderTitle *any `json:"insiderTitle,omitempty"`
	Insiders *float64 `json:"insiders,omitempty"`
	InvestorsCount *any `json:"investorsCount,omitempty"`
	IsAmendment *bool `json:"isAmendment,omitempty"`
	Issuer *string `json:"issuer,omitempty"`
	IssuerCik *any `json:"issuerCik,omitempty"`
	IssuerName *string `json:"issuerName,omitempty"`
	Items *any `json:"items,omitempty"`
	LatestFiledAt *any `json:"latestFiledAt,omitempty"`
	LatestTxDate *string `json:"latestTxDate,omitempty"`
	License *string `json:"license,omitempty"`
	Listed *bool `json:"listed,omitempty"`
	Manager *string `json:"manager,omitempty"`
	Market *string `json:"market,omitempty"`
	Meta *map[string]any `json:"meta,omitempty"`
	MinimumInvestment *any `json:"minimumInvestment,omitempty"`
	Mod *any `json:"mod,omitempty"`
	NaicsCode *any `json:"naicsCode,omitempty"`
	Name *string `json:"name,omitempty"`
	NetIncome *any `json:"netIncome,omitempty"`
	NoteType *any `json:"noteType,omitempty"`
	OfferingAmount *any `json:"offeringAmount,omitempty"`
	PercentOfClass *any `json:"percentOfClass,omitempty"`
	PersonName *string `json:"personName,omitempty"`
	PersonType *any `json:"personType,omitempty"`
	Price *any `json:"price,omitempty"`
	PriceNote *any `json:"priceNote,omitempty"`
	PricePerShare *any `json:"pricePerShare,omitempty"`
	PricingDate *any `json:"pricingDate,omitempty"`
	PrincipalUsd *any `json:"principalUsd,omitempty"`
	Quantity *float64 `json:"quantity,omitempty"`
	RecipientName *string `json:"recipientName,omitempty"`
	Relationship *any `json:"relationship,omitempty"`
	ReportingCik *any `json:"reportingCik,omitempty"`
	ReportingPerson *string `json:"reportingPerson,omitempty"`
	Revenue *any `json:"revenue,omitempty"`
	RevenueRange *any `json:"revenueRange,omitempty"`
	SecurityClass *any `json:"securityClass,omitempty"`
	SecurityName *any `json:"securityName,omitempty"`
	SecurityTypes *any `json:"securityTypes,omitempty"`
	SettlementDate *string `json:"settlementDate,omitempty"`
	Shares *any `json:"shares,omitempty"`
	SharesOwned *any `json:"sharesOwned,omitempty"`
	ShortExemptVolume *any `json:"shortExemptVolume,omitempty"`
	ShortQty *any `json:"shortQty,omitempty"`
	ShortRatio *any `json:"shortRatio,omitempty"`
	ShortVolume *float64 `json:"shortVolume,omitempty"`
	Slug *string `json:"slug,omitempty"`
	Source *string `json:"source,omitempty"`
	State *any `json:"state,omitempty"`
	Status *string `json:"status,omitempty"`
	Symbol *any `json:"symbol,omitempty"`
	Ticker *string `json:"ticker,omitempty"`
	TotalAmountSold *any `json:"totalAmountSold,omitempty"`
	TotalOfferingAmount *any `json:"totalOfferingAmount,omitempty"`
	TotalVolume *float64 `json:"totalVolume,omitempty"`
	Trades *float64 `json:"trades,omitempty"`
	TxDate *string `json:"txDate,omitempty"`
	Underlyings *any `json:"underlyings,omitempty"`
	Units *any `json:"units,omitempty"`
	UnitsOutstanding *any `json:"unitsOutstanding,omitempty"`
	UnitsReliable *bool `json:"unitsReliable,omitempty"`
	UnitsToSell *any `json:"unitsToSell,omitempty"`
	UpdatedAt *string `json:"updatedAt,omitempty"`
	Url *string `json:"url,omitempty"`
	ValueUsd *any `json:"valueUsd,omitempty"`
}

// Crypto is the typed data model for the crypto entity.
type Crypto struct {
}

// CryptoLoadMatch is the typed request payload for Crypto.LoadTyped.
type CryptoLoadMatch struct {
	Coin string `json:"coin"`
}

// CryptoListMatch is the typed request payload for Crypto.ListTyped.
type CryptoListMatch struct {
	Asset *string `json:"asset,omitempty"`
	Day *int `json:"day,omitempty"`
}

// Macro is the typed data model for the macro entity.
type Macro struct {
}

// MacroLoadMatch is the typed request payload for Macro.LoadTyped.
type MacroLoadMatch struct {
	Country string `json:"country"`
	From *string `json:"from,omitempty"`
	To *string `json:"to,omitempty"`
}

// MacroListMatch is the typed request payload for Macro.ListTyped.
type MacroListMatch struct {
	From *string `json:"from,omitempty"`
	Importance *string `json:"importance,omitempty"`
	To *string `json:"to,omitempty"`
}

// asMap turns a typed request/data struct into the map[string]any the
// runtime op pipeline consumes, honouring the json tags above.
func asMap(v any) map[string]any {
	out := map[string]any{}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// entityData unwraps an entity to its data map.
//
// Operations resolve to the ENTITY, not the raw data (see AGENTS.md), and an
// entity's fields are UNEXPORTED — marshalling one directly yields `{}`, so
// every typed accessor would silently hand back a zero-valued struct. The
// typed boundary therefore takes the data hop first.
func entityData(v any) any {
	if ent, ok := v.(core.Entity); ok {
		return ent.Data()
	}
	return v
}

// typedFrom decodes a runtime value (an entity, or the map[string]any the op
// pipeline produced) into a typed model T via a JSON round-trip. On any error
// it returns the zero value of T; the op's own (value, error) tuple carries
// the real error.
func typedFrom[T any](v any) T {
	var out T
	v = entityData(v)
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedSliceFrom decodes a runtime list value into a typed slice []T via a
// JSON round-trip, for list ops. `list` resolves to a slice of ENTITY
// instances, so each element takes the data hop.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	if list, ok := v.([]any); ok {
		unwrapped := make([]any, 0, len(list))
		for _, item := range list {
			unwrapped = append(unwrapped, entityData(item))
		}
		v = unwrapped
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
