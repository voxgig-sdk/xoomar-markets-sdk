# XoomarMarkets SDK utility: make_context
require_relative '../core/context'
module XoomarMarketsUtilities
  MakeContext = ->(ctxmap, basectx) {
    XoomarMarketsContext.new(ctxmap, basectx)
  }
end
