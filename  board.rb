class Board
  attr_accessor :board_values

  def initialize
    @rows = [ { guesses: [], response: [] } ]
  end

  def change_board(key, new_value)
    # @board_values[key] = new_value
  end

  # def row_format(args)
  #   " #{args[0]} #{args[1]} #{args[2]} #{args[3]}"
  # end
  # 
  # def get_group(first, second, third, fourth)
  #   @board_values.fetch_values(first, second, third, fourth)
  # end

  def show_board

  end

end
