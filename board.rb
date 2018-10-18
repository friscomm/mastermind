require_relative "colorize"

class Board

  attr_accessor :rows

  def initialize
    @rows = []
    @marker_template = "   "
    @non_matching_symbol = "\u2b21"
    @correct_color_symbol = "\u2b22".lemon
    @correct_position_symbol = "\u2b22".mint
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

  def response_format(guess_feedback)
    # puts "\nhere is the guess stuff I got: #{guess_feedback}".salmon

    color_num = guess_feedback[:correct_color]
    position_num = guess_feedback[:correct_position]
    non_matching_num = guess_feedback[:non_matches]

    colors = [@correct_color_symbol] * color_num
    positions = [@correct_position_symbol] * position_num
    non_matches = [@non_matching_symbol] * non_matching_num
    responses = colors + positions + non_matches
    responses.join(" ")
  end

  def color_line(turn_number, color_array, guess_feedback)
    "\n\t#{turn_number} | #{generate_color_line(color_array)} || #{response_format(guess_feedback)}".cyan
  end

  def print_entire_board
    entire_board = ""
    @rows.each do |color_obj|
      STDOUT.write color_line(color_obj[:turn_number], color_obj[:guess], color_obj[:guess_feedback])
      STDOUT.write "\n\t --------------------------------------------".cyan
    end
  end

end
