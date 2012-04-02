rails_versions = ['3.0.12', '3.1.4']
database_drivers = ['mysql', 'sqlite3-ruby', 'pg', 'sqlite3']

rails_versions.each do |rails_version|
  database_drivers.each do |database_driver|
    appraise "rails-#{rails_version}-database-#{database_driver}" do
      gem "rails", rails_version
      gem database_driver
    end
  end
end

# The mysql2 gem needs different versions depending on which activerecord we have
appraise "rails-3.1.4-database-mysql2" do
  gem "rails", "3.1.4"
  gem "mysql2", "0.3.10"
end

appraise "rails-3.0.12-database-mysql2" do
  gem "rails", "3.0.12"
  gem "mysql2", "0.2.13"
end
