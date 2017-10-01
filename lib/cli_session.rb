class CliSession

  def initialize
    @random = nil
    @number_of_humans = nil
    @size_of_grid = nil
    @player_positions = [nil, nil] # set this back to nil
    @human_token_1 = nil
    @computer_token = nil
    @human_token_2 = nil
    @win_length = nil
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
    # choose win_length
    choose_win_length
    create_game
    # play game
    # then play again?
  end

  def create_game
    puts `clear`
    puts "Great! Let's Begin"
    game = Game.new(Board.new(@size_of_grid), @player_positions[0], @player_positions[1], @win_length)
    if @random
      game.make_random
    end
    game.play
    puts "Would you like to play again?"
    puts "1) Yes - same format"
    puts "2) Yes - change the rules"
    puts "3) No - this was a terrible experience"
    input = gets.strip
    case input.to_i
    when 1
      create_game
    when 2
      start
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
    case input.to_i
    when 1
      @number_of_humans = 1
    when 2
      @number_of_humans = 2
    when 3
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
      case input.to_i
      when 1
        @human_token_1 = Human.new("X")
        @computer_token = Computer.new("O")
        puts "The computer will be O then"
      when 2
        @human_token_1 = Human.new("O")
        @computer_token = Computer.new("X")
        puts "The computer will be X then"
      when 3
        start
      else
        puts "Sorry I didn't understand your command - please try again"
        choose_tokens
      end
    else # it has to be 2 here -
      # position doesn't matter so just persist the tokens
      puts "The tokens 'X' and 'O' are set"
      @human_token_1 = Human.new("X")
      @human_token_2 = Human.new("O")
      @computer_token = nil
    end
  end

  def choose_position
    @random = nil # set the value first
    if @number_of_humans == 1
      puts "Would you like the:"
      puts "1) First turn"
      puts "2) Second turn"
      puts "3) Random"
      puts "4) Return to Welcome"
      input = gets.strip
      set_player_positions(input, @human_token_1, @computer_token)
    else
      puts "Would you like:"
      puts "1) 'X' to have first turn"
      puts "2) 'O' to have first turn"
      puts "3) Random turn"
      puts "4) Return to Welcome"
      input = gets.strip
      set_player_positions(input, @human_token_1, @human_token_2)
    end
  end

  def set_player_positions(input, player_1, player_2)
    case input.to_i
    when 1
      @player_positions = [player_1, player_2]
    when 2
      @player_positions = [player_2, player_1]
    when 3
      @player_positions = [player_1, player_2]
      @random = true
    when 4
      start
    else
      puts "Sorry I didn't understand your command - please try again"
      choose_position
    end
  end

  def choose_size_of_grid
    puts "Input the size of the grid you'd like to play upon"
    puts "For example: for the classic 3 x 3 grid you'd type '3'"
    input = gets.strip
    if input.to_i > 2
      @size_of_grid = input.to_i
    else
      puts "Sorry that's not a valid board size, try again"
      choose_size_of_grid
    end
  end

  def choose_win_length
    puts "Input the length of the combo it will take to win"
    puts "For example: for the classic 3 x 3 ttt game you'd type '3'"
    puts "In this manner you can play a 5 x 5 game with the rule of 3"
    puts "Note the minimum length is 3 and the max is the length of the grid"
    input = gets.strip
    if input.to_i >= 3 && input.to_i <= @size_of_grid
      @win_length = input.to_i
    else
      puts "Sorry that's not a valid win_length, try again"
      choose_win_length
    end
  end

end
