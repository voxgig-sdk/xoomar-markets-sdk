# XoomarMarkets SDK utility: prepare_body
require_relative 'media'
module XoomarMarketsUtilities
  PrepareBody = ->(ctx) {
    return nil unless ctx.op.input == "data"
    return XoomarMarketsUtilities.raw_body(ctx.reqdata) if XoomarMarketsUtilities.raw_request?(ctx.point)
    ctx.utility.transform_request.call(ctx)
  }
end
