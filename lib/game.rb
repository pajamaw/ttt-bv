require 'pry'
class Game
  # shoul the rules of the game should still be 3 in a row
  # it'd be easy to test for the full row
  attr_accessor :board, :player_1, :player_2, :winner, :last_move, :win_length

  def initialize(board = Board.new, player_1 = Human.new("X"), player_2 = Computer.new("O"), win_length = nil)
    @board = board
    self.player_1 = player_1
    self.player_2 = player_2
    @winner = nil
    @last_move = nil
    @win_length = win_length || board.grid_size
  end

  def player_1=(player_1)
    @player_1 = player_1
    @player_1.game = self
    @player_1
  end

  def player_2=(player_2)
    # custom setter to add game to a user
    @player_2 = player_2
    @player_2.game = self
    @player_2
  end

  def make_random
    curr_player_1 = @player_1
    curr_player_2 = @player_2
    if rand(1..1000).even?
      @player_1, @player_2 = player_2, player_1
    end
    puts "By random selection: Player #{@player_1.token} goes first!"
  end

  def play
    until @winner || draw?
      turn
    end
    @winner ? (puts "Congratulations Player #{@winner}") : (puts "cats game")
  end

  def turn
    puts "Please make your move: Player #{current_player.token}"
    board.display_board
    # setting last_move in order to be used by the computer
    current_player.last_move = @last_move
    input = current_player.move
    puts `clear`
    # save the previous row and position not fair for the comp
    row, position = board.user_input_to_nested_index(input)
    if board.valid_move?(row, position)
      @last_move = [row, position]
      #persisting this for the use of the computer
      # persisting for the use of won
      board.update(row, position, current_player.token)
      won? ? @winner = won? : nil
    else
      puts "Invalid position"
      board.display_board
      turn
    end
  end

  def current_player
    turn_count % 2 == 0 ? player_1 : player_2
  end

  def turn_count
    # jsut an conveninence
    board.count
  end

  def won?
    if turn_count < (win_length * 2) - 1
      return false
    end
    row, col = @last_move
    player_token = board.cells[row][col]
    i = -(win_length - 1)
    row_win = 0
    col_win = 0
    diag_win = 0
    back_diag_win = 0
    while i < board.grid_size
      if !(col+i < 0)
        if board.cells[row][col+i] == player_token
          row_win+=1
          if row_win == win_length
            return player_token
          end
        else
          # restarts if not 0
          row_win = 0
        end
      end
      if !(row + i < 0)
        if board.cells[row+i] && board.cells[row+i][col] == player_token
          col_win+=1
          if col_win == win_length
            return player_token
          end
        else
          col_win = 0
        end
      end
      if !(col + i < 0 || row + i < 0)
        if board.cells[row+i] && board.cells[row+i][col+i] == player_token
          diag_win+=1
          if diag_win == win_length
            return player_token
          end
        else
          diag_win=0
        end
      end
      # need to ensure that if it's negative that it doesn't go crazy
      if !(col - i < 0 || row + i < 0)
        if board.cells[row+i] && board.cells[row+i][col-i] == player_token
          back_diag_win+=1
          if back_diag_win == win_length
            return player_token
          end
        else
          back_diag_win=0
        end
      end
      i+=1
    end
    false
  end
    # in order for this to work you need a whole different idea for diagonals
    # since you don't need to just check the middle you need to check combo's in a row
  #   1 |  2 |  x |  4 |  5 |  6
  #  ---- ---- ---- ---- ---- ----
  #   7 |  x |  9 | 10 | 11 | 12
  #  ---- ---- ---- ---- ---- ----
  #  x | 14 | 15 | 16 | o | 18
  #  ---- ---- ---- ---- ---- ----
  #  19 | 20 | 21 | o | 23 | 24
  #  ---- ---- ---- ---- ---- ----
  #  25 | 26 | o | 28 | 29 | 30
  #  ---- ---- ---- ---- ---- ----
  #  31 | 32 | 33 | 34 | 35 | 36

  # 1) x+1, y+1 && x+2, y+2 bottom left of asc
  # 2) x-1, y-1 && x-2, y-2 top right of asc

  # 3) x-1, y-1 && x+1, y+1 middle ascending
  # 4) x-1, y+1 && x+1, y-1 middle descending

  # 5) x+1, y-1 && x+2, y-2 top left of desc
  # 6) x-1, y+1 && x-2, y+2 bottom right of desc

  def draw?
    board.full_board?
  end

end
