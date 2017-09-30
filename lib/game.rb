class Game
  # shoul the rules of the game should still be 3 in a row
  # it'd be easy to test for the full row
  attr_accessor :board, :player_1, :player_2

  def initialize(board = Board.new, player_1 = Human.new("X"), player_2 = Computer.new("O"))
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def play
  end

  def turn
    puts "Please make your move: Player #{current_player.token}"
    board.display_board
    input = current_player.move(board.grid_size)
    row, position = user_input_to_nested_index(input)
    if valid_move?(row, position)
      board.update(row, position, current_player.token)
    else
      puts "Invalid position"
      turn
    end
  end

  def current_player
    turn_count % 2 == 0 ? player_1 : player_2
  end

  def turn_count
    board.count
  end

  def won?

  end

  def draw?
  end

  def winner
  end
  # this is more a helper method
  def user_input_to_nested_index(input)
    # probably should output an object for clarity
    row = ((input.to_i - 1) >= board.grid_size ? (input.to_i - 1) / board.grid_size : 0)
    position = ((input.to_i) <= board.grid_size ? input.to_i - 1 : (input.to_i - 1) % board.grid_size)
    [row, position]
  end

  def valid_move?(row, position)
    # need to shortcirtuit for position
    board.cells[row] && board.cells[row][position] == " "
  end

end
