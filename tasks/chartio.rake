namespace :chartio do
  desc "Generate a chartio schema"
  task :schema => :environment do
    runner = Chartio::Schema.new
    timestamp = Time.now.strftime("%Y%m%d%H%M")
    runner.crawl(
      "chartio_schema_#{timestamp}.csv",
      "chartio_schema_#{timestamp}.log"
    )
    puts "All done!"
  end
end
