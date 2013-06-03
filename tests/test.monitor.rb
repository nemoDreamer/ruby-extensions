#!/usr/bin/env ruby -w

require '../classes/class.String.rb'
require '../classes/class.Monitor.rb'

monitor = Monitor.new( 'https://www.cpg.org/account/sign-in/' )

monitor.should_contain( /<input[^>]+(name|id)="ccis_username"[^>]?>/im )
monitor.should_not_contain( "[pattern for CF error here]" )
monitor.should_not_contain( "<body" ) # would fail, of course.

puts monitor
