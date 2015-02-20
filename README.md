Pacecar
=======

[![Build Status](https://secure.travis-ci.org/thoughtbot/pacecar.png?branch=master)](http://travis-ci.org/thoughtbot/pacecar)

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

Pacecar supports mysql, postgres and sqlite database drivers, and is compatible with Rails 4.x versions.

Installation
------------

Just include in your Gemfile:

    gem 'pacecar'

Usage
-----

Assuming a database schema:

    class CreateSchema < ActiveRecord::Migration
      def self.up
        create_table :users, force: true do |t|
          t.boolean :admin, default: false, null: false
          t.datetime :approved_at
          t.datetime :rejected_at
          t.string :first_name
          t.string :last_name
          t.text :description
          t.timestamps
        end
        create_table :posts, force: true do |t|
          t.string :owner_type
          t.integer :owner_id
          t.string :publication_state
          t.string :post_type
          t.timestamps
        end
        create_table :comments, force: true do |t|
          t.integer :user_id
          t.text :description
          t.integer :rating
          t.timestamps
        end
      end
    end

And some basic model declarations:

    class User < ActiveRecord::Base
      include Pacecar
      has_many :posts, as: :owner
      has_many :comments
      has_many :articles
    end

    class Post < ActiveRecord::Base
      include Pacecar
      PUBLICATION_STATES = %w(Draft Submitted Rejected Accepted)
      TYPES = %w(Free Open Private Anonymous PostModern)
      belongs_to :owner, polymorphic: true
      has_state :publication_state
      has_state :post_type, with: TYPES
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

Records where approved\_at is not null, or where it is null:

    User.approved_at_present
    User.approved_at_missing

Records where first\_name is not null, or where it is null:

    User.first_name_present
    User.first_name_missing

Records ordered by first\_name (default to 'asc', can specify to override):

    User.by_first_name
    User.by_first_name(:asc)
    User.by_first_name(:desc)

Records where an attribute matches exactly a term:

    User.first_name_equals('John')

Boolean columns
---------------

Records that are all admins or non-admins:

    User.admin
    User.not_admin

Polymorphic relationships
-------------------------

Records which have an owner\_type of User:

    Post.for_owner_type(User)

State columns
-------------

Records which are in a particular state, or not in a state:

    Post.publication_state_draft
    Post.post_type_not_open

Query methods on instances to check state:

    Post.first.publication_state_draft?
    Post.last.post_type_not_open?

Limits
------

First x records:

    User.limited(10)

Named scopes
------------

Because these are all scope, you can combine them.

To get all users that have a first\_name set, who are admins:

    User.first_name_present.admin

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

Pacecar is Copyright © 2008-2013 thoughtbot. It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
