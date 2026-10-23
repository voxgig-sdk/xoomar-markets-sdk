package core

import (
	"sync"
)

// MakeConfig builds a fresh, fully materialised config map. Every call
// rebuilds the whole structure, so prefer SharedConfig unless you need a
// private copy you intend to mutate.
func MakeConfig() map[string]any {
	return map[string]any{
		"main": map[string]any{
			"name": "XoomarMarkets",
			"slug": "xoomar-markets",
			"version": "0.0.1",
			"target": "go",
		},
		"feature": map[string]any{
			"ratelimit": map[string]any{
				"options": map[string]any{
					"active": false,
					"burst": 5,
					"rate": 5,
				},
				"optspec": map[string]any{
					"now": "`$FUNCTION`",
					"sleep": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"retry": map[string]any{
				"options": map[string]any{
					"active": false,
					"factor": 2,
					"maxDelay": 2000,
					"minDelay": 50,
					"retries": 2,
					"statuses": []any{
						408,
						425,
						429,
						500,
						502,
						503,
						504,
					},
				},
				"optspec": map[string]any{
					"jitter": "`$BOOLEAN`",
					"sleep": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"optspec": map[string]any{
					"entity": "`$MAP`",
					"net": "`$MAP`",
				},
				"strict": false,
				"transport": "base",
			},
			"timeout": map[string]any{
				"options": map[string]any{
					"active": false,
					"ms": 30000,
				},
				"optspec": map[string]any{
					"clearTimer": "`$FUNCTION`",
					"now": "`$FUNCTION`",
					"setTimer": "`$FUNCTION`",
				},
				"strict": false,
				"transport": "wrap",
			},
		},
		"options": map[string]any{
			"base": "https://xoomar.com",
			"auth": map[string]any{
				"prefix": "",
				"name": "x-api-key",
			},
			"headers": map[string]any{
				"content-type": "application/json",
			},
			"entity": map[string]any{
				"company": map[string]any{},
				"crypto": map[string]any{},
				"macro": map[string]any{},
			},
		},
		"entity": map[string]any{
			"company": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "accessionNo",
						"title": "Accession No",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "The filing's accession number for reported rows; null for estimates",
					},
					map[string]any{
						"name": "actionDate",
						"title": "Action Date",
						"type": "`$STRING`",
						"short": "Date the action was signed",
					},
					map[string]any{
						"name": "actionType",
						"title": "Action Type",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "FPDS action type code",
					},
					map[string]any{
						"name": "aggregateMarketValue",
						"title": "Aggregate Market Value",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Aggregate market value of the shares to be sold, USD",
					},
					map[string]any{
						"name": "amendmentNo",
						"title": "Amendment No",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Amendment number; null for the original filing",
					},
					map[string]any{
						"name": "amountUsd",
						"title": "Amount Usd",
						"type": "`$NUMBER`",
						"short": "Dollars obligated by this action; negative for de-obligations",
					},
					map[string]any{
						"name": "approxSaleDate",
						"title": "Approx Sale Date",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Approximate date of sale",
						"format": "date",
					},
					map[string]any{
						"name": "asOf",
						"title": "As Of",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Balance sheet date of the figures",
					},
					map[string]any{
						"name": "attribution",
						"title": "Attribution",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "avgDailyVol",
						"title": "Avg Daily Vol",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Average daily trading volume",
					},
					map[string]any{
						"name": "awardId",
						"title": "Award Id",
						"type": "`$STRING`",
						"short": "Contract or order number (PIID)",
					},
					map[string]any{
						"name": "awardType",
						"title": "Award Type",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Definitive contract, delivery order, BPA call, purchase order",
					},
					map[string]any{
						"name": "awardingAgency",
						"title": "Awarding Agency",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Awarding department and bureau",
					},
					map[string]any{
						"name": "awardingSubAgency",
						"title": "Awarding Sub Agency",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Awarding department and bureau",
					},
					map[string]any{
						"name": "barrierPct",
						"title": "Barrier Pct",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Barrier/threshold as % of initial level.",
					},
					map[string]any{
						"name": "basis",
						"title": "Basis",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Reference date for an estimated row; null for reported rows",
						"format": "date",
					},
					map[string]any{
						"name": "broker",
						"title": "Broker",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Broker named in the notice",
					},
					map[string]any{
						"name": "buybacks",
						"title": "Buybacks",
						"type": "`$NUMBER`",
						"short": "PaymentsForRepurchaseOfCommonStock for the fiscal year, USD",
					},
					map[string]any{
						"name": "buyers",
						"title": "Buyers",
						"type": "`$ARRAY`",
						"short": "Up to five buyers, largest first",
					},
					map[string]any{
						"name": "canonicalUrl",
						"title": "Canonical Url",
						"type": "`$STRING`",
						"short": "The matching page on xoomar.com",
						"format": "uri",
					},
					map[string]any{
						"name": "capPct",
						"title": "Cap Pct",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Maximum return as % of initial level when the note is capped",
					},
					map[string]any{
						"name": "changePct",
						"title": "Change Pct",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Change in short quantity vs the prior report",
					},
					map[string]any{
						"name": "cik",
						"title": "Cik",
						"type": "`$STRING`",
						"short": "SEC CIK, ten digits",
					},
					map[string]any{
						"name": "company",
						"title": "Company",
						"type": "`$STRING`",
						"short": "Filer name as on the filing",
					},
					map[string]any{
						"name": "companyName",
						"title": "Company Name",
						"type": "`$STRING`",
						"short": "Filer name as on EDGAR",
					},
					map[string]any{
						"name": "costUsd",
						"title": "Cost Usd",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Cost basis as filed, USD",
					},
					map[string]any{
						"name": "coupon",
						"title": "Coupon",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Annual coupon %; null on preliminary filings, which are filed before the rate is set",
					},
					map[string]any{
						"name": "cusip",
						"title": "Cusip",
						"type": "`$STRING`",
						"short": "CUSIP of the security",
					},
					map[string]any{
						"name": "data",
						"title": "Data",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "date",
						"title": "Date",
						"type": "`$STRING`",
						"short": "The reported date (filing date of the 8-K) or the estimated date",
						"format": "date",
					},
					map[string]any{
						"name": "dateOfFirstSale",
						"title": "Date Of First Sale",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "ISO date; null when the first sale has yet to occur",
					},
					map[string]any{
						"name": "daysToCover",
						"title": "Days To Cover",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "shortQty / avgDailyVol, FINRA-computed",
					},
					map[string]any{
						"name": "description",
						"title": "Description",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Security description as the SEC publishes it",
					},
					map[string]any{
						"name": "docUrl",
						"title": "Doc Url",
						"type": "`$STRING`",
						"short": "Link to the filing index on sec.gov",
					},
					map[string]any{
						"name": "docs",
						"title": "Docs",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "end",
						"title": "End",
						"type": "`$STRING`",
						"short": "Fiscal year end",
						"format": "date",
					},
					map[string]any{
						"name": "entityType",
						"title": "Entity Type",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Corporation, Limited Partnership, LLC, Trust and so on",
					},
					map[string]any{
						"name": "eventDate",
						"title": "Event Date",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Date of the event that requires the filing",
						"format": "date",
					},
					map[string]any{
						"name": "eventLabels",
						"title": "Event Labels",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$ARRAY`",
								"`$NULL`",
							},
						},
						"short": "Readable labels for each item",
					},
					map[string]any{
						"name": "exchange",
						"title": "Exchange",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Exchange named for the sale",
					},
					map[string]any{
						"name": "exemptions",
						"title": "Exemptions",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Rule items claimed, e.g.",
					},
					map[string]any{
						"name": "fairValueUsd",
						"title": "Fair Value Usd",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Fair value of crypto assets as filed, USD",
					},
					map[string]any{
						"name": "filedAt",
						"title": "Filed At",
						"type": "`$STRING`",
						"short": "SEC acceptance timestamp",
						"format": "date-time",
					},
					map[string]any{
						"name": "firstRegistration",
						"title": "First Registration",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing",
					},
					map[string]any{
						"name": "firstTxDate",
						"title": "First Tx Date",
						"type": "`$STRING`",
						"short": "Earliest purchase in the window",
						"format": "date",
					},
					map[string]any{
						"name": "form",
						"title": "Form",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "10-Q or 10-K the figures come from",
					},
					map[string]any{
						"name": "formType",
						"title": "Form Type",
						"type": "`$STRING`",
						"short": "S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT",
					},
					map[string]any{
						"name": "frame",
						"title": "Frame",
						"type": "`$STRING`",
						"short": "Fiscal year frame, e.g.",
					},
					map[string]any{
						"name": "fundType",
						"title": "Fund Type",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only",
					},
					map[string]any{
						"name": "generatedId",
						"title": "Generated Id",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "USAspending award id; https://www.usaspending.gov/award/{generatedId}",
					},
					map[string]any{
						"name": "impliedPrice",
						"title": "Implied Price",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "fairValueUsd divided by units, the filing's own valuation per coin",
					},
					map[string]any{
						"name": "industryGroup",
						"title": "Industry Group",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "SEC industry category (Pooled Investment Fund for funds)",
					},
					map[string]any{
						"name": "insiderName",
						"title": "Insider Name",
						"type": "`$STRING`",
						"short": "Reporting officer, director, or 10% owner",
					},
					map[string]any{
						"name": "insiderTitle",
						"title": "Insider Title",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Role at the company (CEO, CFO, Director...)",
					},
					map[string]any{
						"name": "insiders",
						"title": "Insiders",
						"type": "`$NUMBER`",
						"short": "Distinct insiders who bought on the open market in the window",
					},
					map[string]any{
						"name": "investorsCount",
						"title": "Investors Count",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Investors who have already invested",
					},
					map[string]any{
						"name": "isAmendment",
						"title": "Is Amendment",
						"type": "`$BOOLEAN`",
						"short": "Form D/A",
					},
					map[string]any{
						"name": "issuer",
						"title": "Issuer",
						"type": "`$STRING`",
						"short": "Filing entity (BofA Finance, Morgan Stanley Finance...)",
					},
					map[string]any{
						"name": "issuerCik",
						"title": "Issuer Cik",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Issuer CIK, ten digits",
					},
					map[string]any{
						"name": "issuerName",
						"title": "Issuer Name",
						"type": "`$STRING`",
						"short": "Issuer name as filed",
					},
					map[string]any{
						"name": "items",
						"title": "Items",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$ARRAY`",
								"`$NULL`",
							},
						},
						"short": "8-K item numbers (2.02, 5.02...)",
					},
					map[string]any{
						"name": "latestFiledAt",
						"title": "Latest Filed At",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "When the latest of those filings reached EDGAR",
					},
					map[string]any{
						"name": "latestTxDate",
						"title": "Latest Tx Date",
						"type": "`$STRING`",
						"short": "Latest purchase in the window",
						"format": "date",
					},
					map[string]any{
						"name": "license",
						"title": "License",
						"type": "`$STRING`",
						"short": "Data terms",
					},
					map[string]any{
						"name": "listed",
						"title": "Listed",
						"type": "`$BOOLEAN`",
						"short": "Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now",
					},
					map[string]any{
						"name": "manager",
						"title": "Manager",
						"type": "`$STRING`",
						"short": "Manager",
					},
					map[string]any{
						"name": "market",
						"title": "Market",
						"type": "`$STRING`",
						"short": "nasdaq or cboe",
					},
					map[string]any{
						"name": "meta",
						"title": "Meta",
						"type": "`$OBJECT`",
						"short": "Who publishes the data and how to credit it",
					},
					map[string]any{
						"name": "minimumInvestment",
						"title": "Minimum Investment",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "USD minimum accepted from an outside investor",
					},
					map[string]any{
						"name": "mod",
						"title": "Mod",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Modification number; 0 or null is the original award",
					},
					map[string]any{
						"name": "naicsCode",
						"title": "Naics Code",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Industry code of the work",
					},
					map[string]any{
						"name": "name",
						"title": "Name",
						"type": "`$STRING`",
						"short": "Company",
					},
					map[string]any{
						"name": "netIncome",
						"title": "Net Income",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Net income for the same fiscal year, USD",
					},
					map[string]any{
						"name": "noteType",
						"title": "Note Type",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "autocallable, buffered, barrier, or income.",
					},
					map[string]any{
						"name": "offeringAmount",
						"title": "Offering Amount",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Always null; offering amounts are not included",
					},
					map[string]any{
						"name": "percentOfClass",
						"title": "Percent Of Class",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Percent of the class owned",
					},
					map[string]any{
						"name": "personName",
						"title": "Person Name",
						"type": "`$STRING`",
						"short": "Person for whose account the shares are to be sold",
					},
					map[string]any{
						"name": "personType",
						"title": "Person Type",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Type of reporting person as filed, e.g.",
					},
					map[string]any{
						"name": "price",
						"title": "Price",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Closing price the SEC reports with the row, USD",
					},
					map[string]any{
						"name": "priceNote",
						"title": "Price Note",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "\"price not stated in the filing\" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); \"≈ $61.36, midpoint of the stated range $60.86 to $61.85\" when the price is the midpoint of…",
					},
					map[string]any{
						"name": "pricePerShare",
						"title": "Price Per Share",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Reported price per share in USD",
					},
					map[string]any{
						"name": "pricingDate",
						"title": "Pricing Date",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Pricing/trade date when stated",
					},
					map[string]any{
						"name": "principalUsd",
						"title": "Principal Usd",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Aggregate principal when stated (final filings)",
					},
					map[string]any{
						"name": "quantity",
						"title": "Quantity",
						"type": "`$NUMBER`",
						"short": "Shares failed to deliver, as the SEC publishes them",
					},
					map[string]any{
						"name": "recipientName",
						"title": "Recipient Name",
						"type": "`$STRING`",
						"short": "Recipient legal name as registered",
					},
					map[string]any{
						"name": "relationship",
						"title": "Relationship",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Relationship to the issuer, e.g.",
					},
					map[string]any{
						"name": "reportingCik",
						"title": "Reporting Cik",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Reporting person's CIK, when filed",
					},
					map[string]any{
						"name": "reportingPerson",
						"title": "Reporting Person",
						"type": "`$STRING`",
						"short": "Reporting person or entity",
					},
					map[string]any{
						"name": "revenue",
						"title": "Revenue",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Revenue for the same fiscal year, USD",
					},
					map[string]any{
						"name": "revenueRange",
						"title": "Revenue Range",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Issuer revenue range or fund net asset value range, as disclosed",
					},
					map[string]any{
						"name": "securityClass",
						"title": "Security Class",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Title of the class of securities",
					},
					map[string]any{
						"name": "securityName",
						"title": "Security Name",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Security name as listed",
					},
					map[string]any{
						"name": "securityTypes",
						"title": "Security Types",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "equity, debt, options, pooled fund, other",
					},
					map[string]any{
						"name": "settlementDate",
						"title": "Settlement Date",
						"type": "`$STRING`",
						"short": "Settlement date",
						"format": "date",
					},
					map[string]any{
						"name": "shares",
						"title": "Shares",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Shares bought or sold",
					},
					map[string]any{
						"name": "sharesOwned",
						"title": "Shares Owned",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Shares beneficially owned",
					},
					map[string]any{
						"name": "shortExemptVolume",
						"title": "Short Exempt Volume",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Short sales marked exempt",
					},
					map[string]any{
						"name": "shortQty",
						"title": "Short Qty",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Total shares held short",
					},
					map[string]any{
						"name": "shortRatio",
						"title": "Short Ratio",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "shortVolume divided by totalVolume",
					},
					map[string]any{
						"name": "shortVolume",
						"title": "Short Volume",
						"type": "`$NUMBER`",
						"short": "Shares sold short that day, as reported to FINRA's facilities",
					},
					map[string]any{
						"name": "slug",
						"title": "Slug",
						"type": "`$STRING`",
						"short": "Fund slug for URLs",
					},
					map[string]any{
						"name": "source",
						"title": "Source",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "state",
						"title": "State",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Issuer state or country code",
					},
					map[string]any{
						"name": "status",
						"title": "Status",
						"type": "`$STRING`",
						"short": "reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives)",
					},
					map[string]any{
						"name": "symbol",
						"title": "Symbol",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Ticker",
					},
					map[string]any{
						"name": "ticker",
						"title": "Ticker",
						"type": "`$STRING`",
						"short": "Listed ticker",
					},
					map[string]any{
						"name": "totalAmountSold",
						"title": "Total Amount Sold",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "USD sold as of the filing",
					},
					map[string]any{
						"name": "totalOfferingAmount",
						"title": "Total Offering Amount",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "USD; null when indefinite",
					},
					map[string]any{
						"name": "totalVolume",
						"title": "Total Volume",
						"type": "`$NUMBER`",
						"short": "Total shares reported to FINRA's facilities that day (not the consolidated tape)",
					},
					map[string]any{
						"name": "trades",
						"title": "Trades",
						"type": "`$NUMBER`",
						"short": "Open-market purchase transactions in the window",
					},
					map[string]any{
						"name": "txDate",
						"title": "Tx Date",
						"type": "`$STRING`",
						"short": "Transaction date from the filing, YYYY-MM-DD",
						"format": "date",
					},
					map[string]any{
						"name": "underlyings",
						"title": "Underlyings",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$ARRAY`",
								"`$NULL`",
							},
						},
						"short": "Parsed underlying symbols (SPX, NDX, NVDA...).",
					},
					map[string]any{
						"name": "units",
						"title": "Units",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Bitcoin held as tagged in the filing; null when the filing gives no usable count",
					},
					map[string]any{
						"name": "unitsOutstanding",
						"title": "Units Outstanding",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Shares or units of the class outstanding",
					},
					map[string]any{
						"name": "unitsReliable",
						"title": "Units Reliable",
						"type": "`$BOOLEAN`",
						"short": "true when the filing gives a usable coin count",
					},
					map[string]any{
						"name": "unitsToSell",
						"title": "Units To Sell",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Shares or units to be sold",
					},
					map[string]any{
						"name": "updatedAt",
						"title": "Updated At",
						"type": "`$STRING`",
						"short": "When the response was built; a few dated feeds give the date of their newest row instead",
						"format": "date-time",
					},
					map[string]any{
						"name": "url",
						"title": "Url",
						"type": "`$STRING`",
						"short": "Hub page",
					},
					map[string]any{
						"name": "valueUsd",
						"title": "Value Usd",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "quantity times price, USD",
					},
				},
				"name": "company",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/bitcoin-treasuries",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "bitcoin-treasuries",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"bitcoin-treasuries",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/buybacks",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "buybacks",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"buybacks",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/earnings",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "earnings",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"earnings",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "from",
											"orig": "from",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 500,
										},
										map[string]any{
											"name": "status",
											"orig": "status",
											"type": "`$STRING`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "ticker",
											"orig": "ticker",
											"type": "`$STRING`",
											"kind": "query",
											"example": "NVDA",
											"field": true,
										},
										map[string]any{
											"name": "to",
											"orig": "to",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/events",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "events",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"events",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "day",
											"orig": "days",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 7,
										},
										map[string]any{
											"name": "item",
											"orig": "item",
											"type": "`$STRING`",
											"kind": "query",
											"example": "5.02",
										},
										map[string]any{
											"name": "ticker",
											"orig": "ticker",
											"type": "`$STRING`",
											"kind": "query",
											"example": "AAPL",
											"field": true,
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/fails-to-deliver",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "fails-to-deliver",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"fails-to-deliver",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "from",
											"orig": "from",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 400,
										},
										map[string]any{
											"name": "symbol",
											"orig": "symbol",
											"type": "`$STRING`",
											"kind": "query",
											"example": "GME",
											"field": true,
										},
										map[string]any{
											"name": "to",
											"orig": "to",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/federal-contracts",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "federal-contracts",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"federal-contracts",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "by",
											"orig": "by",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "day",
											"orig": "days",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 7,
										},
										map[string]any{
											"name": "listed",
											"orig": "listed",
											"type": "`$STRING`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "ticker",
											"orig": "ticker",
											"type": "`$STRING`",
											"kind": "query",
											"example": "LMT",
											"field": true,
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/funds",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "funds",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"funds",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/insiders",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "insiders",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"insiders",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "type",
											"orig": "type",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "window",
											"orig": "window",
											"type": "`$STRING`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/insiders/clusters",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "insiders",
									},
									map[string]any{
										"lit": "clusters",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"insiders",
									"clusters",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "day",
											"orig": "days",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 30,
										},
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 100,
										},
										map[string]any{
											"name": "min_insider",
											"orig": "minInsiders",
											"type": "`$INTEGER`",
											"kind": "query",
										},
										map[string]any{
											"name": "min_usd",
											"orig": "minUsd",
											"type": "`$NUMBER`",
											"kind": "query",
										},
										map[string]any{
											"name": "ticker",
											"orig": "ticker",
											"type": "`$STRING`",
											"kind": "query",
											"example": "NVDA",
											"field": true,
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/ipos",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "ipos",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"ipos",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "day",
											"orig": "days",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 90,
										},
										map[string]any{
											"name": "form",
											"orig": "form",
											"type": "`$STRING`",
											"kind": "query",
											"example": "S-1,F-1",
											"field": true,
										},
										map[string]any{
											"name": "new",
											"orig": "new",
											"type": "`$STRING`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/large-holders",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "large-holders",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"large-holders",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "day",
											"orig": "days",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 30,
										},
										map[string]any{
											"name": "form",
											"orig": "form",
											"type": "`$STRING`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "new",
											"orig": "new",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "sort",
											"orig": "sort",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "symbol",
											"orig": "symbol",
											"type": "`$STRING`",
											"kind": "query",
											"example": "GME",
											"field": true,
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/planned-sales",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "planned-sales",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"planned-sales",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "day",
											"orig": "days",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 30,
										},
										map[string]any{
											"name": "symbol",
											"orig": "symbol",
											"type": "`$STRING`",
											"kind": "query",
											"example": "GME",
											"field": true,
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/short-interest",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "short-interest",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"short-interest",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "symbol",
											"orig": "symbol",
											"type": "`$STRING`",
											"kind": "query",
											"example": "GME",
											"field": true,
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/short-volume",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "short-volume",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"short-volume",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "day",
											"orig": "days",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 60,
										},
										map[string]any{
											"name": "from",
											"orig": "from",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 60,
										},
										map[string]any{
											"name": "sort",
											"orig": "sort",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "symbol",
											"orig": "symbol",
											"type": "`$STRING`",
											"kind": "query",
											"example": "GME",
											"field": true,
										},
										map[string]any{
											"name": "to",
											"orig": "to",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/startup-funding",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "startup-funding",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"startup-funding",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "amendment",
											"orig": "amendments",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "cik",
											"orig": "cik",
											"type": "`$STRING`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "day",
											"orig": "days",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 30,
										},
										map[string]any{
											"name": "fund",
											"orig": "funds",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "sort",
											"orig": "sort",
											"type": "`$STRING`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/structured-products",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "structured-products",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"structured-products",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "cursor",
											"orig": "cursor",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "day",
											"orig": "days",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 30,
										},
										map[string]any{
											"name": "issuer",
											"orig": "issuer",
											"type": "`$STRING`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "max_coupon",
											"orig": "maxCoupon",
											"type": "`$NUMBER`",
											"kind": "query",
										},
										map[string]any{
											"name": "min_coupon",
											"orig": "minCoupon",
											"type": "`$NUMBER`",
											"kind": "query",
										},
										map[string]any{
											"name": "note_type",
											"orig": "noteType",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "underlying",
											"orig": "underlying",
											"type": "`$STRING`",
											"kind": "query",
											"example": "SPX",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/threshold-list",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "threshold-list",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"threshold-list",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "date",
											"orig": "date",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
											"field": true,
										},
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 1000,
										},
										map[string]any{
											"name": "market",
											"orig": "market",
											"type": "`$STRING`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "symbol",
											"orig": "symbol",
											"type": "`$STRING`",
											"kind": "query",
											"example": "GME",
											"field": true,
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/funds/{slug}",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "funds",
									},
									map[string]any{
										"var": "slug",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"funds",
									"{slug}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "slug",
											"orig": "slug",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "berkshire-hathaway",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"slug",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/financials",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "financials",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"financials",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "symbol",
											"orig": "symbol",
											"type": "`$STRING`",
											"kind": "query",
											"reqd": true,
											"example": "AAPL",
											"field": true,
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"symbol",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/earnings/{ticker}",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "earnings",
									},
									map[string]any{
										"var": "ticker",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"earnings",
									"{ticker}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "ticker",
											"orig": "ticker",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "NVDA",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ticker",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/insiders/{ticker}",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "insiders",
									},
									map[string]any{
										"var": "ticker",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"insiders",
									"{ticker}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "ticker",
											"orig": "ticker",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "AAPL",
										},
									},
									"query": []any{
										map[string]any{
											"name": "from",
											"orig": "from",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 200,
										},
										map[string]any{
											"name": "to",
											"orig": "to",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"ticker",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"crypto": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "asset",
						"title": "Asset",
						"type": "`$STRING`",
						"short": "btc or eth",
					},
					map[string]any{
						"name": "attribution",
						"title": "Attribution",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "aumUsd",
						"title": "Aum Usd",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Holdings valued in USD",
					},
					map[string]any{
						"name": "baseAsset",
						"title": "Base Asset",
						"type": "`$STRING`",
						"short": "Base asset ticker (BTC, ETH...)",
					},
					map[string]any{
						"name": "binanceSymbol",
						"title": "Binance Symbol",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Binance symbol",
					},
					map[string]any{
						"name": "bitmexSymbol",
						"title": "Bitmex Symbol",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Always null, kept so existing clients parse unchanged",
					},
					map[string]any{
						"name": "bybitSymbol",
						"title": "Bybit Symbol",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Bybit symbol",
					},
					map[string]any{
						"name": "canonicalUrl",
						"title": "Canonical Url",
						"type": "`$STRING`",
						"short": "The matching page on xoomar.com",
						"format": "uri",
					},
					map[string]any{
						"name": "count",
						"title": "Count",
						"type": "`$NUMBER`",
						"short": "Events",
					},
					map[string]any{
						"name": "data",
						"title": "Data",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "date",
						"title": "Date",
						"type": "`$STRING`",
						"short": "The as-of date of the issuer file",
						"format": "date",
					},
					map[string]any{
						"name": "docs",
						"title": "Docs",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "exchange",
						"title": "Exchange",
						"type": "`$STRING`",
						"short": "binance, bybit, okx, hyperliquid or kraken",
					},
					map[string]any{
						"name": "flowUsd",
						"title": "Flow Usd",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Net flow for the day in USD, derived from the change in the fund's reported holdings",
					},
					map[string]any{
						"name": "fundingAnnualized",
						"title": "Funding Annualized",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Annualized rate, simple (not compounded), from the rate and its funding interval",
					},
					map[string]any{
						"name": "fundingIntervalHours",
						"title": "Funding Interval Hours",
						"type": "`$NUMBER`",
						"short": "Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken)",
					},
					map[string]any{
						"name": "fundingRate",
						"title": "Funding Rate",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval)",
					},
					map[string]any{
						"name": "fundingRate8h",
						"title": "Funding Rate8h",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "The rate scaled to eight hours, comparable across venues",
					},
					map[string]any{
						"name": "holdings",
						"title": "Holdings",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Coins held per the issuer file",
					},
					map[string]any{
						"name": "hour",
						"title": "Hour",
						"type": "`$STRING`",
						"short": "Hour bucket, ISO",
						"format": "date-time",
					},
					map[string]any{
						"name": "hyperliquidCoin",
						"title": "Hyperliquid Coin",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Hyperliquid coin",
					},
					map[string]any{
						"name": "id",
						"title": "Id",
						"type": "`$NUMBER`",
						"short": "Event id",
					},
					map[string]any{
						"name": "issuer",
						"title": "Issuer",
						"type": "`$STRING`",
						"short": "Issuer name",
					},
					map[string]any{
						"name": "krakenSymbol",
						"title": "Kraken Symbol",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Kraken Futures symbol",
					},
					map[string]any{
						"name": "license",
						"title": "License",
						"type": "`$STRING`",
						"short": "Data terms",
					},
					map[string]any{
						"name": "longShortRatio",
						"title": "Long Short Ratio",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Global long/short account ratio where the venue publishes it, else null",
					},
					map[string]any{
						"name": "longUsd",
						"title": "Long Usd",
						"type": "`$NUMBER`",
						"short": "Long liquidations in USD",
					},
					map[string]any{
						"name": "markPrice",
						"title": "Mark Price",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Latest mark price in USD",
					},
					map[string]any{
						"name": "maxSingleUsd",
						"title": "Max Single Usd",
						"type": "`$NUMBER`",
						"short": "Largest single event",
					},
					map[string]any{
						"name": "meta",
						"title": "Meta",
						"type": "`$OBJECT`",
						"short": "Who publishes the data and how to credit it",
					},
					map[string]any{
						"name": "nextFundingTime",
						"title": "Next Funding Time",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "ISO timestamp of the next funding settlement",
					},
					map[string]any{
						"name": "okxInstId",
						"title": "Okx Inst Id",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "OKX instrument id",
					},
					map[string]any{
						"name": "openInterest",
						"title": "Open Interest",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Open interest in contracts",
					},
					map[string]any{
						"name": "openInterestValue",
						"title": "Open Interest Value",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Open interest notional in USD",
					},
					map[string]any{
						"name": "price",
						"title": "Price",
						"type": "`$STRING`",
						"short": "Liquidation price",
					},
					map[string]any{
						"name": "priceChangePct24h",
						"title": "Price Change Pct24h",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "24h price change as a decimal",
					},
					map[string]any{
						"name": "qty",
						"title": "Qty",
						"type": "`$STRING`",
						"short": "Quantity in coins",
					},
					map[string]any{
						"name": "rawSymbol",
						"title": "Raw Symbol",
						"type": "`$STRING`",
						"short": "Contract as the exchange names it",
					},
					map[string]any{
						"name": "shortUsd",
						"title": "Short Usd",
						"type": "`$NUMBER`",
						"short": "Short liquidations in USD",
					},
					map[string]any{
						"name": "side",
						"title": "Side",
						"type": "`$STRING`",
						"short": "long (forced sale) or short (forced buy)",
					},
					map[string]any{
						"name": "slug",
						"title": "Slug",
						"type": "`$STRING`",
						"short": "Symbol slug used in URLs (btc, eth, sol...)",
					},
					map[string]any{
						"name": "source",
						"title": "Source",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "symbol",
						"title": "Symbol",
						"type": "`$STRING`",
						"short": "Contract (only when filtered)",
					},
					map[string]any{
						"name": "ticker",
						"title": "Ticker",
						"type": "`$STRING`",
						"short": "Fund ticker (IBIT, ETHA...)",
					},
					map[string]any{
						"name": "totalUsd",
						"title": "Total Usd",
						"type": "`$NUMBER`",
						"short": "Total in USD",
					},
					map[string]any{
						"name": "ts",
						"title": "Ts",
						"type": "`$STRING`",
						"short": "Event time, ISO",
						"format": "date-time",
					},
					map[string]any{
						"name": "updatedAt",
						"title": "Updated At",
						"type": "`$STRING`",
						"short": "When the response was built; a few dated feeds give the date of their newest row instead",
						"format": "date-time",
					},
					map[string]any{
						"name": "usdValue",
						"title": "Usd Value",
						"type": "`$STRING`",
						"short": "Notional in USD",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "crypto",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/etf-flows",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "etf-flows",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"etf-flows",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "asset",
											"orig": "asset",
											"type": "`$STRING`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "day",
											"orig": "days",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 90,
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/funding-rates",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "funding-rates",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"funding-rates",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/liquidations/history",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "liquidations",
									},
									map[string]any{
										"lit": "history",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"liquidations",
									"history",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "from",
											"orig": "from",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 168,
										},
										map[string]any{
											"name": "symbol",
											"orig": "symbol",
											"type": "`$STRING`",
											"kind": "query",
											"example": "BTCUSDT",
											"field": true,
										},
										map[string]any{
											"name": "to",
											"orig": "to",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/liquidations/recent",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "liquidations",
									},
									map[string]any{
										"lit": "recent",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"liquidations",
									"recent",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "exchange",
											"orig": "exchange",
											"type": "`$STRING`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 100,
										},
										map[string]any{
											"name": "min_usd",
											"orig": "minUsd",
											"type": "`$NUMBER`",
											"kind": "query",
											"example": 100000,
										},
										map[string]any{
											"name": "side",
											"orig": "side",
											"type": "`$STRING`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "symbol",
											"orig": "symbol",
											"type": "`$STRING`",
											"kind": "query",
											"example": "BTCUSDT",
											"field": true,
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/symbols",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "symbols",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"symbols",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/whales/{coin}",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "whales",
									},
									map[string]any{
										"var": "coin",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"whales",
									"{coin}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "coin",
											"orig": "coin",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "btc",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"coin",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/options/{currency}",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "options",
									},
									map[string]any{
										"var": "currency",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"options",
									"{currency}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "currency",
											"orig": "currency",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "BTC",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"currency",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/options/{currency}/dvol",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "options",
									},
									map[string]any{
										"var": "currency",
									},
									map[string]any{
										"lit": "dvol",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"options",
									"{currency}",
									"dvol",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "currency",
											"orig": "currency",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "BTC",
										},
									},
									"query": []any{
										map[string]any{
											"name": "from",
											"orig": "from",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
										map[string]any{
											"name": "to",
											"orig": "to",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"currency",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/funding-rates/{slug}",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "funding-rates",
									},
									map[string]any{
										"var": "slug",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"funding-rates",
									"{slug}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "slug",
											"orig": "slug",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "btc",
										},
									},
									"query": []any{
										map[string]any{
											"name": "history",
											"orig": "history",
											"type": "`$STRING`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"slug",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/open-interest/{slug}",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "open-interest",
									},
									map[string]any{
										"var": "slug",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"open-interest",
									"{slug}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "slug",
											"orig": "slug",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "btc",
										},
									},
									"query": []any{
										map[string]any{
											"name": "from",
											"orig": "from",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 5000,
										},
										map[string]any{
											"name": "period",
											"orig": "period",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "to",
											"orig": "to",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"slug",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/sentiment/{slug}",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "sentiment",
									},
									map[string]any{
										"var": "slug",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"sentiment",
									"{slug}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "slug",
											"orig": "slug",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "btc",
										},
									},
									"query": []any{
										map[string]any{
											"name": "history",
											"orig": "history",
											"type": "`$STRING`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"slug",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/signals/{slug}",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "signals",
									},
									map[string]any{
										"var": "slug",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"signals",
									"{slug}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "slug",
											"orig": "slug",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "btc",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"slug",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/liquidations",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "liquidations",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"liquidations",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/sentiment",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "sentiment",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"sentiment",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "asset",
											"orig": "asset",
											"type": "`$STRING`",
											"kind": "query",
											"example": "btc",
											"field": true,
										},
										map[string]any{
											"name": "kind",
											"orig": "kind",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "window",
											"orig": "window",
											"type": "`$STRING`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/whales",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "whales",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"whales",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"macro": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "actual",
						"title": "Actual",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...)",
					},
					map[string]any{
						"name": "assetMgrLong",
						"title": "Asset Mgr Long",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Asset managers and institutional investors (tff); swap dealers (disagg)",
					},
					map[string]any{
						"name": "assetMgrShort",
						"title": "Asset Mgr Short",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Asset managers and institutional investors (tff); swap dealers (disagg)",
					},
					map[string]any{
						"name": "assets",
						"title": "Assets",
						"type": "`$NUMBER`",
						"short": "Fed total assets, USD (WALCL)",
					},
					map[string]any{
						"name": "attribution",
						"title": "Attribution",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "auctionDate",
						"title": "Auction Date",
						"type": "`$STRING`",
						"short": "Auction date",
						"format": "date",
					},
					map[string]any{
						"name": "bidToCover",
						"title": "Bid To Cover",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Tendered divided by accepted",
					},
					map[string]any{
						"name": "canonicalUrl",
						"title": "Canonical Url",
						"type": "`$STRING`",
						"short": "The matching page on xoomar.com",
						"format": "uri",
					},
					map[string]any{
						"name": "country",
						"title": "Country",
						"type": "`$STRING`",
						"short": "Economy",
					},
					map[string]any{
						"name": "countryCode",
						"title": "Country Code",
						"type": "`$STRING`",
						"short": "BIS area code",
					},
					map[string]any{
						"name": "cusip",
						"title": "Cusip",
						"type": "`$STRING`",
						"short": "Security CUSIP; a reopening shares the original's CUSIP",
					},
					map[string]any{
						"name": "data",
						"title": "Data",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "date",
						"title": "Date",
						"type": "`$STRING`",
						"short": "H.4.1 Wednesday date",
						"format": "date",
					},
					map[string]any{
						"name": "dealerAccepted",
						"title": "Dealer Accepted",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Accepted by primary dealers, USD",
					},
					map[string]any{
						"name": "dealerLong",
						"title": "Dealer Long",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Dealers and intermediaries (tff); producers, merchants, processors and users (disagg)",
					},
					map[string]any{
						"name": "dealerShare",
						"title": "Dealer Share",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Dealer share of accepted, 0 to 1",
					},
					map[string]any{
						"name": "dealerShort",
						"title": "Dealer Short",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Dealers and intermediaries (tff); producers, merchants, processors and users (disagg)",
					},
					map[string]any{
						"name": "directAccepted",
						"title": "Direct Accepted",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Accepted from direct bidders, USD",
					},
					map[string]any{
						"name": "directShare",
						"title": "Direct Share",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Direct share of accepted, 0 to 1",
					},
					map[string]any{
						"name": "docs",
						"title": "Docs",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "eventName",
						"title": "Event Name",
						"type": "`$STRING`",
						"short": "CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ...",
					},
					map[string]any{
						"name": "forecast",
						"title": "Forecast",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Always null: consensus forecasts aren't included",
					},
					map[string]any{
						"name": "group",
						"title": "Group",
						"type": "`$STRING`",
						"short": "currencies, indices, crypto, metals, energy, bonds, agriculture, other",
					},
					map[string]any{
						"name": "highRate",
						"title": "High Rate",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "High discount rate (bills) or high discount margin (FRNs), percent",
					},
					map[string]any{
						"name": "highYield",
						"title": "High Yield",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Stop-out yield, percent (notes, bonds, TIPS)",
					},
					map[string]any{
						"name": "importance",
						"title": "Importance",
						"type": "`$STRING`",
						"short": "high, med, or low",
					},
					map[string]any{
						"name": "indirectAccepted",
						"title": "Indirect Accepted",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Accepted from indirect bidders, USD",
					},
					map[string]any{
						"name": "indirectShare",
						"title": "Indirect Share",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Indirect share of accepted, 0 to 1",
					},
					map[string]any{
						"name": "interestRate",
						"title": "Interest Rate",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Coupon set at auction, percent",
					},
					map[string]any{
						"name": "issueDate",
						"title": "Issue Date",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Settlement date",
						"format": "date",
					},
					map[string]any{
						"name": "lastChanged",
						"title": "Last Changed",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Date of the most recent move",
					},
					map[string]any{
						"name": "levFundLong",
						"title": "Lev Fund Long",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Leveraged funds (tff); managed money (disagg)",
					},
					map[string]any{
						"name": "levFundShort",
						"title": "Lev Fund Short",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Leveraged funds (tff); managed money (disagg)",
					},
					map[string]any{
						"name": "license",
						"title": "License",
						"type": "`$STRING`",
						"short": "Data terms",
					},
					map[string]any{
						"name": "m1_m6",
						"title": "M1 M6",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "1, 2, 3, 6 month Treasury yields in percent",
					},
					map[string]any{
						"name": "maturityDate",
						"title": "Maturity Date",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Maturity",
						"format": "date",
					},
					map[string]any{
						"name": "meta",
						"title": "Meta",
						"type": "`$OBJECT`",
						"short": "Who publishes the data and how to credit it",
					},
					map[string]any{
						"name": "name",
						"title": "Name",
						"type": "`$STRING`",
						"short": "CFTC contract market name",
					},
					map[string]any{
						"name": "net",
						"title": "Net",
						"type": "`$NUMBER`",
						"short": "assets minus tga minus rrp, USD",
					},
					map[string]any{
						"name": "nonreptLong",
						"title": "Nonrept Long",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Non-reportable (small trader) positions",
					},
					map[string]any{
						"name": "nonreptShort",
						"title": "Nonrept Short",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Non-reportable (small trader) positions",
					},
					map[string]any{
						"name": "offeringAmount",
						"title": "Offering Amount",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Announced size, USD",
					},
					map[string]any{
						"name": "openInterest",
						"title": "Open Interest",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Total open interest in contracts",
					},
					map[string]any{
						"name": "otherLong",
						"title": "Other Long",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Other reportable positions",
					},
					map[string]any{
						"name": "otherShort",
						"title": "Other Short",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Other reportable positions",
					},
					map[string]any{
						"name": "periodLabel",
						"title": "Period Label",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05'",
					},
					map[string]any{
						"name": "previous",
						"title": "Previous",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "Prior period on the same basis as actual",
					},
					map[string]any{
						"name": "rate",
						"title": "Rate",
						"type": "`$STRING`",
						"short": "Policy rate, percent",
					},
					map[string]any{
						"name": "reopening",
						"title": "Reopening",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$BOOLEAN`",
								"`$NULL`",
							},
						},
						"short": "True when the auction adds to an existing issue",
					},
					map[string]any{
						"name": "reportDate",
						"title": "Report Date",
						"type": "`$STRING`",
						"short": "CFTC report Tuesday, YYYY-MM-DD",
						"format": "date",
					},
					map[string]any{
						"name": "reportType",
						"title": "Report Type",
						"type": "`$STRING`",
						"short": "tff (financial futures) or disagg (commodities)",
					},
					map[string]any{
						"name": "reserves",
						"title": "Reserves",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Reserve balances with Federal Reserve Banks, USD (WRESBAL)",
					},
					map[string]any{
						"name": "rrp",
						"title": "Rrp",
						"type": "`$NUMBER`",
						"short": "Overnight reverse repo usage on that date, USD (RRPONTSYD)",
					},
					map[string]any{
						"name": "scheduledAt",
						"title": "Scheduled At",
						"type": "`$STRING`",
						"short": "Release time, UTC",
						"format": "date-time",
					},
					map[string]any{
						"name": "securityTerm",
						"title": "Security Term",
						"type": "`$STRING`",
						"short": "Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening)",
					},
					map[string]any{
						"name": "securityType",
						"title": "Security Type",
						"type": "`$STRING`",
						"short": "Bill, CMB (cash management bill), Note, Bond, TIPS or FRN",
					},
					map[string]any{
						"name": "slug",
						"title": "Slug",
						"type": "`$STRING`",
						"short": "Market slug for URLs (euro-fx, gold...)",
					},
					map[string]any{
						"name": "sortRank",
						"title": "Sort Rank",
						"type": "`$NUMBER`",
						"short": "Display order within the group",
					},
					map[string]any{
						"name": "source",
						"title": "Source",
						"type": "`$STRING`",
						"short": "bls, bea, census, fed, dol or treasury (coupon auctions)",
					},
					map[string]any{
						"name": "tga",
						"title": "Tga",
						"type": "`$NUMBER`",
						"short": "Treasury General Account, USD (WTREGEN)",
					},
					map[string]any{
						"name": "totalAccepted",
						"title": "Total Accepted",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Accepted, USD (null until results)",
					},
					map[string]any{
						"name": "totalTendered",
						"title": "Total Tendered",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$NUMBER`",
								"`$NULL`",
							},
						},
						"short": "Bids received, USD",
					},
					map[string]any{
						"name": "unit",
						"title": "Unit",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance'",
					},
					map[string]any{
						"name": "updatedAt",
						"title": "Updated At",
						"type": "`$STRING`",
						"short": "When the response was built; a few dated feeds give the date of their newest row instead",
						"format": "date-time",
					},
					map[string]any{
						"name": "y1_y30",
						"title": "Y1 Y30",
						"type": []any{
							"`$ONE`",
							[]any{
								"`$STRING`",
								"`$NULL`",
							},
						},
						"short": "1 to 30 year Treasury yields in percent",
					},
				},
				"name": "macro",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/calendar",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "calendar",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"calendar",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "from",
											"orig": "from",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
										map[string]any{
											"name": "importance",
											"orig": "importance",
											"type": "`$STRING`",
											"kind": "query",
											"field": true,
										},
										map[string]any{
											"name": "to",
											"orig": "to",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/cot",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "cot",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"cot",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/fed-liquidity",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "fed-liquidity",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"fed-liquidity",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 5000,
										},
										map[string]any{
											"name": "series",
											"orig": "series",
											"type": "`$STRING`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/macro",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "macro",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"macro",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "from",
											"orig": "from",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
										map[string]any{
											"name": "series",
											"orig": "series",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "to",
											"orig": "to",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/rates",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "rates",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"rates",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/treasury-auctions",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "treasury-auctions",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"treasury-auctions",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.data`",
								},
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"name": "from",
											"orig": "from",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
										map[string]any{
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
											"kind": "query",
											"example": 100,
										},
										map[string]any{
											"name": "term",
											"orig": "term",
											"type": "`$STRING`",
											"kind": "query",
											"example": "10-Year",
										},
										map[string]any{
											"name": "to",
											"orig": "to",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
										map[string]any{
											"name": "type",
											"orig": "type",
											"type": "`$STRING`",
											"kind": "query",
										},
										map[string]any{
											"name": "upcoming",
											"orig": "upcoming",
											"type": "`$BOOLEAN`",
											"kind": "query",
										},
									},
								},
								"select": map[string]any{},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/rates/{country}",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "rates",
									},
									map[string]any{
										"var": "country",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"rates",
									"{country}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "country",
											"orig": "country",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "us",
										},
									},
									"query": []any{
										map[string]any{
											"name": "from",
											"orig": "from",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
										map[string]any{
											"name": "to",
											"orig": "to",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"country",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
							map[string]any{
								"kind": "http",
								"method": "GET",
								"orig": "/api/markets/cot/{slug}",
								"segments": []any{
									map[string]any{
										"lit": "api",
									},
									map[string]any{
										"lit": "markets",
									},
									map[string]any{
										"lit": "cot",
									},
									map[string]any{
										"var": "slug",
									},
								},
								"parts": []any{
									"api",
									"markets",
									"cot",
									"{slug}",
								},
								"rename": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"name": "slug",
											"orig": "slug",
											"type": "`$STRING`",
											"kind": "param",
											"reqd": true,
											"example": "e-mini-s-p-500-stock-index",
										},
									},
									"query": []any{
										map[string]any{
											"name": "from",
											"orig": "from",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
										map[string]any{
											"name": "to",
											"orig": "to",
											"type": "`$STRING`",
											"kind": "query",
											"example": "2026-01-01",
										},
									},
								},
								"select": map[string]any{
									"exist": []any{
										"slug",
									},
								},
								"response": map[string]any{
									"kind": "json",
									"media": "application/json",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
		},
	}
}

// The plugin definitions the model selected per feature, as []any so a
// feature package can consume them without core naming its types. Empty
// when no active feature declares active plugin groups for this target.
var featurePlugins = map[string][]any{
}

// FeaturePlugins is the definitions list for one feature's chain.
func FeaturePlugins(name string) []any {
	return featurePlugins[name]
}

var (
	sharedConfigOnce sync.Once
	sharedConfigVal  map[string]any
)

// SharedConfig returns the process-wide config, built once on first use.
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client.
//
// The returned map is shared: treat it as read-only. Callers that need to
// mutate should use MakeConfig, which always returns a fresh copy.
func SharedConfig() map[string]any {
	sharedConfigOnce.Do(func() {
		sharedConfigVal = MakeConfig()
	})
	return sharedConfigVal
}

func makeFeature(name string) Feature {
	switch name {
	case "ratelimit":
		if NewRatelimitFeatureFunc != nil {
			return NewRatelimitFeatureFunc()
		}
	case "retry":
		if NewRetryFeatureFunc != nil {
			return NewRetryFeatureFunc()
		}
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	case "timeout":
		if NewTimeoutFeatureFunc != nil {
			return NewTimeoutFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
