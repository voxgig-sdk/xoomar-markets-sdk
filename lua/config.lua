-- XoomarMarkets SDK configuration

-- Build a fresh, fully materialised config table. Every call rebuilds the
-- whole structure, so prefer require("config_shared") unless you need a
-- private copy you intend to mutate.
local function make_config()
  return {
    main = {
      name = "XoomarMarkets",
      slug = "xoomar-markets",
      version = "0.0.1",
      target = "lua",
    },
    feature = {
      ["ratelimit"] = {
        ["options"] = {
          ["active"] = false,
          ["burst"] = 5,
          ["rate"] = 5,
        },
        ["optspec"] = {
          ["now"] = "`$FUNCTION`",
          ["sleep"] = "`$FUNCTION`",
        },
        ["strict"] = false,
        ["transport"] = "wrap",
      },
      ["retry"] = {
        ["options"] = {
          ["active"] = false,
          ["factor"] = 2,
          ["maxDelay"] = 2000,
          ["minDelay"] = 50,
          ["retries"] = 2,
          ["statuses"] = {
            408,
            425,
            429,
            500,
            502,
            503,
            504,
          },
        },
        ["optspec"] = {
          ["jitter"] = "`$BOOLEAN`",
          ["sleep"] = "`$FUNCTION`",
        },
        ["strict"] = false,
        ["transport"] = "wrap",
      },
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
        ["optspec"] = {
          ["entity"] = "`$MAP`",
          ["net"] = "`$MAP`",
        },
        ["strict"] = false,
        ["transport"] = "base",
      },
      ["timeout"] = {
        ["options"] = {
          ["active"] = false,
          ["ms"] = 30000,
        },
        ["optspec"] = {
          ["clearTimer"] = "`$FUNCTION`",
          ["now"] = "`$FUNCTION`",
          ["setTimer"] = "`$FUNCTION`",
        },
        ["strict"] = false,
        ["transport"] = "wrap",
      },
    },
    options = {
      base = "https://xoomar.com",
      auth = {
        prefix = "",
        name = "x-api-key",
      },
      headers = {
        ["content-type"] = "application/json",
      },
      entity = {
        ["company"] = {},
        ["crypto"] = {},
        ["macro"] = {},
      },
    },
    entity = {
      ["company"] = {
        ["fields"] = {
          {
            ["name"] = "accessionNo",
            ["title"] = "Accession No",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "The filing's accession number for reported rows; null for estimates",
          },
          {
            ["name"] = "actionDate",
            ["title"] = "Action Date",
            ["type"] = "`$STRING`",
            ["short"] = "Date the action was signed",
          },
          {
            ["name"] = "actionType",
            ["title"] = "Action Type",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "FPDS action type code",
          },
          {
            ["name"] = "aggregateMarketValue",
            ["title"] = "Aggregate Market Value",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Aggregate market value of the shares to be sold, USD",
          },
          {
            ["name"] = "amendmentNo",
            ["title"] = "Amendment No",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Amendment number; null for the original filing",
          },
          {
            ["name"] = "amountUsd",
            ["title"] = "Amount Usd",
            ["type"] = "`$NUMBER`",
            ["short"] = "Dollars obligated by this action; negative for de-obligations",
          },
          {
            ["name"] = "approxSaleDate",
            ["title"] = "Approx Sale Date",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Approximate date of sale",
            ["format"] = "date",
          },
          {
            ["name"] = "asOf",
            ["title"] = "As Of",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Balance sheet date of the figures",
          },
          {
            ["name"] = "attribution",
            ["title"] = "Attribution",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "avgDailyVol",
            ["title"] = "Avg Daily Vol",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Average daily trading volume",
          },
          {
            ["name"] = "awardId",
            ["title"] = "Award Id",
            ["type"] = "`$STRING`",
            ["short"] = "Contract or order number (PIID)",
          },
          {
            ["name"] = "awardType",
            ["title"] = "Award Type",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Definitive contract, delivery order, BPA call, purchase order",
          },
          {
            ["name"] = "awardingAgency",
            ["title"] = "Awarding Agency",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Awarding department and bureau",
          },
          {
            ["name"] = "awardingSubAgency",
            ["title"] = "Awarding Sub Agency",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Awarding department and bureau",
          },
          {
            ["name"] = "barrierPct",
            ["title"] = "Barrier Pct",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Barrier/threshold as % of initial level.",
          },
          {
            ["name"] = "basis",
            ["title"] = "Basis",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Reference date for an estimated row; null for reported rows",
            ["format"] = "date",
          },
          {
            ["name"] = "broker",
            ["title"] = "Broker",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Broker named in the notice",
          },
          {
            ["name"] = "buybacks",
            ["title"] = "Buybacks",
            ["type"] = "`$NUMBER`",
            ["short"] = "PaymentsForRepurchaseOfCommonStock for the fiscal year, USD",
          },
          {
            ["name"] = "buyers",
            ["title"] = "Buyers",
            ["type"] = "`$ARRAY`",
            ["short"] = "Up to five buyers, largest first",
          },
          {
            ["name"] = "canonicalUrl",
            ["title"] = "Canonical Url",
            ["type"] = "`$STRING`",
            ["short"] = "The matching page on xoomar.com",
            ["format"] = "uri",
          },
          {
            ["name"] = "capPct",
            ["title"] = "Cap Pct",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Maximum return as % of initial level when the note is capped",
          },
          {
            ["name"] = "changePct",
            ["title"] = "Change Pct",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Change in short quantity vs the prior report",
          },
          {
            ["name"] = "cik",
            ["title"] = "Cik",
            ["type"] = "`$STRING`",
            ["short"] = "SEC CIK, ten digits",
          },
          {
            ["name"] = "company",
            ["title"] = "Company",
            ["type"] = "`$STRING`",
            ["short"] = "Filer name as on the filing",
          },
          {
            ["name"] = "companyName",
            ["title"] = "Company Name",
            ["type"] = "`$STRING`",
            ["short"] = "Filer name as on EDGAR",
          },
          {
            ["name"] = "costUsd",
            ["title"] = "Cost Usd",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Cost basis as filed, USD",
          },
          {
            ["name"] = "coupon",
            ["title"] = "Coupon",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Annual coupon %; null on preliminary filings, which are filed before the rate is set",
          },
          {
            ["name"] = "cusip",
            ["title"] = "Cusip",
            ["type"] = "`$STRING`",
            ["short"] = "CUSIP of the security",
          },
          {
            ["name"] = "data",
            ["title"] = "Data",
            ["type"] = "`$OBJECT`",
          },
          {
            ["name"] = "date",
            ["title"] = "Date",
            ["type"] = "`$STRING`",
            ["short"] = "The reported date (filing date of the 8-K) or the estimated date",
            ["format"] = "date",
          },
          {
            ["name"] = "dateOfFirstSale",
            ["title"] = "Date Of First Sale",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "ISO date; null when the first sale has yet to occur",
          },
          {
            ["name"] = "daysToCover",
            ["title"] = "Days To Cover",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "shortQty / avgDailyVol, FINRA-computed",
          },
          {
            ["name"] = "description",
            ["title"] = "Description",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Security description as the SEC publishes it",
          },
          {
            ["name"] = "docUrl",
            ["title"] = "Doc Url",
            ["type"] = "`$STRING`",
            ["short"] = "Link to the filing index on sec.gov",
          },
          {
            ["name"] = "docs",
            ["title"] = "Docs",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "end",
            ["title"] = "End",
            ["type"] = "`$STRING`",
            ["short"] = "Fiscal year end",
            ["format"] = "date",
          },
          {
            ["name"] = "entityType",
            ["title"] = "Entity Type",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Corporation, Limited Partnership, LLC, Trust and so on",
          },
          {
            ["name"] = "eventDate",
            ["title"] = "Event Date",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Date of the event that requires the filing",
            ["format"] = "date",
          },
          {
            ["name"] = "eventLabels",
            ["title"] = "Event Labels",
            ["type"] = {
              "`$ONE`",
              {
                "`$ARRAY`",
                "`$NULL`",
              },
            },
            ["short"] = "Readable labels for each item",
          },
          {
            ["name"] = "exchange",
            ["title"] = "Exchange",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Exchange named for the sale",
          },
          {
            ["name"] = "exemptions",
            ["title"] = "Exemptions",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Rule items claimed, e.g.",
          },
          {
            ["name"] = "fairValueUsd",
            ["title"] = "Fair Value Usd",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Fair value of crypto assets as filed, USD",
          },
          {
            ["name"] = "filedAt",
            ["title"] = "Filed At",
            ["type"] = "`$STRING`",
            ["short"] = "SEC acceptance timestamp",
            ["format"] = "date-time",
          },
          {
            ["name"] = "firstRegistration",
            ["title"] = "First Registration",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Earliest S-1 or F-1 on file for the filer; a 424B4 weeks after it is an IPO pricing",
          },
          {
            ["name"] = "firstTxDate",
            ["title"] = "First Tx Date",
            ["type"] = "`$STRING`",
            ["short"] = "Earliest purchase in the window",
            ["format"] = "date",
          },
          {
            ["name"] = "form",
            ["title"] = "Form",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "10-Q or 10-K the figures come from",
          },
          {
            ["name"] = "formType",
            ["title"] = "Form Type",
            ["type"] = "`$STRING`",
            ["short"] = "S-1, S-1/A, F-1, F-1/A, 424B4, RW or EFFECT",
          },
          {
            ["name"] = "frame",
            ["title"] = "Frame",
            ["type"] = "`$STRING`",
            ["short"] = "Fiscal year frame, e.g.",
          },
          {
            ["name"] = "fundType",
            ["title"] = "Fund Type",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Hedge, Private Equity, Venture Capital or Other Investment Fund, funds only",
          },
          {
            ["name"] = "generatedId",
            ["title"] = "Generated Id",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "USAspending award id; https://www.usaspending.gov/award/{generatedId}",
          },
          {
            ["name"] = "impliedPrice",
            ["title"] = "Implied Price",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "fairValueUsd divided by units, the filing's own valuation per coin",
          },
          {
            ["name"] = "industryGroup",
            ["title"] = "Industry Group",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "SEC industry category (Pooled Investment Fund for funds)",
          },
          {
            ["name"] = "insiderName",
            ["title"] = "Insider Name",
            ["type"] = "`$STRING`",
            ["short"] = "Reporting officer, director, or 10% owner",
          },
          {
            ["name"] = "insiderTitle",
            ["title"] = "Insider Title",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Role at the company (CEO, CFO, Director...)",
          },
          {
            ["name"] = "insiders",
            ["title"] = "Insiders",
            ["type"] = "`$NUMBER`",
            ["short"] = "Distinct insiders who bought on the open market in the window",
          },
          {
            ["name"] = "investorsCount",
            ["title"] = "Investors Count",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Investors who have already invested",
          },
          {
            ["name"] = "isAmendment",
            ["title"] = "Is Amendment",
            ["type"] = "`$BOOLEAN`",
            ["short"] = "Form D/A",
          },
          {
            ["name"] = "issuer",
            ["title"] = "Issuer",
            ["type"] = "`$STRING`",
            ["short"] = "Filing entity (BofA Finance, Morgan Stanley Finance...)",
          },
          {
            ["name"] = "issuerCik",
            ["title"] = "Issuer Cik",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Issuer CIK, ten digits",
          },
          {
            ["name"] = "issuerName",
            ["title"] = "Issuer Name",
            ["type"] = "`$STRING`",
            ["short"] = "Issuer name as filed",
          },
          {
            ["name"] = "items",
            ["title"] = "Items",
            ["type"] = {
              "`$ONE`",
              {
                "`$ARRAY`",
                "`$NULL`",
              },
            },
            ["short"] = "8-K item numbers (2.02, 5.02...)",
          },
          {
            ["name"] = "latestFiledAt",
            ["title"] = "Latest Filed At",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "When the latest of those filings reached EDGAR",
          },
          {
            ["name"] = "latestTxDate",
            ["title"] = "Latest Tx Date",
            ["type"] = "`$STRING`",
            ["short"] = "Latest purchase in the window",
            ["format"] = "date",
          },
          {
            ["name"] = "license",
            ["title"] = "License",
            ["type"] = "`$STRING`",
            ["short"] = "Data terms",
          },
          {
            ["name"] = "listed",
            ["title"] = "Listed",
            ["type"] = "`$BOOLEAN`",
            ["short"] = "Filer is on the SEC's listed-ticker table today; a company that has priced is listed by now",
          },
          {
            ["name"] = "manager",
            ["title"] = "Manager",
            ["type"] = "`$STRING`",
            ["short"] = "Manager",
          },
          {
            ["name"] = "market",
            ["title"] = "Market",
            ["type"] = "`$STRING`",
            ["short"] = "nasdaq or cboe",
          },
          {
            ["name"] = "meta",
            ["title"] = "Meta",
            ["type"] = "`$OBJECT`",
            ["short"] = "Who publishes the data and how to credit it",
          },
          {
            ["name"] = "minimumInvestment",
            ["title"] = "Minimum Investment",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "USD minimum accepted from an outside investor",
          },
          {
            ["name"] = "mod",
            ["title"] = "Mod",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Modification number; 0 or null is the original award",
          },
          {
            ["name"] = "naicsCode",
            ["title"] = "Naics Code",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Industry code of the work",
          },
          {
            ["name"] = "name",
            ["title"] = "Name",
            ["type"] = "`$STRING`",
            ["short"] = "Company",
          },
          {
            ["name"] = "netIncome",
            ["title"] = "Net Income",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Net income for the same fiscal year, USD",
          },
          {
            ["name"] = "noteType",
            ["title"] = "Note Type",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "autocallable, buffered, barrier, or income.",
          },
          {
            ["name"] = "offeringAmount",
            ["title"] = "Offering Amount",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Always null; offering amounts are not included",
          },
          {
            ["name"] = "percentOfClass",
            ["title"] = "Percent Of Class",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Percent of the class owned",
          },
          {
            ["name"] = "personName",
            ["title"] = "Person Name",
            ["type"] = "`$STRING`",
            ["short"] = "Person for whose account the shares are to be sold",
          },
          {
            ["name"] = "personType",
            ["title"] = "Person Type",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Type of reporting person as filed, e.g.",
          },
          {
            ["name"] = "price",
            ["title"] = "Price",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Closing price the SEC reports with the row, USD",
          },
          {
            ["name"] = "priceNote",
            ["title"] = "Price Note",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "\"price not stated in the filing\" when the filing states no price (the price and the value are then null, never 0; on a cluster, valueUsd is null); \"≈ $61.36, midpoint of the stated range $60.86 to $61.85\" when the price is the midpoint of…",
          },
          {
            ["name"] = "pricePerShare",
            ["title"] = "Price Per Share",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Reported price per share in USD",
          },
          {
            ["name"] = "pricingDate",
            ["title"] = "Pricing Date",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Pricing/trade date when stated",
          },
          {
            ["name"] = "principalUsd",
            ["title"] = "Principal Usd",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Aggregate principal when stated (final filings)",
          },
          {
            ["name"] = "quantity",
            ["title"] = "Quantity",
            ["type"] = "`$NUMBER`",
            ["short"] = "Shares failed to deliver, as the SEC publishes them",
          },
          {
            ["name"] = "recipientName",
            ["title"] = "Recipient Name",
            ["type"] = "`$STRING`",
            ["short"] = "Recipient legal name as registered",
          },
          {
            ["name"] = "relationship",
            ["title"] = "Relationship",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Relationship to the issuer, e.g.",
          },
          {
            ["name"] = "reportingCik",
            ["title"] = "Reporting Cik",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Reporting person's CIK, when filed",
          },
          {
            ["name"] = "reportingPerson",
            ["title"] = "Reporting Person",
            ["type"] = "`$STRING`",
            ["short"] = "Reporting person or entity",
          },
          {
            ["name"] = "revenue",
            ["title"] = "Revenue",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Revenue for the same fiscal year, USD",
          },
          {
            ["name"] = "revenueRange",
            ["title"] = "Revenue Range",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Issuer revenue range or fund net asset value range, as disclosed",
          },
          {
            ["name"] = "securityClass",
            ["title"] = "Security Class",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Title of the class of securities",
          },
          {
            ["name"] = "securityName",
            ["title"] = "Security Name",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Security name as listed",
          },
          {
            ["name"] = "securityTypes",
            ["title"] = "Security Types",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "equity, debt, options, pooled fund, other",
          },
          {
            ["name"] = "settlementDate",
            ["title"] = "Settlement Date",
            ["type"] = "`$STRING`",
            ["short"] = "Settlement date",
            ["format"] = "date",
          },
          {
            ["name"] = "shares",
            ["title"] = "Shares",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Shares bought or sold",
          },
          {
            ["name"] = "sharesOwned",
            ["title"] = "Shares Owned",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Shares beneficially owned",
          },
          {
            ["name"] = "shortExemptVolume",
            ["title"] = "Short Exempt Volume",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Short sales marked exempt",
          },
          {
            ["name"] = "shortQty",
            ["title"] = "Short Qty",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Total shares held short",
          },
          {
            ["name"] = "shortRatio",
            ["title"] = "Short Ratio",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "shortVolume divided by totalVolume",
          },
          {
            ["name"] = "shortVolume",
            ["title"] = "Short Volume",
            ["type"] = "`$NUMBER`",
            ["short"] = "Shares sold short that day, as reported to FINRA's facilities",
          },
          {
            ["name"] = "slug",
            ["title"] = "Slug",
            ["type"] = "`$STRING`",
            ["short"] = "Fund slug for URLs",
          },
          {
            ["name"] = "source",
            ["title"] = "Source",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "state",
            ["title"] = "State",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Issuer state or country code",
          },
          {
            ["name"] = "status",
            ["title"] = "Status",
            ["type"] = "`$STRING`",
            ["short"] = "reported (an 8-K with Item 2.02 on EDGAR) or estimated (an expected date, shown until the company's 8-K arrives)",
          },
          {
            ["name"] = "symbol",
            ["title"] = "Symbol",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Ticker",
          },
          {
            ["name"] = "ticker",
            ["title"] = "Ticker",
            ["type"] = "`$STRING`",
            ["short"] = "Listed ticker",
          },
          {
            ["name"] = "totalAmountSold",
            ["title"] = "Total Amount Sold",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "USD sold as of the filing",
          },
          {
            ["name"] = "totalOfferingAmount",
            ["title"] = "Total Offering Amount",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "USD; null when indefinite",
          },
          {
            ["name"] = "totalVolume",
            ["title"] = "Total Volume",
            ["type"] = "`$NUMBER`",
            ["short"] = "Total shares reported to FINRA's facilities that day (not the consolidated tape)",
          },
          {
            ["name"] = "trades",
            ["title"] = "Trades",
            ["type"] = "`$NUMBER`",
            ["short"] = "Open-market purchase transactions in the window",
          },
          {
            ["name"] = "txDate",
            ["title"] = "Tx Date",
            ["type"] = "`$STRING`",
            ["short"] = "Transaction date from the filing, YYYY-MM-DD",
            ["format"] = "date",
          },
          {
            ["name"] = "underlyings",
            ["title"] = "Underlyings",
            ["type"] = {
              "`$ONE`",
              {
                "`$ARRAY`",
                "`$NULL`",
              },
            },
            ["short"] = "Parsed underlying symbols (SPX, NDX, NVDA...).",
          },
          {
            ["name"] = "units",
            ["title"] = "Units",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Bitcoin held as tagged in the filing; null when the filing gives no usable count",
          },
          {
            ["name"] = "unitsOutstanding",
            ["title"] = "Units Outstanding",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Shares or units of the class outstanding",
          },
          {
            ["name"] = "unitsReliable",
            ["title"] = "Units Reliable",
            ["type"] = "`$BOOLEAN`",
            ["short"] = "true when the filing gives a usable coin count",
          },
          {
            ["name"] = "unitsToSell",
            ["title"] = "Units To Sell",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Shares or units to be sold",
          },
          {
            ["name"] = "updatedAt",
            ["title"] = "Updated At",
            ["type"] = "`$STRING`",
            ["short"] = "When the response was built; a few dated feeds give the date of their newest row instead",
            ["format"] = "date-time",
          },
          {
            ["name"] = "url",
            ["title"] = "Url",
            ["type"] = "`$STRING`",
            ["short"] = "Hub page",
          },
          {
            ["name"] = "valueUsd",
            ["title"] = "Value Usd",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "quantity times price, USD",
          },
        },
        ["name"] = "company",
        ["op"] = {
          ["list"] = {
            ["input"] = "data",
            ["name"] = "list",
            ["points"] = {
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/bitcoin-treasuries",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "bitcoin-treasuries",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "bitcoin-treasuries",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {},
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/buybacks",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "buybacks",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "buybacks",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {},
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/earnings",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "earnings",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "earnings",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "from",
                      ["orig"] = "from",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                    {
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 500,
                    },
                    {
                      ["name"] = "status",
                      ["orig"] = "status",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "ticker",
                      ["orig"] = "ticker",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "NVDA",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "to",
                      ["orig"] = "to",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/events",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "events",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "events",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "day",
                      ["orig"] = "days",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 7,
                    },
                    {
                      ["name"] = "item",
                      ["orig"] = "item",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "5.02",
                    },
                    {
                      ["name"] = "ticker",
                      ["orig"] = "ticker",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "AAPL",
                      ["field"] = true,
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/fails-to-deliver",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "fails-to-deliver",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "fails-to-deliver",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "from",
                      ["orig"] = "from",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                    {
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 400,
                    },
                    {
                      ["name"] = "symbol",
                      ["orig"] = "symbol",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "GME",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "to",
                      ["orig"] = "to",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/federal-contracts",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "federal-contracts",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "federal-contracts",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "by",
                      ["orig"] = "by",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "day",
                      ["orig"] = "days",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 7,
                    },
                    {
                      ["name"] = "listed",
                      ["orig"] = "listed",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "ticker",
                      ["orig"] = "ticker",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "LMT",
                      ["field"] = true,
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/funds",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "funds",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "funds",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {},
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/insiders",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "insiders",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "insiders",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "type",
                      ["orig"] = "type",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "window",
                      ["orig"] = "window",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/insiders/clusters",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "insiders",
                  },
                  {
                    ["lit"] = "clusters",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "insiders",
                  "clusters",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "day",
                      ["orig"] = "days",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 30,
                    },
                    {
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 100,
                    },
                    {
                      ["name"] = "min_insider",
                      ["orig"] = "minInsiders",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "min_usd",
                      ["orig"] = "minUsd",
                      ["type"] = "`$NUMBER`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "ticker",
                      ["orig"] = "ticker",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "NVDA",
                      ["field"] = true,
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/ipos",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "ipos",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "ipos",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "day",
                      ["orig"] = "days",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 90,
                    },
                    {
                      ["name"] = "form",
                      ["orig"] = "form",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "S-1,F-1",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "new",
                      ["orig"] = "new",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/large-holders",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "large-holders",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "large-holders",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "day",
                      ["orig"] = "days",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 30,
                    },
                    {
                      ["name"] = "form",
                      ["orig"] = "form",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "new",
                      ["orig"] = "new",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "sort",
                      ["orig"] = "sort",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "symbol",
                      ["orig"] = "symbol",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "GME",
                      ["field"] = true,
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/planned-sales",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "planned-sales",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "planned-sales",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "day",
                      ["orig"] = "days",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 30,
                    },
                    {
                      ["name"] = "symbol",
                      ["orig"] = "symbol",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "GME",
                      ["field"] = true,
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/short-interest",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "short-interest",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "short-interest",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "symbol",
                      ["orig"] = "symbol",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "GME",
                      ["field"] = true,
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/short-volume",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "short-volume",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "short-volume",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "day",
                      ["orig"] = "days",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 60,
                    },
                    {
                      ["name"] = "from",
                      ["orig"] = "from",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                    {
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 60,
                    },
                    {
                      ["name"] = "sort",
                      ["orig"] = "sort",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "symbol",
                      ["orig"] = "symbol",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "GME",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "to",
                      ["orig"] = "to",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/startup-funding",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "startup-funding",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "startup-funding",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "amendment",
                      ["orig"] = "amendments",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "cik",
                      ["orig"] = "cik",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "day",
                      ["orig"] = "days",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 30,
                    },
                    {
                      ["name"] = "fund",
                      ["orig"] = "funds",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "sort",
                      ["orig"] = "sort",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/structured-products",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "structured-products",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "structured-products",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "cursor",
                      ["orig"] = "cursor",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "day",
                      ["orig"] = "days",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 30,
                    },
                    {
                      ["name"] = "issuer",
                      ["orig"] = "issuer",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "max_coupon",
                      ["orig"] = "maxCoupon",
                      ["type"] = "`$NUMBER`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "min_coupon",
                      ["orig"] = "minCoupon",
                      ["type"] = "`$NUMBER`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "note_type",
                      ["orig"] = "noteType",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "underlying",
                      ["orig"] = "underlying",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "SPX",
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/threshold-list",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "threshold-list",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "threshold-list",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "date",
                      ["orig"] = "date",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 1000,
                    },
                    {
                      ["name"] = "market",
                      ["orig"] = "market",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "symbol",
                      ["orig"] = "symbol",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "GME",
                      ["field"] = true,
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
            },
          },
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/funds/{slug}",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "funds",
                  },
                  {
                    ["var"] = "slug",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "funds",
                  "{slug}",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["params"] = {
                    {
                      ["name"] = "slug",
                      ["orig"] = "slug",
                      ["type"] = "`$STRING`",
                      ["kind"] = "param",
                      ["reqd"] = true,
                      ["example"] = "berkshire-hathaway",
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "slug",
                  },
                },
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/financials",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "financials",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "financials",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "symbol",
                      ["orig"] = "symbol",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["reqd"] = true,
                      ["example"] = "AAPL",
                      ["field"] = true,
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "symbol",
                  },
                },
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/earnings/{ticker}",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "earnings",
                  },
                  {
                    ["var"] = "ticker",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "earnings",
                  "{ticker}",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["params"] = {
                    {
                      ["name"] = "ticker",
                      ["orig"] = "ticker",
                      ["type"] = "`$STRING`",
                      ["kind"] = "param",
                      ["reqd"] = true,
                      ["example"] = "NVDA",
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "ticker",
                  },
                },
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/insiders/{ticker}",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "insiders",
                  },
                  {
                    ["var"] = "ticker",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "insiders",
                  "{ticker}",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["params"] = {
                    {
                      ["name"] = "ticker",
                      ["orig"] = "ticker",
                      ["type"] = "`$STRING`",
                      ["kind"] = "param",
                      ["reqd"] = true,
                      ["example"] = "AAPL",
                    },
                  },
                  ["query"] = {
                    {
                      ["name"] = "from",
                      ["orig"] = "from",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                    {
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 200,
                    },
                    {
                      ["name"] = "to",
                      ["orig"] = "to",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "ticker",
                  },
                },
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["crypto"] = {
        ["fields"] = {
          {
            ["name"] = "asset",
            ["title"] = "Asset",
            ["type"] = "`$STRING`",
            ["short"] = "btc or eth",
          },
          {
            ["name"] = "attribution",
            ["title"] = "Attribution",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "aumUsd",
            ["title"] = "Aum Usd",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Holdings valued in USD",
          },
          {
            ["name"] = "baseAsset",
            ["title"] = "Base Asset",
            ["type"] = "`$STRING`",
            ["short"] = "Base asset ticker (BTC, ETH...)",
          },
          {
            ["name"] = "binanceSymbol",
            ["title"] = "Binance Symbol",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Binance symbol",
          },
          {
            ["name"] = "bitmexSymbol",
            ["title"] = "Bitmex Symbol",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Always null, kept so existing clients parse unchanged",
          },
          {
            ["name"] = "bybitSymbol",
            ["title"] = "Bybit Symbol",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Bybit symbol",
          },
          {
            ["name"] = "canonicalUrl",
            ["title"] = "Canonical Url",
            ["type"] = "`$STRING`",
            ["short"] = "The matching page on xoomar.com",
            ["format"] = "uri",
          },
          {
            ["name"] = "count",
            ["title"] = "Count",
            ["type"] = "`$NUMBER`",
            ["short"] = "Events",
          },
          {
            ["name"] = "data",
            ["title"] = "Data",
            ["type"] = "`$OBJECT`",
          },
          {
            ["name"] = "date",
            ["title"] = "Date",
            ["type"] = "`$STRING`",
            ["short"] = "The as-of date of the issuer file",
            ["format"] = "date",
          },
          {
            ["name"] = "docs",
            ["title"] = "Docs",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "exchange",
            ["title"] = "Exchange",
            ["type"] = "`$STRING`",
            ["short"] = "binance, bybit, okx, hyperliquid or kraken",
          },
          {
            ["name"] = "flowUsd",
            ["title"] = "Flow Usd",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Net flow for the day in USD, derived from the change in the fund's reported holdings",
          },
          {
            ["name"] = "fundingAnnualized",
            ["title"] = "Funding Annualized",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Annualized rate, simple (not compounded), from the rate and its funding interval",
          },
          {
            ["name"] = "fundingIntervalHours",
            ["title"] = "Funding Interval Hours",
            ["type"] = "`$NUMBER`",
            ["short"] = "Hours per settlement: 8 (Binance, Bybit, OKX) or 1 (Hyperliquid, Kraken)",
          },
          {
            ["name"] = "fundingRate",
            ["title"] = "Funding Rate",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Current funding rate as published, a decimal per settlement interval (0.0001 = 0.01% per interval)",
          },
          {
            ["name"] = "fundingRate8h",
            ["title"] = "Funding Rate8h",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "The rate scaled to eight hours, comparable across venues",
          },
          {
            ["name"] = "holdings",
            ["title"] = "Holdings",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Coins held per the issuer file",
          },
          {
            ["name"] = "hour",
            ["title"] = "Hour",
            ["type"] = "`$STRING`",
            ["short"] = "Hour bucket, ISO",
            ["format"] = "date-time",
          },
          {
            ["name"] = "hyperliquidCoin",
            ["title"] = "Hyperliquid Coin",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Hyperliquid coin",
          },
          {
            ["name"] = "id",
            ["title"] = "Id",
            ["type"] = "`$NUMBER`",
            ["short"] = "Event id",
          },
          {
            ["name"] = "issuer",
            ["title"] = "Issuer",
            ["type"] = "`$STRING`",
            ["short"] = "Issuer name",
          },
          {
            ["name"] = "krakenSymbol",
            ["title"] = "Kraken Symbol",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Kraken Futures symbol",
          },
          {
            ["name"] = "license",
            ["title"] = "License",
            ["type"] = "`$STRING`",
            ["short"] = "Data terms",
          },
          {
            ["name"] = "longShortRatio",
            ["title"] = "Long Short Ratio",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Global long/short account ratio where the venue publishes it, else null",
          },
          {
            ["name"] = "longUsd",
            ["title"] = "Long Usd",
            ["type"] = "`$NUMBER`",
            ["short"] = "Long liquidations in USD",
          },
          {
            ["name"] = "markPrice",
            ["title"] = "Mark Price",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Latest mark price in USD",
          },
          {
            ["name"] = "maxSingleUsd",
            ["title"] = "Max Single Usd",
            ["type"] = "`$NUMBER`",
            ["short"] = "Largest single event",
          },
          {
            ["name"] = "meta",
            ["title"] = "Meta",
            ["type"] = "`$OBJECT`",
            ["short"] = "Who publishes the data and how to credit it",
          },
          {
            ["name"] = "nextFundingTime",
            ["title"] = "Next Funding Time",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "ISO timestamp of the next funding settlement",
          },
          {
            ["name"] = "okxInstId",
            ["title"] = "Okx Inst Id",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "OKX instrument id",
          },
          {
            ["name"] = "openInterest",
            ["title"] = "Open Interest",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Open interest in contracts",
          },
          {
            ["name"] = "openInterestValue",
            ["title"] = "Open Interest Value",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Open interest notional in USD",
          },
          {
            ["name"] = "price",
            ["title"] = "Price",
            ["type"] = "`$STRING`",
            ["short"] = "Liquidation price",
          },
          {
            ["name"] = "priceChangePct24h",
            ["title"] = "Price Change Pct24h",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "24h price change as a decimal",
          },
          {
            ["name"] = "qty",
            ["title"] = "Qty",
            ["type"] = "`$STRING`",
            ["short"] = "Quantity in coins",
          },
          {
            ["name"] = "rawSymbol",
            ["title"] = "Raw Symbol",
            ["type"] = "`$STRING`",
            ["short"] = "Contract as the exchange names it",
          },
          {
            ["name"] = "shortUsd",
            ["title"] = "Short Usd",
            ["type"] = "`$NUMBER`",
            ["short"] = "Short liquidations in USD",
          },
          {
            ["name"] = "side",
            ["title"] = "Side",
            ["type"] = "`$STRING`",
            ["short"] = "long (forced sale) or short (forced buy)",
          },
          {
            ["name"] = "slug",
            ["title"] = "Slug",
            ["type"] = "`$STRING`",
            ["short"] = "Symbol slug used in URLs (btc, eth, sol...)",
          },
          {
            ["name"] = "source",
            ["title"] = "Source",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "symbol",
            ["title"] = "Symbol",
            ["type"] = "`$STRING`",
            ["short"] = "Contract (only when filtered)",
          },
          {
            ["name"] = "ticker",
            ["title"] = "Ticker",
            ["type"] = "`$STRING`",
            ["short"] = "Fund ticker (IBIT, ETHA...)",
          },
          {
            ["name"] = "totalUsd",
            ["title"] = "Total Usd",
            ["type"] = "`$NUMBER`",
            ["short"] = "Total in USD",
          },
          {
            ["name"] = "ts",
            ["title"] = "Ts",
            ["type"] = "`$STRING`",
            ["short"] = "Event time, ISO",
            ["format"] = "date-time",
          },
          {
            ["name"] = "updatedAt",
            ["title"] = "Updated At",
            ["type"] = "`$STRING`",
            ["short"] = "When the response was built; a few dated feeds give the date of their newest row instead",
            ["format"] = "date-time",
          },
          {
            ["name"] = "usdValue",
            ["title"] = "Usd Value",
            ["type"] = "`$STRING`",
            ["short"] = "Notional in USD",
          },
        },
        ["id"] = {
          ["field"] = "id",
          ["name"] = "id",
        },
        ["name"] = "crypto",
        ["op"] = {
          ["list"] = {
            ["input"] = "data",
            ["name"] = "list",
            ["points"] = {
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/etf-flows",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "etf-flows",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "etf-flows",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "asset",
                      ["orig"] = "asset",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "day",
                      ["orig"] = "days",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 90,
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/funding-rates",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "funding-rates",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "funding-rates",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {},
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/liquidations/history",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "liquidations",
                  },
                  {
                    ["lit"] = "history",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "liquidations",
                  "history",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "from",
                      ["orig"] = "from",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                    {
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 168,
                    },
                    {
                      ["name"] = "symbol",
                      ["orig"] = "symbol",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "BTCUSDT",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "to",
                      ["orig"] = "to",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/liquidations/recent",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "liquidations",
                  },
                  {
                    ["lit"] = "recent",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "liquidations",
                  "recent",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "exchange",
                      ["orig"] = "exchange",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 100,
                    },
                    {
                      ["name"] = "min_usd",
                      ["orig"] = "minUsd",
                      ["type"] = "`$NUMBER`",
                      ["kind"] = "query",
                      ["example"] = 100000,
                    },
                    {
                      ["name"] = "side",
                      ["orig"] = "side",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "symbol",
                      ["orig"] = "symbol",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "BTCUSDT",
                      ["field"] = true,
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/symbols",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "symbols",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "symbols",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {},
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
            },
          },
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/whales/{coin}",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "whales",
                  },
                  {
                    ["var"] = "coin",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "whales",
                  "{coin}",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["params"] = {
                    {
                      ["name"] = "coin",
                      ["orig"] = "coin",
                      ["type"] = "`$STRING`",
                      ["kind"] = "param",
                      ["reqd"] = true,
                      ["example"] = "btc",
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "coin",
                  },
                },
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/options/{currency}",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "options",
                  },
                  {
                    ["var"] = "currency",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "options",
                  "{currency}",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["params"] = {
                    {
                      ["name"] = "currency",
                      ["orig"] = "currency",
                      ["type"] = "`$STRING`",
                      ["kind"] = "param",
                      ["reqd"] = true,
                      ["example"] = "BTC",
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "currency",
                  },
                },
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/options/{currency}/dvol",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "options",
                  },
                  {
                    ["var"] = "currency",
                  },
                  {
                    ["lit"] = "dvol",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "options",
                  "{currency}",
                  "dvol",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["params"] = {
                    {
                      ["name"] = "currency",
                      ["orig"] = "currency",
                      ["type"] = "`$STRING`",
                      ["kind"] = "param",
                      ["reqd"] = true,
                      ["example"] = "BTC",
                    },
                  },
                  ["query"] = {
                    {
                      ["name"] = "from",
                      ["orig"] = "from",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                    {
                      ["name"] = "to",
                      ["orig"] = "to",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "currency",
                  },
                },
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/funding-rates/{slug}",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "funding-rates",
                  },
                  {
                    ["var"] = "slug",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "funding-rates",
                  "{slug}",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["params"] = {
                    {
                      ["name"] = "slug",
                      ["orig"] = "slug",
                      ["type"] = "`$STRING`",
                      ["kind"] = "param",
                      ["reqd"] = true,
                      ["example"] = "btc",
                    },
                  },
                  ["query"] = {
                    {
                      ["name"] = "history",
                      ["orig"] = "history",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "slug",
                  },
                },
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/open-interest/{slug}",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "open-interest",
                  },
                  {
                    ["var"] = "slug",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "open-interest",
                  "{slug}",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["params"] = {
                    {
                      ["name"] = "slug",
                      ["orig"] = "slug",
                      ["type"] = "`$STRING`",
                      ["kind"] = "param",
                      ["reqd"] = true,
                      ["example"] = "btc",
                    },
                  },
                  ["query"] = {
                    {
                      ["name"] = "from",
                      ["orig"] = "from",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                    {
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 5000,
                    },
                    {
                      ["name"] = "period",
                      ["orig"] = "period",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "to",
                      ["orig"] = "to",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "slug",
                  },
                },
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/sentiment/{slug}",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "sentiment",
                  },
                  {
                    ["var"] = "slug",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "sentiment",
                  "{slug}",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["params"] = {
                    {
                      ["name"] = "slug",
                      ["orig"] = "slug",
                      ["type"] = "`$STRING`",
                      ["kind"] = "param",
                      ["reqd"] = true,
                      ["example"] = "btc",
                    },
                  },
                  ["query"] = {
                    {
                      ["name"] = "history",
                      ["orig"] = "history",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "slug",
                  },
                },
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/signals/{slug}",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "signals",
                  },
                  {
                    ["var"] = "slug",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "signals",
                  "{slug}",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["params"] = {
                    {
                      ["name"] = "slug",
                      ["orig"] = "slug",
                      ["type"] = "`$STRING`",
                      ["kind"] = "param",
                      ["reqd"] = true,
                      ["example"] = "btc",
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "slug",
                  },
                },
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/liquidations",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "liquidations",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "liquidations",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {},
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/sentiment",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "sentiment",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "sentiment",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "asset",
                      ["orig"] = "asset",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "btc",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "kind",
                      ["orig"] = "kind",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "window",
                      ["orig"] = "window",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/whales",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "whales",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "whales",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {},
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["macro"] = {
        ["fields"] = {
          {
            ["name"] = "actual",
            ["title"] = "Actual",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Filled after release from the agency series (CPI year over year %, payrolls monthly change in thousands, retail sales % m/m, claims in thousands, ...)",
          },
          {
            ["name"] = "assetMgrLong",
            ["title"] = "Asset Mgr Long",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Asset managers and institutional investors (tff); swap dealers (disagg)",
          },
          {
            ["name"] = "assetMgrShort",
            ["title"] = "Asset Mgr Short",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Asset managers and institutional investors (tff); swap dealers (disagg)",
          },
          {
            ["name"] = "assets",
            ["title"] = "Assets",
            ["type"] = "`$NUMBER`",
            ["short"] = "Fed total assets, USD (WALCL)",
          },
          {
            ["name"] = "attribution",
            ["title"] = "Attribution",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "auctionDate",
            ["title"] = "Auction Date",
            ["type"] = "`$STRING`",
            ["short"] = "Auction date",
            ["format"] = "date",
          },
          {
            ["name"] = "bidToCover",
            ["title"] = "Bid To Cover",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Tendered divided by accepted",
          },
          {
            ["name"] = "canonicalUrl",
            ["title"] = "Canonical Url",
            ["type"] = "`$STRING`",
            ["short"] = "The matching page on xoomar.com",
            ["format"] = "uri",
          },
          {
            ["name"] = "country",
            ["title"] = "Country",
            ["type"] = "`$STRING`",
            ["short"] = "Economy",
          },
          {
            ["name"] = "countryCode",
            ["title"] = "Country Code",
            ["type"] = "`$STRING`",
            ["short"] = "BIS area code",
          },
          {
            ["name"] = "cusip",
            ["title"] = "Cusip",
            ["type"] = "`$STRING`",
            ["short"] = "Security CUSIP; a reopening shares the original's CUSIP",
          },
          {
            ["name"] = "data",
            ["title"] = "Data",
            ["type"] = "`$ARRAY`",
          },
          {
            ["name"] = "date",
            ["title"] = "Date",
            ["type"] = "`$STRING`",
            ["short"] = "H.4.1 Wednesday date",
            ["format"] = "date",
          },
          {
            ["name"] = "dealerAccepted",
            ["title"] = "Dealer Accepted",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Accepted by primary dealers, USD",
          },
          {
            ["name"] = "dealerLong",
            ["title"] = "Dealer Long",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Dealers and intermediaries (tff); producers, merchants, processors and users (disagg)",
          },
          {
            ["name"] = "dealerShare",
            ["title"] = "Dealer Share",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Dealer share of accepted, 0 to 1",
          },
          {
            ["name"] = "dealerShort",
            ["title"] = "Dealer Short",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Dealers and intermediaries (tff); producers, merchants, processors and users (disagg)",
          },
          {
            ["name"] = "directAccepted",
            ["title"] = "Direct Accepted",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Accepted from direct bidders, USD",
          },
          {
            ["name"] = "directShare",
            ["title"] = "Direct Share",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Direct share of accepted, 0 to 1",
          },
          {
            ["name"] = "docs",
            ["title"] = "Docs",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "eventName",
            ["title"] = "Event Name",
            ["type"] = "`$STRING`",
            ["short"] = "CPI (Consumer Price Index), Nonfarm Payrolls (Employment Situation), Initial Jobless Claims, Retail Sales (Advance), FOMC Rate Decision, ...",
          },
          {
            ["name"] = "forecast",
            ["title"] = "Forecast",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Always null: consensus forecasts aren't included",
          },
          {
            ["name"] = "group",
            ["title"] = "Group",
            ["type"] = "`$STRING`",
            ["short"] = "currencies, indices, crypto, metals, energy, bonds, agriculture, other",
          },
          {
            ["name"] = "highRate",
            ["title"] = "High Rate",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "High discount rate (bills) or high discount margin (FRNs), percent",
          },
          {
            ["name"] = "highYield",
            ["title"] = "High Yield",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Stop-out yield, percent (notes, bonds, TIPS)",
          },
          {
            ["name"] = "importance",
            ["title"] = "Importance",
            ["type"] = "`$STRING`",
            ["short"] = "high, med, or low",
          },
          {
            ["name"] = "indirectAccepted",
            ["title"] = "Indirect Accepted",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Accepted from indirect bidders, USD",
          },
          {
            ["name"] = "indirectShare",
            ["title"] = "Indirect Share",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Indirect share of accepted, 0 to 1",
          },
          {
            ["name"] = "interestRate",
            ["title"] = "Interest Rate",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Coupon set at auction, percent",
          },
          {
            ["name"] = "issueDate",
            ["title"] = "Issue Date",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Settlement date",
            ["format"] = "date",
          },
          {
            ["name"] = "lastChanged",
            ["title"] = "Last Changed",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Date of the most recent move",
          },
          {
            ["name"] = "levFundLong",
            ["title"] = "Lev Fund Long",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Leveraged funds (tff); managed money (disagg)",
          },
          {
            ["name"] = "levFundShort",
            ["title"] = "Lev Fund Short",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Leveraged funds (tff); managed money (disagg)",
          },
          {
            ["name"] = "license",
            ["title"] = "License",
            ["type"] = "`$STRING`",
            ["short"] = "Data terms",
          },
          {
            ["name"] = "m1_m6",
            ["title"] = "M1 M6",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "1, 2, 3, 6 month Treasury yields in percent",
          },
          {
            ["name"] = "maturityDate",
            ["title"] = "Maturity Date",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Maturity",
            ["format"] = "date",
          },
          {
            ["name"] = "meta",
            ["title"] = "Meta",
            ["type"] = "`$OBJECT`",
            ["short"] = "Who publishes the data and how to credit it",
          },
          {
            ["name"] = "name",
            ["title"] = "Name",
            ["type"] = "`$STRING`",
            ["short"] = "CFTC contract market name",
          },
          {
            ["name"] = "net",
            ["title"] = "Net",
            ["type"] = "`$NUMBER`",
            ["short"] = "assets minus tga minus rrp, USD",
          },
          {
            ["name"] = "nonreptLong",
            ["title"] = "Nonrept Long",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Non-reportable (small trader) positions",
          },
          {
            ["name"] = "nonreptShort",
            ["title"] = "Nonrept Short",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Non-reportable (small trader) positions",
          },
          {
            ["name"] = "offeringAmount",
            ["title"] = "Offering Amount",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Announced size, USD",
          },
          {
            ["name"] = "openInterest",
            ["title"] = "Open Interest",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Total open interest in contracts",
          },
          {
            ["name"] = "otherLong",
            ["title"] = "Other Long",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Other reportable positions",
          },
          {
            ["name"] = "otherShort",
            ["title"] = "Other Short",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Other reportable positions",
          },
          {
            ["name"] = "periodLabel",
            ["title"] = "Period Label",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Reference period: 'August 2026', '3rd Quarter 2026', 'Week ending 2026-09-05'",
          },
          {
            ["name"] = "previous",
            ["title"] = "Previous",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "Prior period on the same basis as actual",
          },
          {
            ["name"] = "rate",
            ["title"] = "Rate",
            ["type"] = "`$STRING`",
            ["short"] = "Policy rate, percent",
          },
          {
            ["name"] = "reopening",
            ["title"] = "Reopening",
            ["type"] = {
              "`$ONE`",
              {
                "`$BOOLEAN`",
                "`$NULL`",
              },
            },
            ["short"] = "True when the auction adds to an existing issue",
          },
          {
            ["name"] = "reportDate",
            ["title"] = "Report Date",
            ["type"] = "`$STRING`",
            ["short"] = "CFTC report Tuesday, YYYY-MM-DD",
            ["format"] = "date",
          },
          {
            ["name"] = "reportType",
            ["title"] = "Report Type",
            ["type"] = "`$STRING`",
            ["short"] = "tff (financial futures) or disagg (commodities)",
          },
          {
            ["name"] = "reserves",
            ["title"] = "Reserves",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Reserve balances with Federal Reserve Banks, USD (WRESBAL)",
          },
          {
            ["name"] = "rrp",
            ["title"] = "Rrp",
            ["type"] = "`$NUMBER`",
            ["short"] = "Overnight reverse repo usage on that date, USD (RRPONTSYD)",
          },
          {
            ["name"] = "scheduledAt",
            ["title"] = "Scheduled At",
            ["type"] = "`$STRING`",
            ["short"] = "Release time, UTC",
            ["format"] = "date-time",
          },
          {
            ["name"] = "securityTerm",
            ["title"] = "Security Term",
            ["type"] = "`$STRING`",
            ["short"] = "Term as announced: 4-Week, 2-Year, 10-Year, 9-Year 10-Month (reopening)",
          },
          {
            ["name"] = "securityType",
            ["title"] = "Security Type",
            ["type"] = "`$STRING`",
            ["short"] = "Bill, CMB (cash management bill), Note, Bond, TIPS or FRN",
          },
          {
            ["name"] = "slug",
            ["title"] = "Slug",
            ["type"] = "`$STRING`",
            ["short"] = "Market slug for URLs (euro-fx, gold...)",
          },
          {
            ["name"] = "sortRank",
            ["title"] = "Sort Rank",
            ["type"] = "`$NUMBER`",
            ["short"] = "Display order within the group",
          },
          {
            ["name"] = "source",
            ["title"] = "Source",
            ["type"] = "`$STRING`",
            ["short"] = "bls, bea, census, fed, dol or treasury (coupon auctions)",
          },
          {
            ["name"] = "tga",
            ["title"] = "Tga",
            ["type"] = "`$NUMBER`",
            ["short"] = "Treasury General Account, USD (WTREGEN)",
          },
          {
            ["name"] = "totalAccepted",
            ["title"] = "Total Accepted",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Accepted, USD (null until results)",
          },
          {
            ["name"] = "totalTendered",
            ["title"] = "Total Tendered",
            ["type"] = {
              "`$ONE`",
              {
                "`$NUMBER`",
                "`$NULL`",
              },
            },
            ["short"] = "Bids received, USD",
          },
          {
            ["name"] = "unit",
            ["title"] = "Unit",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "What actual and previous are in: '% m/m', '% y/y, PCE price index', 'thousands, annual rate', 'USD billions, balance'",
          },
          {
            ["name"] = "updatedAt",
            ["title"] = "Updated At",
            ["type"] = "`$STRING`",
            ["short"] = "When the response was built; a few dated feeds give the date of their newest row instead",
            ["format"] = "date-time",
          },
          {
            ["name"] = "y1_y30",
            ["title"] = "Y1 Y30",
            ["type"] = {
              "`$ONE`",
              {
                "`$STRING`",
                "`$NULL`",
              },
            },
            ["short"] = "1 to 30 year Treasury yields in percent",
          },
        },
        ["name"] = "macro",
        ["op"] = {
          ["list"] = {
            ["input"] = "data",
            ["name"] = "list",
            ["points"] = {
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/calendar",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "calendar",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "calendar",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "from",
                      ["orig"] = "from",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                    {
                      ["name"] = "importance",
                      ["orig"] = "importance",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["field"] = true,
                    },
                    {
                      ["name"] = "to",
                      ["orig"] = "to",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/cot",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "cot",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "cot",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {},
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/fed-liquidity",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "fed-liquidity",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "fed-liquidity",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 5000,
                    },
                    {
                      ["name"] = "series",
                      ["orig"] = "series",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/macro",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "macro",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "macro",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "from",
                      ["orig"] = "from",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                    {
                      ["name"] = "series",
                      ["orig"] = "series",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "to",
                      ["orig"] = "to",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/rates",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "rates",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "rates",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {},
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/treasury-auctions",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "treasury-auctions",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "treasury-auctions",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["args"] = {
                  ["query"] = {
                    {
                      ["name"] = "from",
                      ["orig"] = "from",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                    {
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["type"] = "`$INTEGER`",
                      ["kind"] = "query",
                      ["example"] = 100,
                    },
                    {
                      ["name"] = "term",
                      ["orig"] = "term",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "10-Year",
                    },
                    {
                      ["name"] = "to",
                      ["orig"] = "to",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                    {
                      ["name"] = "type",
                      ["orig"] = "type",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                    },
                    {
                      ["name"] = "upcoming",
                      ["orig"] = "upcoming",
                      ["type"] = "`$BOOLEAN`",
                      ["kind"] = "query",
                    },
                  },
                },
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
            },
          },
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/rates/{country}",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "rates",
                  },
                  {
                    ["var"] = "country",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "rates",
                  "{country}",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["params"] = {
                    {
                      ["name"] = "country",
                      ["orig"] = "country",
                      ["type"] = "`$STRING`",
                      ["kind"] = "param",
                      ["reqd"] = true,
                      ["example"] = "us",
                    },
                  },
                  ["query"] = {
                    {
                      ["name"] = "from",
                      ["orig"] = "from",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                    {
                      ["name"] = "to",
                      ["orig"] = "to",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "country",
                  },
                },
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/api/markets/cot/{slug}",
                ["segments"] = {
                  {
                    ["lit"] = "api",
                  },
                  {
                    ["lit"] = "markets",
                  },
                  {
                    ["lit"] = "cot",
                  },
                  {
                    ["var"] = "slug",
                  },
                },
                ["parts"] = {
                  "api",
                  "markets",
                  "cot",
                  "{slug}",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {
                  ["params"] = {
                    {
                      ["name"] = "slug",
                      ["orig"] = "slug",
                      ["type"] = "`$STRING`",
                      ["kind"] = "param",
                      ["reqd"] = true,
                      ["example"] = "e-mini-s-p-500-stock-index",
                    },
                  },
                  ["query"] = {
                    {
                      ["name"] = "from",
                      ["orig"] = "from",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                    {
                      ["name"] = "to",
                      ["orig"] = "to",
                      ["type"] = "`$STRING`",
                      ["kind"] = "query",
                      ["example"] = "2026-01-01",
                    },
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "slug",
                  },
                },
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
    },
  }
end


local function make_feature(name)
  local features = require("features")
  local factory = features[name]
  if factory ~= nil then
    return factory()
  end
  return features.base()
end


-- Attach make_feature to the SDK class
local function setup_sdk(SDK)
  SDK._make_feature = make_feature
end


return make_config
