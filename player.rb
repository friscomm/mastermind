class Player

  attr_accessor :score, :name, :number

  def initialize(score=0, name=nil, number)
    self.score = score
    self.name = name
    self.number = number
  end

  def name_prompt
    puts "Player#{number} please enter your name: "
    @name = gets.chomp
  end

  def quick_show
    i = "here is the code"
    10.times{ |i| STDOUT.write "\r#{i}"; sleep 1 } 
  end

end
