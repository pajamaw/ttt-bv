class Board
  attr_accessor :cells, :count, :size

  def initialize(size = 3)
    @cells = Array.new(size, Array.new(size, ""))
    @count = 0
    @size = size
  end

  def full_board
    @count == @size^2
  end

  def update(row, column, player)
    @cells[row[position]] = player
    @count++
  end

end
