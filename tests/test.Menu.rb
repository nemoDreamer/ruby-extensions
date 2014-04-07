#!/usr/bin/env ruby -wU

require_relative '../modules/Curses/class.Menu.rb'

menu = Curses::Menu.new([
   'First',
   'Second',
   'Third'
  ], {
    selection: {
      fg: 'white',
      bg: 'red'
    }
  }) do |v|
    puts v
  end

puts menu.get
