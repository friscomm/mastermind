class Player

  attr_accessor :score, :name, :number

  def initialize(score=0, name=nil, number)
    @score = score
    @name = name
    @number = number
  end

  def name_prompt
    puts "Player#{number} please enter your name: "
    @name = gets.chomp
  end
end
