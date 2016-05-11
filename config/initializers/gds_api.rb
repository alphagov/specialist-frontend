require 'gds_api/base'

DEFAULT_CACHE_TIME_IN_SECONDS=10

GdsApi::Base.default_options = { cache_ttl: DEFAULT_CACHE_TIME_IN_SECONDS }

if Rails.env.development?
  GdsApi::Base.default_options = { disable_cache: true }
end

