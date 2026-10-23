package voxgigxoomarmarketssdk

import (
	"github.com/voxgig-sdk/xoomar-markets-sdk/go/core"
	"github.com/voxgig-sdk/xoomar-markets-sdk/go/entity"
	"github.com/voxgig-sdk/xoomar-markets-sdk/go/feature"
	_ "github.com/voxgig-sdk/xoomar-markets-sdk/go/utility"
)

// Type aliases preserve external API.
type XoomarMarketsSDK = core.XoomarMarketsSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type XoomarMarketsEntity = core.XoomarMarketsEntity
type StreamItem = core.StreamItem
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type XoomarMarketsError = core.XoomarMarketsError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewRatelimitFeatureFunc = func() core.Feature {
		return feature.NewRatelimitFeature()
	}
	core.NewRetryFeatureFunc = func() core.Feature {
		return feature.NewRetryFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewTimeoutFeatureFunc = func() core.Feature {
		return feature.NewTimeoutFeature()
	}
	core.NewCompanyEntityFunc = func(client *core.XoomarMarketsSDK, entopts map[string]any) core.XoomarMarketsEntity {
		return entity.NewCompanyEntity(client, entopts)
	}
	core.NewCryptoEntityFunc = func(client *core.XoomarMarketsSDK, entopts map[string]any) core.XoomarMarketsEntity {
		return entity.NewCryptoEntity(client, entopts)
	}
	core.NewMacroEntityFunc = func(client *core.XoomarMarketsSDK, entopts map[string]any) core.XoomarMarketsEntity {
		return entity.NewMacroEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewXoomarMarketsSDK = core.NewXoomarMarketsSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var SharedConfig = core.SharedConfig

// No-arg convenience constructors. Go has no default-argument syntax,
// so these aliases let callers write `sdk.New()` / `sdk.Test()`
// instead of `sdk.NewXoomarMarketsSDK(nil)` / `sdk.TestSDK(nil, nil)`
// for the common no-options case.
func New() *XoomarMarketsSDK  { return NewXoomarMarketsSDK(nil) }
func Test() *XoomarMarketsSDK { return TestSDK(nil, nil) }
var NewBaseFeature = feature.NewBaseFeature
var NewRatelimitFeature = feature.NewRatelimitFeature
var NewRetryFeature = feature.NewRetryFeature
var NewTestFeature = feature.NewTestFeature
var NewTimeoutFeature = feature.NewTimeoutFeature
