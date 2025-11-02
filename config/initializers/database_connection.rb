# Establish database connection at boot time to avoid slow first connection
# Rails 6.1 seems to have slow initial database connection establishment
# This ensures the connection pool is ready before handling requests
Rails.application.config.after_initialize do
  if Rails.env.production?
    begin
      # Establish a connection to the database during boot
      # This prevents the 66+ second delay on the first request
      # Also verify the connection is actually working
      conn = ActiveRecord::Base.connection
      conn.execute("SELECT 1")
      # Verify connection is active (not stale)
      unless conn.active?
        conn.reconnect!
        conn.execute("SELECT 1")
      end
      Rails.logger.info "Database connection established and verified at boot time"
    rescue => e
      Rails.logger.warn "Failed to establish database connection at boot: #{e.message}"
      # Don't fail boot if connection fails - it will retry on first request
    end
  end
end

