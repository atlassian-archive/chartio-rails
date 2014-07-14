namespace :chartio do
  desc "Generate a chartio schema"
  task :schema => :environment do
    runner = Chartio::Schema.new(Chartio::CSVFormatter.new)
    timestamp = Time.now.strftime("%Y%m%d%H%M")
    csv_data = runner.output_report
    file = File.open("chartio_schema_#{timestamp}.csv", "wb")
    file.write(csv_data)
    puts "All done!"
  end
end
