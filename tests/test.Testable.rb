#!/usr/bin/env ruby -w

require_relative '../modules/module.Testable.rb'

class String
	include Testable
end

class TrueClass
	include Testable
end

puts 'hello'.assert_contains 'o'
puts 'hello'.assert_is 'hello'
puts true.assert_is_true

puts 'hello'.pretty(:assert_contains, '0')
puts 'hello'.pretty(:assert_is, 'hello')

puts 'hello'.should_contain 'o'
