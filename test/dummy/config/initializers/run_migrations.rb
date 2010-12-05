# Delete DB from previous runs for sqlite3
FileUtils.rm File.expand_path("../dummy/db/test.sqlite3", __FILE__), :force => true

# Migrate up for all
ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate")
