Pacecar
=======

Pacecar adds scope methods and other common functionality to ActiveRecord classes via database column introspection.

Pacecar automatically includes the Pacecar::Helpers module into all ActiveRecord::Base classes.

To get all Pacecar functionality, you need to "include Pacecar" in your class.

    class User < ActiveRecord::Base
      include Pacecar
    end

To get some subset (for example, only the state functionality), you can do something like "include Pacecar::State" to get only the module(s) you want.

    class Post < ActiveRecord::Base
      include Pacecar::State
    end

Pacecar supports mysql, postgres and sqlite database drivers, and is compatible with Rails 3.0.x and 3.1.x versions.

Installation
------------

For rails 3, just include in your Gemfile

    gem 'pacecar'

For prior rails versions, there is a rails2 branch to use:

    gem 'pacecar', :git => 'git://github.com/thoughtbot/pacecar.git', :branch => 'rails2'

Usage
-----

Assuming a database schema...

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
          t.integer :rating
          t.timestamps
        end
      end
    end

And some basic model declarations...

    class User < ActiveRecord::Base
      include Pacecar
      has_many :posts, :as => :owner
      has_many :comments
      has_many :articles
      has_ranking :comments
      has_recent_records :comments
      has_recent_records :articles, :comments
      has_calculated_records :comments, :on => :rating
    end
  
    class Post < ActiveRecord::Base
      include Pacecar
      PUBLICATION_STATES = %w(Draft Submitted Rejected Accepted)
      TYPES = %w(Free Open Private Anonymous PostModern)
      belongs_to :owner, :polymorphic => true
      has_state :publication_state
      has_state :post_type, :with => TYPES
      has_polymorph :owner
    end
  
    class Comment < ActiveRecord::Base
      include Pacecar
      belongs_to :user
    end
  
    class Article < ActiveRecord::Base
      belongs_to :user
    end

All columns
-----------

Records where approved_at is not null, or where it is null...

    User.approved_at_present
    User.approved_at_missing

Records where first_name is not null, or where it is null...

    User.first_name_present
    User.first_name_missing

Records ordered by first_name (default to 'asc', can specify to override)...

    User.by_first_name
    User.by_first_name(:asc)
    User.by_first_name(:desc)

Records where an attribute matches a search term (column LIKE "%term%")...

    User.first_name_matches('John')

Records where an attribute starts or ends with a search term...

    User.first_name_starts_with('A')
    User.first_name_ends_with('a')

Records where an attribute matches exactly a term...

    User.first_name_equals('John')

Records where any non-state text or string column matches term...

    User.search_for('test')

Records where any of a list of columns match the term...

    User.search_for 'test', :on => [:first_name, :last_name]

Records where all of a list of columns match the term...

    User.search_for 'test', :on => [:first_name, :last_name], :require => :all

Boolean columns
---------------

Records that are all admins or non-admins...

    User.admin
    User.not_admin

The "balance" (count of true minus false for column in question)...

    User.admin_balance

Datetime columns
----------------

Records approved before or after certain times...

    User.approved_at_before(5.days.ago)
    User.approved_at_after(4.weeks.ago)

Records with approved_at in the past or future...

    User.approved_at_in_past
    User.approved_at_in_future

Records with approved_at inside or outside of two times...

    User.approved_at_inside(10.days.ago, 1.day.ago)
    User.approved_at_outside(2.days.ago, 1.day.ago)

Records with certain year, month or day...

    User.approved_at_in_year(2000)
    User.approved_at_in_month(01)
    User.approved_at_in_day(01)

Records with a duration (time delta between two columns) of, over or under a certain number of days...

    User.with_duration_of(14, :approved_at, :rejected_at)
    User.with_duration_over(14, :approved_at, :rejected_at)
    User.with_duration_under(14, :approved_at, :rejected_at)

Polymorphic relationships
-------------------------

Records which have an owner_type of User...

    Post.for_owner_type(User)

Associations
------------

Records with the most and least associated records...

    User.maximum_comments
    User.minimum_comments

Records with associated records since a certain time...

    User.recent_comments_since(2.days.ago)
    User.recent_comments_and_posts_since(3.days.ago)
    User.recent_comments_or_posts_since(4.days.ago)

Records with highest and lowest association column average...

    User.by_comments_highest_rating_average
    User.by_comments_lowest_rating_average

Records with highest and lowest association column total...

    User.by_comments_highest_rating_total
    User.by_comments_lowest_rating_total

State columns
-------------

Records which are in a particular state, or not in a state...

    Post.publication_state_draft
    Post.post_type_not_open

Query methods on instances to check state...

    Post.first.publication_state_draft?
    Post.last.post_type_not_open?

Numeric columns
---------------

Records which are greater than or less than a certain value...

    User.age_greater_than(21)
    User.age_greater_than_or_equal_to(21)
    User.age_less_than(21)
    User.age_less_than_or_equal_to(21)

Limits
------

First x records...

    User.limited(10)

Named scopes
------------

Because these are all scope, you can combine them.

To get all users that have a first_name set, who are admins and approved more than 2 weeks ago, ordered by their first name...

    User.first_name_present.admin.approved_at_before(2.weeks.ago).by_first_name

To get the top 10 commenters...

    User.maximum_comments.limited(10)

Supported Databases
-------------------

* MySQL
* SQLite
* Postgres

Credits
-------

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

Pacecar is maintained and funded by [thoughtbot, inc](http://thoughtbot.com/community)

Thank you to all [the contributors](https://github.com/thoughtbot/pacecar/contributors)!

The names and logos for thoughtbot are trademarks of thoughtbot, inc.

License
-------

Pacecar is Copyright © 2008-2011 thoughtbot. It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
