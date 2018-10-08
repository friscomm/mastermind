require 'io/console'
require_relative 'colorize'

class Movement

  attr_accessor :colors

  def initialize
    self.colors = ['red_background', 'green_background', 'yellow_background', 'blue_background', 'magenta_background', 'cyan_background']
  end

  def clear_line
    print "\r\033[K"
  end

  def move_cursor_up(n=1)
    print "\033[#{n}A"
  end

  def move_cursor_right(n=1)
    print "\033[#{n}C"
  end

  def move_cursor_left(n=1)
    print "\033[#{n}D"
  end

  def move_cursor_down(n=1)
    print "\033[#{n}B"
  end

  def read_keypresses
    loop do
      puts "the loop started over".red
      keypress = $stdin.getch

      if keypress == "\e" then
        keypress << STDIN.read_nonblock(3) rescue nil
      end

      # if keypress == ?y
      #   move_cursor_up(2)
      #   clear_line
      #   puts "whats happening?"
      #   clear_line
      # end
      cycle_colors(keypress)
      puts "You typed:  #{keypress.inspect}".green
      break if keypress == ?\u0003 # || keypress == ?\r
      keypress
    end
  end

  def cycle_colors(keypress)
    puts "here is the keypress: #{keypress.inspect}"
    puts "CYCLE_COLORS WAS CALLED"
    index = 0
    case keypress
    when "\e[A"
      "up arrow for you!"
      # move_cursor_left(3)
      # index += 1
      # puts "#{marker_template.colors[index]}"
    when "\e[B"
      puts "you did it! down arrow"
      # move_cursor_left(3)
      # index -= 1
      # puts "#{marker_template.colors[index]}"
    when '\e[C'

    when '\e[D'
    end
  end

  def marker_template
    "   "
  end

  def pattern
    [marker_template.green_background, marker_template.green_background, marker_template.cyan_background, marker_template.magenta_background]
  end

  def writing
    print "Here is your secret pattern: "
    puts "#{pattern.join("  ")}"
    i = 3
    while i > 0
      # STDOUT.write "\r Pattern will disappear in #{i}"
      print "\rPattern will disappear in #{i}"
      i-=1
      sleep 1
    end
    clear_line
    move_cursor_up(1)
    clear_line
  end

end
