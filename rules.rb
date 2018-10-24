require_relative 'colorize'

class Rules

  def self.invalid_number_of_games?(number)
    if number < 1
      puts "Please enter a number greater than 0".red
      true
    elsif number.odd?
      puts "Please enter an even number of games".red
      true
    else
      false
    end
  end

end
