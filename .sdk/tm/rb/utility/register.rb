# XoomarMarkets SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'graphql'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

XoomarMarketsUtility.registrar = ->(u) {
  u.clean = XoomarMarketsUtilities::Clean
  u.clean_add = XoomarMarketsUtilities::CleanAdd
  u.clean_explain = XoomarMarketsUtilities::CleanExplain
  u.done = XoomarMarketsUtilities::Done
  u.make_error = XoomarMarketsUtilities::MakeError
  u.feature_add = XoomarMarketsUtilities::FeatureAdd
  u.feature_hook = XoomarMarketsUtilities::FeatureHook
  u.feature_init = XoomarMarketsUtilities::FeatureInit
  u.fetcher = XoomarMarketsUtilities::Fetcher
  u.make_fetch_def = XoomarMarketsUtilities::MakeFetchDef
  u.make_context = XoomarMarketsUtilities::MakeContext
  u.make_options = XoomarMarketsUtilities::MakeOptions
  u.make_request = XoomarMarketsUtilities::MakeRequest
  u.make_response = XoomarMarketsUtilities::MakeResponse
  u.make_result = XoomarMarketsUtilities::MakeResult
  u.make_point = XoomarMarketsUtilities::MakePoint
  u.make_spec = XoomarMarketsUtilities::MakeSpec
  u.make_url = XoomarMarketsUtilities::MakeUrl
  u.param = XoomarMarketsUtilities::Param
  u.prepare_auth = XoomarMarketsUtilities::PrepareAuth
  u.prepare_body = XoomarMarketsUtilities::PrepareBody
  u.prepare_headers = XoomarMarketsUtilities::PrepareHeaders
  u.prepare_method = XoomarMarketsUtilities::PrepareMethod
  u.prepare_params = XoomarMarketsUtilities::PrepareParams
  u.prepare_path = XoomarMarketsUtilities::PreparePath
  u.prepare_query = XoomarMarketsUtilities::PrepareQuery
  u.graphql_body = XoomarMarketsUtilities::GraphqlBody
  u.graphql_errors = XoomarMarketsUtilities::GraphqlErrors
  u.result_basic = XoomarMarketsUtilities::ResultBasic
  u.result_body = XoomarMarketsUtilities::ResultBody
  u.result_headers = XoomarMarketsUtilities::ResultHeaders
  u.transform_request = XoomarMarketsUtilities::TransformRequest
  u.transform_response = XoomarMarketsUtilities::TransformResponse
}
