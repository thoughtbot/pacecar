rails_versions = {
  '3.0.17' => {
    'mysql' => '2.8.1',
    'mysql2' => '0.2.18',
    'pg' => nil,
    'sqlite3' => nil
  },
  '3.1.8' => {
    'mysql' => '2.8.1',
    'mysql2' => '0.3.11',
    'pg' => nil,
    'sqlite3' => nil
    },
  '3.2.9' => {
    'mysql' => '2.8.1',
    'mysql2' => '0.3.11',
    'pg' => nil,
    'sqlite3' => nil
  }
}

rails_versions.keys.each do |rails_version|
  rails_versions[rails_version].keys.each do |database_driver|
    appraise "rails_#{rails_version}_database_#{database_driver}" do
      gem 'rails', rails_version
      if rails_versions[rails_version][database_driver].nil?
        gem database_driver
      else
        gem database_driver, rails_versions[rails_version][database_driver]
      end
      gem 'pacecar', :path => '../'
    end
  end
end
