class CliSession
  
  def initialize
    @random = nil
    @number_of_humans = nil
    @size_of_grid = nil
    @player_positions = [nil, nil]
    @human_token_1 = nil
    @human_token_2 = nil
  end

  def start
    # Welcome message

    # get number of players
    # verify that's valid

    # get tokens for players
    #

    # choose who goes first or if random

    # get size of game
    # verify that it's valid

    # play game
    # then play again?
  end





  def cli
    puts `clear`
    puts "Welcome to TTT-BV"
    puts "Type 'new' to begin a new game"
    puts "Type 'help' if you're interested to see what you can do here"
    cli_input = gets.strip.downcase
    while cli_input != "quit"
      case cli_input
      when "help"
        help_cli
      when "new"
        puts "New game selected:"
        number_of_players
      else
        puts `clear`
        puts "Sorry I didn't understand that please type 'help' if you have any questions or 'quit' to exit"
        cli_input = gets.strip
      end
    end
  end

  def number_of_players
    puts "Press the number corresponding with the desired number of players"
    puts "1) Human vs Computer"
    puts "2) Human vs Human"
    player_input = gets.strip
    while player_input != "quit"
      case player_input
      when "1"
        human_vs_computer_game
      when "2"
        human_vs_human_game
      else
        puts "Sorry I didn't understand please input your choice"
        player_input = gets.strip
      end
    end
  end

  def choose_size_of_grid
    puts "Input the size of the grid you'd like to play upon"
    puts "For example: for the classic 3 x 3 grid you'd type '3'"
    size_of_grid = gets.strip
  end

  def choose_token
    puts "Select your token"
    puts "1) X"
    puts "2) O"
    gets.strip
  end

  def choose_position
    puts "Would you like to go 1) first, 2) second, 3) or randomly choose?"
    player_position_input = gets.strip
  end

  def human_vs_human_game
    size_of_grid = choose_size_of_grid
    token = choose_token
    placement = choose_position
    opposite_token = choose_token == "X" ? "O" : "X"
    game = Game.new(board: Board.new(size_of_grid), player_1: placement == "1" ? Human.new(token) : Computer.new(opposite_token), player_2: placement == "2" ? Human.new(token) : Computer.new(opposite_token) )

  end

  def human_vs_computer_game
    size_of_grid = choose_size_of_grid
    token_input = gets.strip.upcase

  end

  def help_cli
    puts `clear`
    puts "Actions:"
    puts "'help' - bring up this help screen"
    puts "'quit' - end the cli"
  end
end
