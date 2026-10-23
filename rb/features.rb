# XoomarMarkets SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'


module XoomarMarketsFeatures
  def self.make_feature(name)
    case name
    when "base"
      XoomarMarketsBaseFeature.new
    when "ratelimit"
      XoomarMarketsRatelimitFeature.new
    when "retry"
      XoomarMarketsRetryFeature.new
    when "test"
      XoomarMarketsTestFeature.new
    when "timeout"
      XoomarMarketsTimeoutFeature.new
    else
      XoomarMarketsBaseFeature.new
    end
  end
end
