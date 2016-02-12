rails_versions = ["5.0.0", "4.2.0", "4.1.0"]
database_drivers = ["mysql2", "pg", "sqlite3"]

rails_versions.each do |rails|
  database_drivers.each do |database|
    appraise "rails_#{rails}_#{database}_driver" do
      gem "rails", "~> #{rails}"
      if database == "mysql2"
        gem database, "~> 0.3.0"
      else
        gem database
      end
    end
  end
end
