require_relative 'colorize'
require_relative 'player'
require_relative 'rules'
require_relative 'game'
require_relative 'board'

class MetaGame

  def initialize
    @current_game = 1
    @number_of_games = 0
    @p1 = Player.new(1)
    @p2 = Player.new(2)
    @banner = "
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   __   __          _                      _           _
  |  \\/  |         | |                    (_)         | |
  | \\  / | __ _ ___| |_ ___ _ __ _ __ ___  _ _ __   __| |
  | |\\/| |/ _` / __| __/ _ | '__| '_ ` _ \\| | '_ \\ / _` |
  | |  | | (_| \\__ | ||  __| |  | | | | | | | | | | (_| |
  |_|  |_|\\__,_|___/\\__\\___|_|  |_| |_| |_|_|_| |_|\\__,_|

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
  end

  def start_meta_game
    print_banner
    gather_info
    feedback_explanation
    manage_games
  end

  def print_banner
    puts @banner.flamingo
  end

  def gather_info
    @p1.name_prompt
    @p2.name_prompt
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

  def feedback_explanation
    puts "Pattern guessers will recieve feedback in the form of hexagons \nGreen Hexagon: a guess has the correct position and color \nYellow Hexagon: a guess has the wrong position and correct color \nEmpty Hexagon: a guess has the wrong position and wrong color".flamingo
  end

  def next_game
    puts "Moving to the next game!".mint
    @current_game += 1
  end

  def final_game
    i = 3
    message = "\rThat's the last game! Tallying score."
    while i > 0
      message += "."
      print message
      i-=1
      sleep 1
    end
    print "\n"
    @current_game += 1
  end

  def end_game_message
    if @current_game != @number_of_games
      next_game
    else
      final_game
    end
  end

  def get_winner
    if @p1.score > @p2.score
      @p1.name
    else
      @p2.name
    end
  end

  def tie_game?
    if @p1.score == @p2.score
      true
    else
      false
    end
  end

  def game_over_message
    if tie_game?
      puts "Tie game....Everybody wins!".mint
    else
      puts "#{get_winner} wins!".mint
    end
  end

  def current_score
    puts "#{@p1.name}: #{@p1.score} points"
    puts "#{@p2.name}: #{@p2.score} points"
  end

  def manage_games
    while @current_game <= @number_of_games do
      board = Board.new
      game = Game.new(@current_game, @p1, @p2, board)
      game.start_game
      end_game_message
      current_score
    end
    game_over_message
  end

end
