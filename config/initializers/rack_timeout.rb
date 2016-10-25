if Rails.env.production?
  Rack::Timeout.timeout = 25  # seconds
else
  Rack::Timeout.timeout = 0  # disable
end
