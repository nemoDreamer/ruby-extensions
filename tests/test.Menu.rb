#!/usr/bin/env ruby -wU

require_relative '../classes/class.String.rb'
require_relative '../modules/Curses/class.Menu.rb'

# `mdfind "kMDItemFSSize >= 100000000" -0 | xargs -0 -I {} du -s "{}" | sort -rn | tee ~/large_files`

# list = `find ~ -type f -size +100M -print0`.split "\u0000"
# list = `mdfind "kMDItemFSSize >= 100000000" -0 | xargs -0 -I {} du -s "{}" | sort -rn `.split "\n"

list = File.read('/Users/pblyth/large_files_cut').split "\n"

# list = [
#   'First element',
#   'Another element',
#   'One Last thing'
# ]

menu = Curses::Menu.new(list) do |v|
  size, filename = v.split ' ', 2
  "#{size} #{filename}"
end

puts menu.get
