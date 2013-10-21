require 'bundler'

Bundler.setup(:default, :test)
Bundler.require(:default, :test)

require 'fluent/test'
require 'test/unit'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

require 'fluent/plugin/out_unique_counter'
