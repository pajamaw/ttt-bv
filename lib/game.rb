class Game
  attr_accessor :board, :player_1, :player_2

  def initialize(board, player_1, player_2)
  end

  def play
  end

  def turn
    puts "Please make your move"

  end

  def current_player
  end

  def turn_count
    @board.count
  end

  def won?
  end

  def draw?
  end

  def winner
  end

  def user_input_to_nested_index(input)
    row = input.to_i - 1 % size
    position = input.to_i / size
    [row, position]
  end

  def valid_move?(row, position)
    @board.cells[row[position]] == ""
  end

end
