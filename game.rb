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

  def start_game
    set_roles
    set_secret_pattern
    start_turns
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
    guess_pattern_message
    s = SubmitPattern.new
    s.read_keypresses_breaker
    s.move_cursor_up
    s.clear_line
    @most_recent_guess = s.stored_colors
  end

  def guess_pattern_message
    if @turn_number == 1
      puts "#{@pattern_breaker.name}, please guess the secret pattern using the left/right arrow keys to move between spaces and up/down arrow keys to change colors"
    else
      puts "#{@pattern_breaker.name}, please enter your guess:"
    end
  end

  def save_current_row
    @board.rows << {turn_number: @turn_number, guess: @most_recent_guess, guess_feedback: @guess_feedback}
  end

  def start_turns
    while @turn_number <= 12
      turn
      @turn_number += 1
    end
  end

  def turn
    set_guess_pattern
    set_feedback
    save_current_row
    puts "\n#{@board.print_entire_board}"
    if winning_guess? && @turn_number != 12
      @turn_number = 12
    elsif winning_guess? && @turn_number == 12
      @turn_number = 12
      distribute_points
    else
      distribute_points
    end
  end

  def distribute_points
    @pattern_maker.score += 1
  end

  def winning_guess?
    if @most_recent_guess.join(',') == @secret_pattern.join(',')
      true
    else
      false
    end
  end

end
