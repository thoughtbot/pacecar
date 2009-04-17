ActiveRecord::Base.establish_connection :adapter  => 'sqlite3', :database => File.join(File.dirname(__FILE__), 'test.db')

class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.boolean :admin, :default => false, :null => false
      t.datetime :approved_at
      t.datetime :rejected_at
      t.string :first_name
      t.string :last_name
      t.text :description
      t.timestamps
    end
    create_table :posts, :force => true do |t|
      t.string :owner_type
      t.integer :owner_id
      t.string :publication_state
      t.string :post_type
      t.timestamps
    end
    create_table :comments, :force => true do |t|
      t.integer :user_id
      t.text :description
      t.timestamps
    end
  end
end

CreateSchema.suppress_messages { CreateSchema.migrate(:up) }

class User < ActiveRecord::Base
  include Pacecar
  has_many :posts, :as => :owner
  has_many :comments
  has_many :articles
  has_ranking :comments
  has_recent_records :comments
  has_recent_records :articles, :comments
end
class Post < ActiveRecord::Base
  include Pacecar
  PUBLICATION_STATES = %w(Draft Submitted Rejected Accepted).freeze
  TYPES = %w(Free Open Private Anonymous PostModern).freeze
  belongs_to :owner, :polymorphic => true
  has_state :publication_state
  has_state :post_type, :with => TYPES
  has_polymorph :owner
end
class Comment < ActiveRecord::Base
  belongs_to :user
end
class Article < ActiveRecord::Base
  belongs_to :user
end
