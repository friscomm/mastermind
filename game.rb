# require_relative 'board'
require_relative 'colorize'
require_relative 'player'
require_relative 'submit_pattern'

class Game

  attr_accessor :current_game, :turn_number, :p1, :p2, :pattern_maker, :pattern_breaker, :secret_pattern, :guess_feedback, :most_recent_guess

  def initialize(current_game, p1, p2, board)
    @current_game = current_game
    @turn_number = 1
    @p1 = p1
    @p2 = p2
    @board = board
    @pattern_maker = nil
    @pattern_breaker = nil
    @secret_pattern = nil
    @guess_feedback = nil
    @most_recent_guess = ''
  end

  def set_roles
    if @current_game.even?
      @pattern_maker = p2
      @pattern_breaker = p1
    else
      @pattern_maker = p1
      @pattern_breaker = p2
    end
  end

  # def generate_response
  #   guess = @most_recent_guess
  #   pattern = @secret_pattern
  #
  #   if guess.join(',') == pattern.join(',')
  #     puts "You WIN!".salmon
  #     @turn_number = 12
  #   end
  #
  #   guess.each_with_index do |color, i|
  #     if pattern[i] == color
  #       @guess_feedback[:correct_position] += 1
  #       @guess_feedback[:non_matches] -= 1
  #     elsif pattern[i] != color && pattern.include?(color)
  #       @guess_feedback[:correct_color] += 1
  #       @guess_feedback[:non_matches] -= 1
  #     end
  #   end
  # end

  def set_secret_pattern
    puts "#{@pattern_maker.name}, please create a secret pattern below using the left/right arrow keys to move between spaces and up/down arrow keys to change colors"
    s = SubmitPattern.new
    s.read_keypresses_maker
    @secret_pattern = s.stored_colors
  end

  def set_feedback
    s = SubmitPattern.new
    s.generate_response(@most_recent_guess, @secret_pattern)
    @guess_feedback = s.stored_feedback
  end

  def set_guess_pattern
    puts "#{@pattern_breaker.name}, please guess the secret pattern using the left/right arrow keys to move between spaces and up/down arrow keys to change colors"
    s = SubmitPattern.new
    s.read_keypresses_breaker
    @most_recent_guess = s.stored_colors
  end

  def save_current_row
    @board.rows << {turn_number: @turn_number, guess: @most_recent_guess, guess_feedback: @guess_feedback}
  end

  def turn
    set_guess_pattern
    set_feedback
    # if correct_guess?
    #   @turn_number = 12
    # else
      # tally_score
      save_current_row
      puts "\n#{@board.print_entire_board}"
    # end
    # puts "PRINT THE ENTIRE BOARD with TURNS!! \n#{@board.print_entire_board(@guess_feedback)}"
  end

  def distribute_points
    @codemaker.score += 1
  end

  def winning_guess?
    if @most_recent_guess.join(',') == @secret_pattern.join(',')
      true
    else
      false
    end
  end

  def start_turns
    while @turn_number <= 12
      turn
      @turn_number += 1
    end
  end

  def start_game
    set_roles
    set_secret_pattern
    start_turns
  end

end
