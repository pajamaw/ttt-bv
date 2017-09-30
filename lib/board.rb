class Board
  attr_accessor :cells, :count, :grid_size

  def initialize(grid_size = 3)
    # I think an array will provide an easy update
    # and easy check for winner
    # need to separate the call otherwise the object_id
    # is the same
    @grid_size = grid_size
    @cells = Array.new(grid_size) { Array.new(grid_size, " ")}
    # Don't have to run expensive operations until
    # count is adequate size
    @count = 0
  end

  def full_board?
    @count == @grid_size**2
  end

  def update(row, column, player)
    @cells[row][column] = player
    @count +=1
    @cells
  end

  def display_board
    board = ""
    i = 0
    # is there anyway that I can persist this somehow?
    # some meta programming
    # despite the double loops it's still just going in O(n) time

    while i < grid_size
      j = 0
      while j < grid_size
        # the board could get pretty big so it may be tough to pick spots unless
        # they're listed out
        board.concat(" #{@cells[i][j]} |")
        j == grid_size - 1 ? board = board[0...-1] : nil
        j += 1
      end
      i != grid_size - 1 ? board.concat("\n #{"--- "*grid_size} \n") : nil
      i += 1
    end
    puts board
  end
  # added for testing purposes really
  def reset!
    # can't set it to cells for some reason
    @cells = Array.new(grid_size) { Array.new(grid_size, " ")}
  end
end
