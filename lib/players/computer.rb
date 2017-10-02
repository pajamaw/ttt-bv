class Computer < Player
  attr_accessor :comp_last_move, :game

  def initialize(token)
    super(token)
    @comp_last_move = nil
    @last_move = nil
  end

  def move
    # just a place holder for now
      # with check_for_two the game becomes unbeatable
    if check_for_double && game.turn_count > 2
      puts "Thinking about this move..."
      sleep 2
      @comp_last_move = check_for_double
    elsif game.turn_count < 3
      @comp_last_move = best_starters
    else
      @comp_last_move = game.board.user_input_to_nested_index(rand(1..game.board.grid_size**2))
    end
  end

  def best_starters
   if !game.board.grid_size.even? && game.board.valid_move?(middle_position[0], middle_position[1])
     middle_position
   else
     grab_corner_position
   end
  end

  def middle_position
    # basic advantageous spot
    [(game.board.grid_size/2), (game.board.grid_size/2)]
  end

  def grab_corner_position
    # basic advantageous spot
    [[0, game.board.grid_size-1], [game.board.grid_size-1, game.board.grid_size-1], [0,0], [game.board.grid_size-1, 0]].sample
  end

  def check_for_double
    if check_for_win
      puts "Going for the Win!"
      check_for_win
    else
      puts "Nice try!"
      check_for_block
    end
  end

  def check_for_block
    # just pass in the previous players move to check for blocks
    if !last_move
      return nil
    end
    row, col = last_move

    scan_previous_position(row, col)
  end

  def check_for_win
    # just pass in the current players move to check for wins
    if !@comp_last_move
      return nil
    end
    # thus we can distinguish a block and a win
    row, col = @comp_last_move
    scan_previous_position(row, col)
  end

  def scan_previous_position(row, col)
    i = -(game.win_length-1)
    row_count = 0
    last_in_row = nil
    col_count = 0
    last_in_column = nil
    diag_count = 0
    last_in_diag = nil
    back_diag_count = 0
    last_in_back_diag = nil
    opp_token = token == "X" ? "O" : "X"
    row_position = nil
    col_position = nil
    diag_position = nil
    back_diag_position = nil
    # now what we'll do here is
    # subtract for opponent token and add for comp token
    # once any combo equals an abs 2 then add the value their
    # iterate through the various places based on it's location
    # and collect the empty space
    # once it get's to this point at least
    # bam thinking of a move pretty quick again

    while i < game.board.grid_size
      # checks each column
      if !(i < 0)
        row_count +=1 if game.board.cells[row] && game.board.cells[row][i] == token
        row_count-=1 if game.board.cells[row] && game.board.cells[row][i] == opp_token
        row_position = [row, i] if game.board.cells[row] && game.board.cells[row][i] == " "
        # need to ensure that they've reached the final position as well
        if row_count.abs == game.win_length - 1 && row_position != nil
          return row_position
        end
      end
      if !(i < 0)
        # checks each column
        col_count+=1 if game.board.cells[i] && game.board.cells[i][col] == token
        col_count-=1 if game.board.cells[i] && game.board.cells[i][col] == opp_token
        col_position = [i, col] if game.board.cells[i] && game.board.cells[i][col] == " "
        if col_count.abs == game.win_length - 1 && col_position != nil
          return col_position
        end
      end
      # need to ensure that it's not jumping behind - in small games not an issue
      if !(row + i < 0 || col + i < 0)
        # checks each right ascending diagonal
        diag_count+=1 if game.board.cells[row+i] && game.board.cells[row+i][col+i] == token
        diag_count-=1 if game.board.cells[row+i] && game.board.cells[row+i][col+i] == opp_token
        diag_position = [row+i, col+i] if game.board.cells[row+i] && game.board.cells[row+i][col+i] == " "
        if diag_count.abs == game.win_length - 1 && diag_position != nil
          return diag_position
        end
      end
      if !(row + i < 0 || col - i < 0)
        # checks each right descending diagonal
        back_diag_count+=1 if game.board.cells[row+i] && game.board.cells[row+i][col-i] == token
        back_diag_count-=1 if game.board.cells[row+i] && game.board.cells[row+i][col-i] == opp_token
        back_diag_position = [row+i, col-i] if game.board.cells[row+i] && game.board.cells[row+i][col-i] == " "
        if back_diag_count.abs == game.win_length - 1 && back_diag_position != nil
          return back_diag_position
        end
      end
      i+=1
    end
    nil
  end

end
