class Game
  # shoul the rules of the game should still be 3 in a row
  # it'd be easy to test for the full row
  attr_accessor :board, :player_1, :player_2, :winner

  def initialize(board = Board.new, player_1 = Human.new("X"), player_2 = Computer.new("O"))
    @board = board
    @player_1 = player_1
    @player_2 = player_2
    @winner = nil
  end

  def make_random
    curr_player_1 = @player_1
    curr_player_2 = @player_2
    if rand(1..1000).even?
      @player_1, @player_2 = player_2, player_1
    end
    puts "By random selection: Player #{@player_1} goes first!"
  end

  def play
    until @winner || draw?
      turn
    end
    if @winner
      puts "congrats #{@winner}"
    else
      puts "cats game"
    end
  end

  def turn
    puts "Please make your move: Player #{current_player.token}"
    board.display_board
    input = current_player.move(board)
    row, position = user_input_to_nested_index(input)
    if valid_move?(row, position)
      c_p_token = current_player.token
      board.update(row, position, c_p_token)
      won?(row, position, c_p_token) ? @winner = won?(row, position, c_p_token) : nil
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

  def won?(row, col, player_token)
    #short circuit

    # what if i created a data structure that when it
    # updated a position - it also added a value to each node/element
    # around it - and then that element would have an action that fires
    # when that specific attribute reaches it's firing

    # what if i could add to each of the
    if turn_count < board.grid_size * 2 - 1
      return false
    end
    # the best idea might be to do this in a linked list sort of way
    # depth first?
    # check for token if none move to next
    # once you have a token check if neighbor is same token

    # should i do a map instead?
      # position
        # topleft - top middle top right
        # ml val mr -
        # bl bm br

    # what if i assign a value for each token
    # then have every row column and diagonal maintain a sum
    # and once it equals a certain value we know there's a winner
    # 1 & 4
    # once a set equals either 12 or 3 there's a winner
    # and you'd just have to check the 7 set's
    # update would have to add the value to
    # the set's being


    # there are 4 cases going row, col, diag, and bdiag
    #
      # row, col and previous player
    # bam! in 0(log(n))
    i = 0
    row_win = 0
    col_win = 0
    diag_win = 0
    back_diag_win = 0

    while i < board.grid_size
      if board.cells[row][i] == player_token
        row_win+=1
        if row_win == board.grid_size
          return player_token
        end
      end
      if board.cells[i][col] ==player_token
        col_win+=1
        if col_win == board.grid_size
          return player_token
        end
      end
      if board.cells[i][i] == player_token
        diag_win+=1
        if diag_win == board.grid_size
          return player_token
        end
      end
      if board.cells[i][board.grid_size-i+1] == player_token
        back_diag_win+=1
        if back_diag_win == board.grid_size
          return previous_player
        end
      end
      i+=1
    end
    false
  end

  def draw?
    board.full_board?
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
