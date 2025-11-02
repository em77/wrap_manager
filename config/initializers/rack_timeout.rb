# rack-timeout 0.7.0 uses environment variables for configuration
# Set RACK_TIMEOUT_SERVICE_TIMEOUT environment variable (default is 15 seconds)
# For Heroku, you can set this in your Heroku config:
# heroku config:set RACK_TIMEOUT_SERVICE_TIMEOUT=30

# Configure rack-timeout for production to allow database connections time to establish
# Rails 6.1 seems to have slow initial database connections, so we increase timeout
ENV['RACK_TIMEOUT_SERVICE_TIMEOUT'] ||= '30' if Rails.env.production?

# rack-timeout is automatically configured via Rails middleware
# It reads from RACK_TIMEOUT_SERVICE_TIMEOUT env var (default: 15 seconds)
