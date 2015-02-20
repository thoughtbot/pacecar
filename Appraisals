rails_versions = ['4.0.0', '4.1.0', '4.2.0']
database_drivers = ['mysql2', 'pg', 'sqlite3']

rails_versions.each do |rails|
  database_drivers.each do |database|
    appraise "rails_#{rails}_#{database}_driver" do
      gem 'rails', "~> #{rails}"
      gem database
    end
  end
end
