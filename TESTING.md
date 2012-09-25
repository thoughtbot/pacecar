Running the test suite
======================


Run the tests:

    % rake

In order to do this you must have gems bundled, Appraisal set up, and
three databases configured.

bundler
-------

    % bundle --binstubs

Appraisal
---------

    % rake appraisal:install

MySQL
-----

    % echo create database pacecar_test | mysql
    % cd spec/dummy
    spec/dummy% RAILS_ENV=test BUNDLE_GEMFILE=../../gemfiles/rails-3.1.6-database-mysql.gemfile bundle exec rake db:migrate

Postgres
--------

    % createdb pacecar_test
    % cd spec/dummy
    spec/dummy% RAILS_ENV=test BUNDLE_GEMFILE=../../gemfiles/rails-3.1.6-database-pg.gemfile bundle exec rake db:migrate

sqlite
------

    % cd spec/dummy
    spec/dummy% RAILS_ENV=test % BUNDLE_GEMFILE=../../gemfiles/rails-3.1.6-database-sqlite3.gemfile bundle exec rake db:migrate
