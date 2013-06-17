require_relative 'class.Curl.rb'
require_relative '../modules/module.Testable.rb'

module Response
	include Testable

	def inspect
		'Response'
	end
end

##
# Monitor
# =======
# Quick wrapper for curl type grep tests
#
# @author Philip Blyth
#
class Monitor

	def initialize url
		@url = url
		@response = Curl::simple(@url).extend(Response)
		@results = []
	end

	##
	# Tests
	# -----

	def should_contain pattern
		@results.push @response.should_contain pattern
	end

	def should_not_contain pattern
		@results.push @response.should_not_contain pattern
	end

	##
	# Output
	# ------

	def to_s
		output = ''
		@results.each do |result|
			output << result << "\n"
		end
		output
	end

end
