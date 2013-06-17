begin
	# add color support to module.Testable if available
	require_relative '../classes/class.String.rb'
rescue LoadError
	if !'string'.methods.include? :color
		class String
			def color (*args) self end
			def bold ()       self end
		end
	end
end

module Testable

	# --------------------------------------------------
	# Basic Assertions
	# --------------------------------------------------

	def assert_is comparison, strict = true
		if strict
			self === comparison
		else
			self == comparison
		end
	end

	def assert_is_true
		self.assert_is true
	end

	def assert_is_false
		!self.assert_is_true
	end

	def assert_contains pattern
		if self.is_a? String
			self.index(pattern) != nil
		else
			nil
		end
	end

	def assert_contains_not pattern
		!assert_contains pattern
	end


	# --------------------------------------------------
	# Pretty Formatting
	# --------------------------------------------------

	def pretty *args
		should = (args[0].is_a? Symbol) ? false : args.shift
		assertion = args.shift

		result = self.method(assertion).call(*args)

		should = should || assertion.to_s.gsub(/[_-]/, ' ')
		args = args.to_s.gsub(/^\[(.*)\]$/, '\\1')

		self.inspect.rjust(25) + ' ' + (should.ljust(25) + ' ' + (result ? args : args.bold)).color(result ? 'gray' : 'red')
	end

	# Short-hands
	# --------------------------------------------------

	def should_be comparison, strict = true
		pretty 'should be', :assert_is, comparison, strict
	end

	def should_contain pattern
		pretty 'should contain', :assert_contains, pattern
	end

	def should_not_contain pattern
		pretty 'should not contain', :assert_contains_not, pattern
	end

end
