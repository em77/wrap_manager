# Database Diagnostics Guide

## Quick Commands to Check Database Health

### 1. Check Database Status on Heroku
```bash
# Replace YOUR_APP_NAME with your Heroku app name
heroku pg:info -a YOUR_APP_NAME

# Check database connections
heroku pg:connections -a YOUR_APP_NAME
```

### 2. Test Basic Database Connection
```bash
# On Heroku
heroku run rails runner "puts ActiveRecord::Base.connection.execute('SELECT 1').first"

# Test connection speed
heroku run rails runner "start=Time.now; ActiveRecord::Base.connection.execute('SELECT 1'); puts 'Connection time: #{(Time.now - start) * 1000}ms'"
```

### 3. Run Full Diagnostics
```bash
# On Heroku
heroku run rake db:diagnose
```

### 4. Check Heroku Logs for Database Errors
```bash
# Watch logs in real-time
heroku logs --tail -a YOUR_APP_NAME

# Look for database-related errors
heroku logs --tail -a YOUR_APP_NAME | grep -i "database\|connection\|timeout\|pg"
```

### 5. Check Active Database Queries
```bash
# See what queries are running (if pg_stat_statements is enabled)
heroku pg:psql -a YOUR_APP_NAME -c "SELECT pid, state, query FROM pg_stat_activity WHERE state != 'idle';"
```

## Understanding the Timeout Issue

The timeout occurs when `logged_in?` is called. With Sorcery's `remember_me` submodule enabled, `logged_in?` does:

1. Checks session for user (fast, no DB query)
2. If no session, checks `remember_me` cookie
3. If cookie exists, queries `remember_tokens` table to validate the token
4. Queries `users` table to load the user

**The problem**: If there's a stale/expired `remember_me` cookie, the query to `remember_tokens` might be hanging or timing out.

## What to Check

### 1. Database Connection Pool Exhaustion
- Check if all connections are checked out
- Run: `heroku run rake db:diagnose` and look at "Connection Pool Status"

### 2. Slow Queries
- Check query execution time in diagnostics
- Look for queries taking > 1000ms

### 3. Remember Tokens
- Check if there are many expired/invalid tokens
- The query might be scanning a large table

### 4. Database URL Configuration
- Verify `DATABASE_URL` is correctly set
- Check connection parameters

### 5. Heroku Database Status
- Verify the database is not in maintenance mode
- Check for connection limits reached

## Next Steps After Diagnostics

1. **If connection pool is exhausted**: Reduce pool size or check for connection leaks
2. **If queries are slow**: Add indexes, check for table locks
3. **If remember_tokens table is the issue**: Clean up expired tokens or optimize the query
4. **If database URL is wrong**: Fix `DATABASE_URL` environment variable

