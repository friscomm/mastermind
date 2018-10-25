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

  def convert_guess_array(guess_array)
    holder = []
    guess_array.each do |obj|
      unless obj[:color].nil?
        holder << @marker_template.send(obj[:color])
      end
    end
    holder.join('  ')
  end

  def feedback_format(guess_feedback)
    color_num = guess_feedback[:correct_color]
    position_num = guess_feedback[:correct_position]
    non_matching_num = guess_feedback[:non_matches]

    colors = [@correct_color_symbol] * color_num
    positions = [@correct_position_symbol] * position_num
    non_matches = [@non_matching_symbol] * non_matching_num
    feedback = colors + positions + non_matches
    feedback.join(" ")
  end

  def format_guess_line(turn_number, guess_array, guess_feedback)
    "\n\t#{turn_number} | #{convert_guess_array(guess_array)} ||   #{feedback_format(guess_feedback)}".cyan
  end

  def print_entire_board
    entire_board = ""
    @rows.each do |color_obj|
      entire_board += format_guess_line(color_obj[:turn_number], color_obj[:guess], color_obj[:guess_feedback])
      entire_board += "\n\t -----------------------------------".cyan
    end
    print entire_board
  end

end
