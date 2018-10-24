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

  def self.is_number?(item)
    if item.to_i == 0
      false
    else
      true
    end
  end

  def self.valid_number?(number)
    if number < 1 || number > 100
      false
    else
      true
    end
  end
end
