if Rails.env.production?
  Rack::Timeout.service_timeout = 25  # seconds
end
# Note: rack-timeout is disabled by default in development/test environments
