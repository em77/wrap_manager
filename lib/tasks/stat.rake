namespace :stat do
  desc "Instantiate MonthlyStat for previous month and save to database"
  task do_monthly: :environment do
    one_month_ago = Time.zone.now - 1.month
    prev_month_stat_count =
      MonthlyStat.where("month = ? AND year = ?",
        one_month_ago.month, one_month_ago.year).count
    if prev_month_stat_count == 0
      new_stat = MonthlyStat.new
      new_stat.set_monthly_values(one_month_ago.year, one_month_ago.month)
      new_stat.save
      puts "MonthlyStat for #{one_month_ago.month}/#{one_month_ago.year}" +
        " saved to database."
    else
      puts "MonthlyStat for #{one_month_ago.month}/#{one_month_ago.year}" +
        " already exists in the database. No action taken."
    end
  end

end
