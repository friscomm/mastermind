class Player

  attr_accessor :score
  attr_reader :name

  def initialize(score=0, name=nil, number)
    @score = score
    @name = name
    @number = number
  end

  def name_prompt
    puts "Player#{@number} please enter your name: "
    @name = gets.chomp
  end
end
