require 'gds_api/base'

if Rails.env.development?
  GdsApi::Base.default_options = { disable_cache: true }
end

