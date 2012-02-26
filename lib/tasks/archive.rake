desc "Archive expired listings and availability"
task :archive => :environment do
  #@listings = Listing.where("end_date < ?", DateTime.now)
  #@availabilities = Availability.where("end_date < ?", DateTime.now)

  sql = <<-SQL
select * from listings;
SQL
  # used to connect active record to the database
  ActiveRecord::Base.establish_connection
  #ActiveRecord::Base.connection.execute(sql)
  records = ActiveRecord::Base.connection.exec_query(sql)
  for record in records
    puts record
  end

  #print_items(@listings)
  #print_items(@availabilities)
end

def archive_items(items, archive_class, destination)
  for item in items
    archive_item = archive_class.new(item.attributes)
    archive_item.save
    # TODO: handle save error
  end
end

def print_items(items)
  for item in items
    puts "Item #{item.id}"
    puts "\tstart date: #{item.start_date}"
    puts "\t  end date: #{item.end_date}\n"
  end
end
