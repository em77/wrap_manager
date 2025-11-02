# Heroku Rails 6 Recommended Settings Review

## Current Configuration vs. Heroku Recommendations

### 1. Database Configuration (`config/database.yml`)

**Heroku Recommendation:**
- Use `url: <%= ENV['DATABASE_URL'] %>` for production
- Pool size should match `RAILS_MAX_THREADS`
- No need for explicit `connect_timeout` unless you have connection issues

**Current Configuration:**
```yaml
production:
  <<: *default
  url: <%= ENV['DATABASE_URL'] %>  ✅ Correct
  connect_timeout: 10  ⚠️ Not standard, but helpful for our issue
  pool: <%= [ENV.fetch("RAILS_MAX_THREADS", 5).to_i + 2, 5].max %>  ⚠️ Custom logic
```

**Analysis:**
- `url: <%= ENV['DATABASE_URL'] %>` ✅ **Correct** - Following Heroku best practice
- `connect_timeout: 10` ⚠️ **Non-standard but needed** - Helps prevent 66-second hangs
- Pool size logic ⚠️ **Over-complicated** - Heroku typically recommends: `pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>`

**Recommendation:**
- Keep `connect_timeout: 10` for now (it's solving our timeout issue)
- Simplify pool size to match Heroku's recommendation: `pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>`
- However, since `RAILS_MAX_THREADS=1` on your dyno, but you have concurrent DB queries (remember_me checks), you might need a pool of 2-3

### 2. Puma Configuration (`config/puma.rb`)

**Heroku Recommendation:**
- Use `RAILS_MAX_THREADS` for thread count
- No workers needed for single dyno
- Default configuration should work

**Current Configuration:**
```ruby
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }  ✅ Correct
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }  ✅ Correct
threads min_threads_count, max_threads_count  ✅ Correct
```

**Analysis:**
- ✅ **All correct** - Following Heroku recommendations

### 3. Environment Variables

**Heroku Recommendation:**
- `RAILS_ENV=production` (set automatically by Heroku)
- `RAILS_SERVE_STATIC_FILES=true` (if serving static files)
- `RAILS_LOG_TO_STDOUT=true` (set automatically by Heroku)
- `RAILS_MAX_THREADS` should be set (defaults to 5, but Heroku sets it to 1 for single dyno)

**Current Status:**
- `RAILS_MAX_THREADS=1` ✅ (as shown in Heroku config)

### 4. Production Environment (`config/environments/production.rb`)

**Heroku Recommendation:**
- Use default Rails 6.1 settings
- `config.force_ssl = true` for HTTPS

**Current Configuration:**
- ✅ `config.load_defaults 6.1` - Correct
- ✅ `config.force_ssl = true` - Correct
- ✅ All other settings look standard

## Recommendations

### Option 1: Simplify to Match Heroku Standards
```yaml
production:
  <<: *default
  url: <%= ENV['DATABASE_URL'] %>
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  # Keep connect_timeout for now to prevent hangs
  connect_timeout: 10
```

### Option 2: Keep Current (If Concurrent Queries Need It)
```yaml
production:
  <<: *default
  url: <%= ENV['DATABASE_URL'] %>
  pool: <%= [ENV.fetch("RAILS_MAX_THREADS", 5).to_i + 2, 5].max %>
  connect_timeout: 10
```

**Note:** Option 2 might be needed if you have concurrent database queries within a single request (like remember_me token checks happening while rendering views).

