require 'curses'

module Curses

  def self.init_dialog _width, _height

    self::init_screen
    self::curs_set 0

    begin

      dialog = self::Window.new(
        _height, _width, (self.lines - _height) / 2,
        (self.cols - _width) / 2
      )

      dialog.box 0, 0
      dialog.keypad true

      yield dialog

      dialog.close

    ensure
      self::close_screen
    end

  end

end
