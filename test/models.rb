ActiveRecord::Base.establish_connection :adapter  => 'sqlite3', :database => File.join(File.dirname(__FILE__), 'test.db')

class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.boolean :admin, :default => false, :null => false
      t.datetime :created_at
      t.string :first_name
    end
    create_table :posts, :force => true do |t|
      t.string :owner_type
      t.integer :owner_id
    end
  end
end

CreateSchema.suppress_messages { CreateSchema.migrate(:up) }

class User < ActiveRecord::Base
  has_many :posts, :as => :owner
  include Pacecar
end
class Post < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  include Pacecar
end
