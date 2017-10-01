class CliSession

  def initialize
    @random = nil
    @number_of_humans = nil
    @size_of_grid = nil
    @player_positions = [nil, nil] # set this back to nil
    @human_token_1 = nil
    @computer_token = nil
    @human_token_2 = nil
    # maybe turn this into a hash that I can just give the new method for ease
  end

  def start
    # Welcome message
    puts `clear`
    puts "Welcome to BV-TicTacToe!"
    # get number of players
    # verify that's valid
    how_many_players
    # get tokens for players
    choose_tokens

    # choose who goes first or if random
    choose_position

    # get size of game
    # verify that it's valid
    choose_size_of_grid
    create_game
    # play game
    # then play again?
  end

  def create_game
    game = Game.new(board: Board.new(@size_of_grid), player_1: @player_positions[0], player_2: @player_positions[1])
    if @random
      game.make_random
    end
    game.play
    puts "Would you like to play again?"
    puts "1) Yes - same format"
    puts "2) Yes - change the rules"
    puts "3) No - this was a terrible experience"
    input = gets.strip
    if input.to_i.between?(1,2)
      if input.to_i === 1
        create_game
      else
        start
      end
    else
      puts "Thanks for playing!"
    end
  end

  def how_many_players
    puts "Would you like to play:"
    puts "1) Human v Computer"
    puts "2) Human v Human"
    puts "3) Return to Welcome"
    input = gets.strip
    if input.to_i.between?(1,2)
      @number_of_humans = input.to_i
    elsif input.to_i == 3
      start
    else
      puts "Sorry I didn't understand your command - please try again"
      how_many_players
    end
  end

  def choose_tokens
    if @number_of_humans == 1
      puts "Would you like to be:"
      puts "1) X"
      puts "2) O"
      puts "3) Return to Welcome"
      input = gets.strip
      if input.to_i == 1
        @human_token_1 = "X"
        @computer_token = "O"
        puts "The computer will be O then"
      elsif input.to_i == 2
        @human_token_1 = "O"
        @computer_token = "X"
        puts "The computer will be X then"
      elsif input.to_i == 3
        start
      else
        puts "Sorry I didn't understand your command - please try again"
        choose_tokens
      end
    else # it has to be 2 here -
      # position doesn't matter yet
      puts "The tokens 'X' and 'O' are set"
      @human_token_1 = "X"
      @human_token_2 = "O"
      @computer_token = nil
    end
  end
  # this can be cleaned up
  def choose_position
    @random = nil # set the value first
    if @number_of_humans == 1
      puts "Would you like the:"
      puts "1) First turn"
      puts "2) Second turn"
      puts "3) Random"
      puts "4) Return to Welcome"
      input = gets.strip
      if input.to_i.between?(1,4)
        if input.to_i.between?(1,2)
          if input.to_i == 1
            @player_positions = [Human.new(@human_token_1), Computer.new(@computer_token)]
          else
            @player_positions = [Computer.new(@computer_token), Human.new(@human_token_1)]
          end
        elsif input.to_i == 3
          @player_positions = [Human.new(@human_token_1), Computer.new(@computer_token)]
          @random = true
        else
          start
        end
      else
        puts "Sorry I didn't understand your command - please try again"
        choose_position
      end
    else
      puts "Would you like:"
      puts "1) 'X' to have first turn"
      puts "2) 'O' to have first turn"
      puts "3) Random turn"
      puts "4) Return to Welcome"
      if input.to_i.between?(1,4)
        if input.to_i.between?(1,2)
          if input.to_i == 1
            @player_positions = [Human.new(@human_token_1), Human.new(@human_token_2)]
          else
            @player_positions = [Human.new(@human_token_2), Human.new(@human_token_1)]
          end
        elsif input.to_i == 3
          @player_positions = [Human.new(@human_token_1), Human.new(@human_token_2)]
          @random = true
        else
          start
        end
      else
        puts "Sorry I didn't understand your command - please try again"
        choose_position
      end
    end
  end

  def choose_size_of_grid
    puts "Input the size of the grid you'd like to play upon"
    puts "For example: for the classic 3 x 3 grid you'd type '3'"
    input = gets.strip
    if input.to_i > 0
      @size_of_grid = input.to_i
    else
      puts "Sorry that's not a valid board size, try again"
      choose_size_of_grid
    end
  end

end
