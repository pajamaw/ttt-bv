class Computer < Player
  attr_accessor :comp_last_move

  def initialize(token)
    super(token)
    @comp_last_move = nil
  end

  def move(board, last_position)
    # just a place holder for now
      # with check_for_two the game becomes unbeatable
    if check_for_double(board, last_position)
      puts "Thinking about this move"
      sleep 2
      @comp_last_move = check_for_double(board, last_position)
    elsif board.count < 3
      sleep 2
        @comp_last_move = best_starters(board)
    else
        @comp_last_move = (1..board.grid_size**2).sample
    end
  end

  def best_starters(board)
   if !board.grid_size.even? && board.valid_move?(middle_position(board)[0], middle_position(board)[1])
     middle_position(board)
   else
     grab_corner_position(board)
   end
  end

  def middle_position(board)
    [(board.grid_size/2), (board.grid_size/2)]
  end

  def grab_corner_position(board)
    [[0, board.grid_size-1], [board.grid_size-1, board.grid_size-1], [0,0], [board.grid_size-1, 0]].sample
  end

  def simple_move(board)
    rand(1...board.grid_size**2)
  end


  def check_for_double(board, last_position)
    check_for_win(board) || check_for_block(board, last_position)
  end

  def check_for_block(board, last_position)
    # similar logic to the win checker
    # only this should check for 2 and then strike
    # so ultimately should just check
    # for a winner or a block
    # now what we'll do here is
    # subtract for opponent token and add for comp token
    # once any combo equals an abs 2 then add the value their
    # iterate through the various places based on it's location
    # and collect the empty space
    # once it get's to this point at least
    # bam thinking of a move pretty quick again
    if !last_position || last_position == []
      return nil
    end
    row, col = last_position

    scan_previous_position(board, row, col)
  end

  def check_for_win(board)
    # similar logic to the win checker
    # only this should check for 2 and then strike
    # so ultimately should just check
    # for a winner or a block
    if !@comp_last_move
      return nil
    end
    row, col = @comp_last_move
    scan_previous_position(board, row, col)
  end

  def scan_previous_position(board, row, col)
    i = 0
    j = board.grid_size - 1
    row_count = 0
    col_count = 0
    diag_count = 0
    back_diag_count = 0
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


    while i < board.grid_size
      row_count+=1 if board.cells[row][i] == token
      row_count-=1 if board.cells[row][i] == opp_token
      row_position = [row, i] if board.cells[row][i] == " "
      # need to ensure that they've reached the final position as well
      if row_count.abs == board.grid_size - 1 && row_position != nil
        return row_position
      end

      col_count+=1 if board.cells[i][col] == token
      col_count-=1 if board.cells[i][col] == opp_token
      col_position = [i, col] if board.cells[i][col] == " "
      if col_count.abs == board.grid_size - 1 && col_position != nil
        return col_position
      end

      diag_count+=1 if board.cells[i][i] == token
      diag_count-=1 if board.cells[i][i] == opp_token
      diag_position = [i, i] if board.cells[i][i] == " "
      if diag_count.abs == board.grid_size - 1 && diag_position != nil
        return diag_position
      end

      back_diag_count+=1 if board.cells[i][j] == token
      back_diag_count-=1 if board.cells[i][j] == opp_token
      back_diag_position = [i, j] if board.cells[i][j] == " "
      if back_diag_count.abs == board.grid_size - 1 && back_diag_position != nil
        return back_diag_position
      end
      i+=1
      j-=1
    end
    nil
  end
end
