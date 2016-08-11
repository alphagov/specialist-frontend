# Be sure to restart your server when you modify this file.
require 'gds_api/base'

DEFAULT_CACHE_TIME_IN_SECONDS=10

GdsApi.config.always_raise_for_not_found = true

GdsApi::Base.default_options = { cache_ttl: DEFAULT_CACHE_TIME_IN_SECONDS }

if Rails.env.development?
  GdsApi::Base.default_options = { disable_cache: true }
end
