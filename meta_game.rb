
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
    @banner = "
   __   __          _                      _           _
  |  \\/  |         | |                    (_)         | |
  | \\  / | __ _ ___| |_ ___ _ __ _ __ ___  _ _ __   __| |
  | |\\/| |/ _` / __| __/ _ | '__| '_ ` _ \\| | '_ \\ / _` |
  | |  | | (_| \\__ | ||  __| |  | | | | | | | | | | (_| |
  |_|  |_|\\__,_|___/\\__\\___|_|  |_| |_| |_|_|_| |_|\\__,_|

    "
  end

  def start_meta_game
    p1 = Player.new(1)
    p2 = Player.new(2)
    print_banner
    gather_info(p1, p2)
    manage_games(p1, p2)
  end

  def print_banner
    puts @banner.flamingo
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

  def current_score(p1, p2)
    puts "#{p1.name}'s points: #{p1.score}".flamingo
    puts "#{p2.name}'s points: #{p2.score}".flamingo
  end

  def manage_games(p1, p2)
    while @current_game <= @number_of_games do
      board = Board.new
      game = Game.new(@current_game, p1, p2, board)
      game.start_game
      next_game
      current_score(p1, p2)
    end
    game_over
  end

end
