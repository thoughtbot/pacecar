$: << File.join(File.dirname(__FILE__), '..', 'lib')
$: << File.join(File.dirname(__FILE__))

require 'rubygems'
require 'test/unit'
require 'activerecord'
require 'shoulda'
require 'mocha'
require 'pacecar'
require 'models'
begin require 'redgreen'; rescue LoadError; end
