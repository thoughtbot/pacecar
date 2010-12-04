class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.boolean :admin, :default => false, :null => false
      t.datetime :approved_at
      t.datetime :rejected_at
      t.date :last_posted_on
      t.string :first_name
      t.string :last_name
      t.text :description
      t.integer :age
      t.float :rating
      t.timestamps
    end
    create_table :posts, :force => true do |t|
      t.string :owner_type
      t.integer :owner_id
      t.string :publication_state
      t.string :post_type
      t.string :title
      t.text :body
      t.timestamps
    end
    create_table :comments, :force => true do |t|
      t.integer :user_id
      t.text :description
      t.timestamps
    end
  end
  def self.down
  end
end
