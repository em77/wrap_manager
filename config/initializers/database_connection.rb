# Establish database connection at boot time to avoid slow first connection
# Rails 6.1 has slow initial database connection establishment (20+ seconds)
# This moves the delay to dyno startup instead of the first request
Rails.application.config.after_initialize do
  if Rails.env.production?
    Thread.new do
      begin
        # Clear any stale connections first
        if ActiveRecord::Base.connection_pool
          ActiveRecord::Base.connection_pool.disconnect!
        end
        
        # Establish a fresh connection to the database during boot
        # This will trigger schema loading which takes ~20 seconds
        # But it happens during dyno startup, not during a request
        conn = ActiveRecord::Base.connection
        conn.execute("SELECT 1")
        Rails.logger.info "Database connection established and verified at boot time"
      rescue => e
        Rails.logger.warn "Failed to establish database connection at boot: #{e.message}"
        # Don't fail boot if connection fails - it will retry on first request
      end
    end
  end
end

