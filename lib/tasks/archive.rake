desc "Archive expired listings and availability"
task :archive => :environment do
  now = DateTime.now.to_s
  archive(now, 'availabilities')
  archive(now, 'listings')
end

def archive(time, table)
  insert_sql = "insert into #{table}_archive select * from #{table} where end_date < '#{time}';"
  delete_sql = "delete from #{table} where end_date < '#{time}';"

  ActiveRecord::Base.establish_connection
  ActiveRecord::Base.connection.execute(insert_sql)
  ActiveRecord::Base.connection.execute(delete_sql)

  # TODO: error handling

end
