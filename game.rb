# require_relative 'board'
require_relative 'colorize'
require_relative 'player'
require_relative 'submit_pattern'

class Game

  attr_accessor :current_game, :p1, :p2, :pattern_maker, :pattern_breaker, :secret_pattern, :turn_number

  def initialize(current_game, p1, p2, board)
    @current_game = current_game
    @p1 = p1
    @p2 = p2
    @board = board
    @pattern_maker = nil
    @pattern_breaker = nil
    @secret_pattern = nil
    @turn_number = 0
  end

  def print_entire_board

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

  def correct_guess?
    if @board.rows.last[:guess].join(',') == @secret_pattern.join(',')
      puts "You WIN!".salmon
      true
    else
      false
    end
  end

#this is not for guessing, this is actually for creating the secret pattern
  def set_pattern
    puts "#{@pattern_maker}, please create a secret pattern below using the arrow keys"
    s = SubmitPattern.new
    s.read_keypresses_maker
    @secret_pattern = s.stored_colors
  end

  def guess_pattern
    puts "#{@pattern_breaker}, please guess the secret pattern below using the arrow keys"
    s = SubmitPattern.new
    s.read_keypresses_breaker
    @board.rows << {turn_number: @turn_number, guess: s.stored_colors}
    puts "Here are the current values in the Board class: board.rows = #{@board.rows}"
  end

  def turn
    guess_pattern
    if correct_guess?
      @turn_number = 12
    end
  end

  def start_game
    set_roles
    set_pattern
    # puts "The pattern_maker is #{@pattern_maker}; the pattern_breaker is #{@pattern_breaker}; and the current game is ##{@current_game}"
    while @turn_number <= 12
      turn
      @turn_number += 1
    end
  end

end
