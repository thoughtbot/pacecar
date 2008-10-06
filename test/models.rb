ActiveRecord::Base.establish_connection :adapter  => 'sqlite3', :database => File.join(File.dirname(__FILE__), 'test.db')

class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.boolean :admin, :default => false
      t.datetime :created_at
      t.string :first_name
    end
  end
end

CreateSchema.suppress_messages { CreateSchema.migrate(:up) }

class User < ActiveRecord::Base
  include Pacecar
end
