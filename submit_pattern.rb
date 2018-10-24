require 'io/console'
require_relative 'colorize'

class SubmitPattern

  attr_reader :colors  #:position, :color_index
  attr_accessor :color_index_base, :stored_colors, :position_base, :marker_template, :stored_feedback

  def initialize
    default = 'default_background'
    @colors = ['salmon_background', 'mint_background', 'lemon_background', 'azure_background', 'magenta_background', 'cyan_background']
    @color_index_base = 0
    @position_base = 0
    @stored_colors = [{color: default}, {color: default}, {color: default}, {color: default} ]
    @stored_feedback = nil
    @marker_template = "   "
    # self.position = position_base % 4
    # self.color_index = index % 6
  end

  def read_keypresses_maker
    loop do
      keypress = $stdin.getch

      if keypress == "\e" then
        keypress << STDIN.read_nonblock(3) rescue nil
      end

      cycle_colors(keypress)

      if keypress == ?\u0003
        break
      elsif keypress == ?\r
        print "\n"
        hide_secret_pattern
        break
      end

      keypress
    end
  end

  def read_keypresses_breaker
    loop do
      keypress = $stdin.getch

      if keypress == "\e" then
        keypress << STDIN.read_nonblock(3) rescue nil
      end

      cycle_colors(keypress)

      if keypress == ?\u0003
        break
      elsif keypress == ?\r
        print "\n"
        break
      end
      keypress
    end
  end

  def mod_4(num)
    num % 4
  end

  def mod_6(num)
    num % 6
  end

  def generate_color_line_string(arr)
    holder = []
    arr.each do |obj|
      unless obj[:color].nil?
        holder << @marker_template.send(obj[:color])
      end
    end
    holder.join('  ')
  end

  def formatted_color_line
    "\r\t#{generate_color_line_string(@stored_colors)}"
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
      move_cursor_to(((mod_4(@position_base)) * 5) + 8)
    when "\e[B"
      @color_index_base -= 1
      set_color
      move_cursor_to(((mod_4(@position_base)) * 5) + 8)
    when "\e[C"
      @position_base += 1
      move_cursor_to(((mod_4(@position_base)) * 5) + 8)
    when "\e[D"
      @position_base -= 1
      move_cursor_to(((mod_4(@position_base)) * 5) + 8)
    end
  end

  def hide_secret_pattern
    i = 3
    while i > 0
      print "\rPattern will disappear in #{i}"
      i-=1
      sleep 1
    end
    clear_line
    move_cursor_up
    clear_line
    puts "Secret pattern saved"
  end

  def generate_response(guess, pattern)
    guess_feedback = {correct_position: 0, correct_color: 0, non_matches: 4}

    guess.each_with_index do |color, i|
      if pattern[i] == color
        guess_feedback[:correct_position] += 1
        guess_feedback[:non_matches] -= 1
      elsif pattern[i] != color && pattern.include?(color)
        guess_feedback[:correct_color] += 1
        guess_feedback[:non_matches] -= 1
      end
    end
    @stored_feedback = guess_feedback
  end

  def clear_line
    print "\r\033[K"
  end

  def move_cursor_to(value)
    print "#{formatted_color_line}\e[#{value}G"
  end

  def move_cursor_up(n=1)
    print "\033[#{n}A"
  end

end
