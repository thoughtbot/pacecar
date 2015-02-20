Running the test suite
======================


Run the tests:

    % bundle exec rake

In order to do this you must have gems bundled, Appraisal set up, and
some databases created.

bundler
-------

    % bundle --binstubs

Appraisal
---------

    % bundle exec appraisal:install

MySQL
-----

    % echo create database pacecar_test | mysql

Postgres
--------

    % createdb pacecar_test
