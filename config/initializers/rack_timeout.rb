# rack-timeout 0.7.0 uses environment variables for configuration
# Set RACK_TIMEOUT_SERVICE_TIMEOUT environment variable (default is 15 seconds)
# For Heroku, you can set this in your Heroku config:
# heroku config:set RACK_TIMEOUT_SERVICE_TIMEOUT=25
# 
# Alternatively, you can configure it here using ENV:
# ENV['RACK_TIMEOUT_SERVICE_TIMEOUT'] ||= '25' if Rails.env.production?

# rack-timeout is automatically configured via Rails middleware
# It reads from RACK_TIMEOUT_SERVICE_TIMEOUT env var (default: 15 seconds)
