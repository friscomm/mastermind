require 'io/console'
require_relative 'colorize'

class SubmitCode

  attr_accessor :colors, :color_index_base, :stored_colors, :position_base, :marker_template
  # attr_reader :position, :color_index

  def initialize
    default = 'default_background'
    self.colors = ['red_background', 'green_background', 'yellow_background', 'blue_background', 'magenta_background', 'cyan_background']
    self.color_index_base = 0
    self.stored_colors = [{color: default}, {color: default}, {color: default}, {color: default} ]
    self.position_base = 0
    self.marker_template = "   "
    # self.position = position_base % 4
    # self.color_index = index % 6
  end

  def generate_color_line(arr)
    # puts "generate_color_line(#{arr})"
    holder = []
    arr.each do |obj|
      unless obj[:color].nil?
        holder << @marker_template.send(obj[:color])
      end
    end
    holder.join('  ')
  end

  def move_cursor_to(value)
    # puts " move_cursor_to(#{value})"
    print "#{line}\e[#{value}G"
  end

  def read_keypresses
    loop do
      keypress = $stdin.getch

      if keypress == "\e" then
        keypress << STDIN.read_nonblock(3) rescue nil
      end

      cycle_colors(keypress)
      break if keypress == ?\u0003 # || keypress == ?\r
      keypress
    end
  end

  def mod_4(num)
    num % 4
  end

  def mod_6(num)
    num % 6
  end

  def print_line
    STDOUT.write line
  end

  def line
    "\r#{generate_color_line(@stored_colors)}"
  end

  def set_color
    color_index = mod_6(@color_index_base)
    position = mod_4(@position_base)
    @stored_colors[position][:color] = colors[color_index]
  end

  def cycle_colors(keypress)
    # for some reason these variables delay the cursor functionality so it takes two button presses in order to see the cursor move, and it is always one button press behind. possibly has something to do with the case statement getting the most up to date value for the variables when they're changed

    # color_index = mod_6(@color_index_base)
    # position = mod_4(@position_base)
    # value = position * 5
    case keypress
    when "\e[A"
      @color_index_base += 1
      set_color
      move_cursor_to((mod_4(@position_base)) * 5)
    when "\e[B"
      @color_index_base -= 1
      set_color
      move_cursor_to((mod_4(@position_base)) * 5)
    when "\e[C"
      @position_base += 1
      move_cursor_to((mod_4(@position_base)) * 5)
    when "\e[D"
      @position_base -= 1
      move_cursor_to((mod_4(@position_base)) * 5)
    end
  end

  #
  # def show_cursor
  #     print "\e[?25h" # show cursor
  # end
  #
  # def hide_cursor
  #   print "\e[?25l" # hide cursor
  # end
  #
  # def clear_line
  #   print "\r\033[K"
  # end
  #
  # def move_cursor_up(n=1)
  #   print "\033[#{n}A"
  # end
  #
  # def move_cursor_right(n=1)
  #   print "\r#{generate_color_line(@stored_colors)}\033[#{n}C"
  # end
  #
  # def move_cursor_left(n=1)
  #   print "\r#{generate_color_line(@stored_colors)}\033[#{n}D"
  # end
  #
  # def move_cursor_down(n=1)
  #   print "\033[#{n}B"
  # end
  #
  # def pattern
  #   [marker_template.green_background, marker_template.green_background, marker_template.cyan_background, marker_template.magenta_background]
  # end
  #
  # def writing
  #   print "Here is your secret pattern: "
  #   puts "#{pattern.join("  ")}"
  #   i = 3
  #   while i > 0
  #     # STDOUT.write "\r Pattern will disappear in #{i}"
  #     print "\rPattern will disappear in #{i}"
  #     i-=1
  #     sleep 1
  #   end
  #   clear_line
  #   move_cursor_up(1)
  #   clear_line
  # end

end
