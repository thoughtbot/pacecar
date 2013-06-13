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
    spec/dummy% RAILS_ENV=test BUNDLE_GEMFILE=../../gemfiles/rails_4_mysql2_driver.gemfile bundle exec rake db:migrate

Postgres
--------

    % createdb pacecar_test
    % cd spec/dummy
    spec/dummy% RAILS_ENV=test BUNDLE_GEMFILE=../../gemfiles/rails_4_pg_driver.gemfile bundle exec rake db:migrate

sqlite
------

    % cd spec/dummy
    spec/dummy% RAILS_ENV=test % BUNDLE_GEMFILE=../../gemfiles/rails_4_sqlite3_driver.gemfile bundle exec rake db:migrate
