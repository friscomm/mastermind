# require_relative 'board'
require_relative 'colorize'
require_relative 'player'
require_relative 'submit_pattern'

class Game

  attr_accessor :current_game, :p1, :p2, :pattern_maker, :pattern_breaker, :secret_pattern, :turn_number, :most_recent_guess, :guess_feedback

  def initialize(current_game, p1, p2, board)
    @current_game = current_game
    @p1 = p1
    @p2 = p2
    @board = board
    @pattern_maker = nil
    @pattern_breaker = nil
    @secret_pattern = nil
    @turn_number = 0
    @most_recent_guess = ''
    @guess_feedback = {correct_position: 0, correct_color: 0, non_matches: 4}
  end

  def set_roles
    if @current_game.even?
      @pattern_maker = p2.name
      @pattern_breaker = p1.name
    else
      @pattern_maker = p1.name
      @pattern_breaker = p2.name
    end
  end

  # def correct_guess?
  #   guess = @board.rows.last[:guess]
  #   pattern = @secret_pattern
  #   if guess.join(',') == pattern.join(',')
  #     puts "You WIN!".salmon
  #     true
  #   else
  #     false
  #   end
  # end

  def reset_score
    @guess_feedback[:correct_position], @guess_feedback[:correct_color] = 0, 0
    @guess_feedback[:non_matches] = 4
  end

  def tally_score
    guess = @most_recent_guess
    pattern = @secret_pattern

    if guess.join(',') == pattern.join(',')
      puts "You WIN!".salmon
      @turn_number = 12
    end

    guess.each_with_index do |color, i|
      if pattern[i] == color
        @guess_feedback[:correct_position] += 1
        @guess_feedback[:non_matches] -= 1
      elsif pattern[i] != color && pattern.include?(color)
        @guess_feedback[:correct_color] += 1
        @guess_feedback[:non_matches] -= 1
      end
    end
  end

  def set_pattern
    puts "#{@pattern_maker}, please create a secret pattern below using the left/right arrow keys to move between spaces and up/down arrow keys to change colors"
    s = SubmitPattern.new
    s.read_keypresses_maker
    @secret_pattern = s.stored_colors
  end

  def guess_pattern
    puts "#{@pattern_breaker}, please guess the secret pattern using the left/right arrow keys to move between spaces and up/down arrow keys to change colors"
    s = SubmitPattern.new
    s.read_keypresses_breaker
    @most_recent_guess = s.stored_colors
    # @board.rows << {turn_number: @turn_number, guess: s.stored_colors}
    # puts "Here are the current values in the Board class: board.rows = #{@board.rows}"
  end

  def save_current_row
    @board.rows << {turn_number: @turn_number, guess: @most_recent_guess, guess_feedback: @guess_feedback}
  end

  def turn
    guess_pattern
    # if correct_guess?
    #   @turn_number = 12
    # else
      tally_score
      save_current_row
      puts "Here are the current standings, correct_position: #{@guess_feedback[:correct_position]}, correct_color: #{@guess_feedback[:correct_color]}, non_matches: #{@guess_feedback[:non_matches]}".yellow

      # @board.rows[@turn_number][:guess_feedback] = @guess_feedback
      puts "lets see if that worked! #{@board.rows}"
      puts "PRINT THE ENTIRE BOARD with TURNS!! \n#{@board.print_entire_board}"
      reset_score
    # end
    # puts "PRINT THE ENTIRE BOARD with TURNS!! \n#{@board.print_entire_board(@guess_feedback)}"
  end

  def start_turns
    while @turn_number <= 12
      turn
      @turn_number += 1
    end
  end

  def start_game
    set_roles
    set_pattern
    start_turns
  end

end
