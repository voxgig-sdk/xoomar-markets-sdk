package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewRatelimitFeatureFunc func() Feature

var NewRetryFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewTimeoutFeatureFunc func() Feature

var NewCompanyEntityFunc func(client *XoomarMarketsSDK, entopts map[string]any) XoomarMarketsEntity

var NewCryptoEntityFunc func(client *XoomarMarketsSDK, entopts map[string]any) XoomarMarketsEntity

var NewMacroEntityFunc func(client *XoomarMarketsSDK, entopts map[string]any) XoomarMarketsEntity

