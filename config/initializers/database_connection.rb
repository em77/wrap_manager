# Establish database connection at boot time to avoid slow first connection
# Rails 6.1 seems to have slow initial database connection establishment
# This ensures the connection pool is ready before handling requests
# DISABLED: Was causing issues with stale connections using wrong IP
# The connection will be established on first request instead
# Rails.application.config.after_initialize do
#   if Rails.env.production?
#     begin
#       # Clear any stale connections first
#       ActiveRecord::Base.connection_pool.disconnect! if ActiveRecord::Base.connection_pool
#       # Establish a fresh connection to the database during boot
#       conn = ActiveRecord::Base.connection
#       conn.execute("SELECT 1")
#       Rails.logger.info "Database connection established and verified at boot time"
#     rescue => e
#       Rails.logger.warn "Failed to establish database connection at boot: #{e.message}"
#       # Don't fail boot if connection fails - it will retry on first request
#     end
#   end
# end

