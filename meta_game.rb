
require_relative 'colorize'
require_relative 'player'
require_relative 'rules'
require_relative 'game'
require_relative 'board'

class MetaGame

  attr_accessor :current_game, :number_of_games

  def initialize
    @current_game = 0
    @number_of_games = 0
  end

  def start_meta_game
    p1 = Player.new(1)
    p2 = Player.new(2)
    gather_info(p1, p2)
    manage_games(p1, p2)
  end

  def gather_info(p1, p2)
    p1.name_prompt
    p2.name_prompt
    game_number_prompt
  end

  def game_number_prompt
    puts "How many games do you want to play? "
    answer = gets.chomp.to_i
    if Rules.invalid_number_of_games?(answer)
      game_number_prompt
    else
      @number_of_games = answer
    end
  end

  def next_game
    puts "Moving to the next game!".mint
    @current_game += 1
  end

  def game_over
    puts "that's all folks!".mint
  end

  def manage_games(p1, p2)
    while @current_game <= @number_of_games do
      board = Board.new
      game = Game.new(@current_game, p1, p2, board)
      game.start_game
      next_game
    end
    game_over
  end

end
