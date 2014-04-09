require_relative 'module.Curses.rb'

require_relative '../../classes/class.Array.rb'
require_relative '../../classes/class.Hash.rb'

module Curses

  class Menu

    attr_accessor :items

    # --------------------------------------------------
    # INITIALIZE
    # --------------------------------------------------
    def initialize items, options={}, &block
      @@defaults = {
        standout: Curses::A_STANDOUT,
        padding: [2, 1],
      }

      @items = (items.is_a? Array) ? items.to_hash : items
      @options = @@defaults.merge(options)

      @block = block_given? ? block : false

      @current_item = 0
    end


    # --------------------------------------------------
    # GET
    # --------------------------------------------------
    def get
      items_padded = get_items_padded

      Curses::init_dialog(
        items_padded[0],
        items_padded[1]
      ) do |dialog|

        loop do
          render(dialog)
          break if interact(dialog)
        end

      end

      @items[@current_item]
    end


    # --------------------------------------------------
    # PRIVATE METHODS
    # --------------------------------------------------

    private

    # RENDER
    # --------------------------------------------------
    def render dialog
      line = 0
      @items.each do |k, v|

        # stand out?
        line == @current_item ? dialog.attron(@options[:standout]) : dialog.standend

        # print line
        dialog.setpos(
          line + @options[:padding][1] + 1,
          @options[:padding][0] + 1
        )
        if @block != false
          dialog << @block.call(v)
        else
          dialog << v
        end

        line += 1
      end
    end


    # INTERACT
    # --------------------------------------------------
    def interact dialog
      key_pressed = dialog.getch

      # UP / DOWN
      case key_pressed
        when Curses::KEY_UP   then @current_item -= 1
        when Curses::KEY_DOWN then @current_item += 1
      end
      @current_item = [[@current_item, @items.length-1].min, 0].max

      # return true on ENTER or ASCII LF
      key_pressed == Curses::KEY_ENTER || key_pressed == 10
    end


    # HELPERS
    # --------------------------------------------------

    def get_items_padded
      [
        @items.breadth + 2 + (@options[:padding][0] * 2),
        @items.length  + 2 + (@options[:padding][1] * 2)
      ]
    end

  end

end
