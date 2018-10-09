require 'io/console'
require_relative 'colorize'

class Movement

  attr_accessor :colors, :index, :mod_index, :stored_colors, :space

  def initialize
    self.colors = ['red_background', 'green_background', 'yellow_background', 'blue_background', 'magenta_background', 'cyan_background']
    self.index = 0
    self.stored_colors = [{color: nil} ,{color: nil} ,{color: nil} ,{color: nil} ,{color: nil} ,{color: nil} ]
    self.space = 0
  end

  def generate_color_line(arr)
    holder = []
    arr.each do |obj|
      unless obj[:color].nil?
        holder << marker_template.send(obj[:color])
      end
    end
    holder.join(' ')
  end

  # def generate_color_line(arr)
  #   arr.join(' ')
  # end

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
      keypress = $stdin.getch

      if keypress == "\e" then
        keypress << STDIN.read_nonblock(3) rescue nil
      end

      cycle_colors(keypress)
      # print "You typed: #{keypress.inspect}".green
      break if keypress == ?\u0003 # || keypress == ?\r
      keypress
    end
  end

  def mod_6(num)
    num % 6
  end

  def cycle_colors(keypress)
    color_index = mod_6(index)
    case keypress
    when "\e[A"
      clear_line
      move_cursor_up
      clear_line
      @index += 1
      puts "here is the index for up #{index}"
      @stored_colors[mod_6(@space)][:color] = colors[color_index]
      STDOUT.write "\r#{generate_color_line(@stored_colors)}"
      # STDOUT.write "\r#{stored_colors.join(' ')}#{marker_template.send(colors[color_index])}"
    when "\e[B"
      clear_line
      move_cursor_up
      clear_line
      @index -= 1
      puts "here is the index for down #{index}"
      @stored_colors[mod_6(@space)][:color] = colors[color_index]
      STDOUT.write "\r#{generate_color_line(@stored_colors)}"
      # STDOUT.write "\r#{stored_colors.join(' ')}#{marker_template.send(colors[color_index])}"
    when "\e[C"
      @stored_colors[mod_6(@space)] = marker_template.send(colors[color_index])
      @space += 1
      move_cursor_right(4)
    when "\e[D"
      @stored_colors[mod_6(@space)] = marker_template.send(colors[color_index])
      @space -= 1
      move_cursor_left(4)
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
