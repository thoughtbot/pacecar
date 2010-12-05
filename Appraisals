# rails_versions = ['3.0.3', '2.3.9', '2.3.5']
rails_versions = ['3.0.3']
database_drivers = ['mysql', 'sqlite3-ruby', 'mysql2', 'pg']

rails_versions.each do |rails_version|
  database_drivers.each do |database_driver|
    appraise "rails-#{rails_version}-database-#{database_driver}" do
      gem "rails", rails_version
      gem database_driver
    end
  end
end
