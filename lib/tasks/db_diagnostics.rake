namespace :db do
  desc "Diagnose database connection issues"
  task diagnose: :environment do
    puts "=" * 60
    puts "Database Connection Diagnostics"
    puts "=" * 60
    puts
    
    # 1. Check database configuration
    puts "1. Database Configuration:"
    db_config = ActiveRecord::Base.connection_db_config.configuration_hash
    puts "   Adapter: #{db_config[:adapter]}"
    puts "   Database: #{db_config[:database]}"
    puts "   Pool size: #{db_config[:pool] || 'default (5)'}"
    puts "   Checkout timeout: #{db_config[:checkout_timeout] || 'default (5 seconds)'}"
    puts "   Reaping frequency: #{db_config[:reaping_frequency] || 'default'}"
    puts
    
    # 2. Test basic connection
    puts "2. Testing basic connection..."
    begin
      start_time = Time.now
      result = ActiveRecord::Base.connection.execute("SELECT 1 as test")
      elapsed = ((Time.now - start_time) * 1000).round(2)
      puts "   ✓ Connection successful (took #{elapsed}ms)"
      puts "   Result: #{result.first}"
    rescue => e
      puts "   ✗ Connection failed: #{e.class}: #{e.message}"
      puts "   #{e.backtrace.first}"
    end
    puts
    
    # 3. Check connection pool status
    puts "3. Connection Pool Status:"
    pool = ActiveRecord::Base.connection_pool
    puts "   Total connections: #{pool.stat[:size]}"
    puts "   Available: #{pool.stat[:available]}"
    puts "   Checked out: #{pool.stat[:checked_out]}"
    puts "   Waiting: #{pool.stat[:waiting]}"
    puts
    
    # 4. Test query performance
    puts "4. Testing query performance..."
    queries = [
      "SELECT COUNT(*) FROM users",
      "SELECT * FROM users LIMIT 1"
    ]
    # Add remember_tokens query if table exists
    if ActiveRecord::Base.connection.table_exists?('remember_tokens')
      queries << "SELECT * FROM remember_tokens LIMIT 1"
    end
    
    queries.each do |query|
      begin
        start_time = Time.now
        ActiveRecord::Base.connection.execute(query)
        elapsed = ((Time.now - start_time) * 1000).round(2)
        puts "   ✓ #{query[0..50]}... (#{elapsed}ms)"
      rescue => e
        elapsed = ((Time.now - start_time) * 1000).round(2)
        puts "   ✗ #{query[0..50]}... (#{elapsed}ms) - #{e.class}: #{e.message}"
      end
    end
    puts
    
    # 5. Test simple ActiveRecord query
    puts "5. Testing ActiveRecord User query..."
    begin
      start_time = Time.now
      count = User.count
      elapsed = ((Time.now - start_time) * 1000).round(2)
      puts "   ✓ User.count completed (#{elapsed}ms)"
      puts "   Result: #{count} users"
    rescue => e
      elapsed = ((Time.now - start_time) * 1000).round(2)
      puts "   ✗ User.count failed (#{elapsed}ms)"
      puts "   Error: #{e.class}: #{e.message}"
      puts "   #{e.backtrace.first(3).join("\n   ")}"
    end
    puts
    
    # 6. Check for remember_me tokens
    if ActiveRecord::Base.connection.table_exists?('remember_tokens')
      puts "6. Remember Tokens Table:"
      begin
        count = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM remember_tokens").first['count'].to_i
        puts "   Total remember tokens: #{count}"
        if count > 0
          puts "   Sample tokens:"
          tokens = ActiveRecord::Base.connection.execute("SELECT token, user_id, expires_at FROM remember_tokens LIMIT 5")
          tokens.each do |token|
            puts "     - User ID: #{token['user_id']}, Expires: #{token['expires_at']}"
          end
        end
      rescue => e
        puts "   ✗ Error querying remember_tokens: #{e.message}"
      end
    else
      puts "6. Remember Tokens Table: not found"
    end
    puts
    
    # 7. Database URL check (for Heroku)
    if ENV['DATABASE_URL']
      puts "7. DATABASE_URL:"
      db_url = ENV['DATABASE_URL']
      # Hide password
      db_url_display = db_url.gsub(/(:\/\/)([^:]+):([^@]+)@/, '\1\2:***@')
      puts "   #{db_url_display}"
      
      # Parse and show connection details
      uri = URI.parse(db_url)
      puts "   Host: #{uri.host}"
      puts "   Port: #{uri.port}"
      puts "   Database: #{uri.path.gsub(/^\//, '')}"
    end
    puts
    
    # 8. Test remember_tokens query (what logged_in? does with remember_me)
    if ActiveRecord::Base.connection.table_exists?('remember_tokens')
      puts "8. Testing remember_tokens query (what logged_in? does)..."
      begin
        start_time = Time.now
        # Simulate what Sorcery does: find token by token value
        result = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM remember_tokens WHERE expires_at > NOW()")
        elapsed = ((Time.now - start_time) * 1000).round(2)
        puts "   ✓ remember_tokens query completed (#{elapsed}ms)"
        puts "   Active tokens: #{result.first['count']}"
      rescue => e
        elapsed = ((Time.now - start_time) * 1000).round(2)
        puts "   ✗ remember_tokens query failed (#{elapsed}ms)"
        puts "   Error: #{e.class}: #{e.message}"
        puts "   #{e.backtrace.first(3).join("\n   ")}"
      end
    end
    puts
    
    puts "=" * 60
    puts "Diagnostics complete"
    puts "=" * 60
  end
end

