# Establish database connection at boot time to avoid slow first connection
# Rails 6.1 has slow initial database connection establishment (20+ seconds)
# This moves the delay to dyno startup instead of the first request
# Note: Do this in the main thread so the connection is available to Puma workers
Rails.application.config.after_initialize do
  if Rails.env.production?
    begin
      # Establish a connection in the main thread during boot
      # This triggers schema loading (~20 seconds) during dyno startup
      # The connection will be available in the pool for request threads
      start_time = Time.now
      conn = ActiveRecord::Base.connection
      conn.execute("SELECT 1")
      elapsed = ((Time.now - start_time) * 1000).round(2)
      Rails.logger.info "Database connection established and verified at boot time (took #{elapsed}ms)"
    rescue => e
      Rails.logger.warn "Failed to establish database connection at boot: #{e.message}"
      Rails.logger.warn e.backtrace.first(3).join("\n")
      # Don't fail boot if connection fails - it will retry on first request
    end
  end
end

