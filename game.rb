# require_relative 'board'
require_relative 'colorize'
require_relative 'player'

class Game

  attr_accessor :current_game, :p1, :p2, :pattern_maker, :pattern_breaker

  def initialize(current_game, p1, p2)
    @current_game = current_game
    @pattern_maker = nil
    @pattern_breaker = nil
    @p1 = p1
    @p2 = p2
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

  def check_guess

  end

  def guess_pattern

  end

  def turn
    guess_pattern
    check_guess
  end

  def start_game
    set_roles
    puts "The pattern_maker is #{@pattern_maker}; the pattern_breaker is #{@pattern_breaker}; and the current game is ##{@current_game}"
  end

end
