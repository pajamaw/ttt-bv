describe "Game" do
  let(:human_playerx){Human.new("X")}
  let(:human_playero){Human.new("O")}
  let(:computer_playerx){Computer.new("X")}
  let(:computer_playero){Computer.new("O")}
  let(:board){Board.new}
  let(:board5){Board.new(5)}

  let(:default_game) {Game.new}
  let(:pvp_game) { Game.new(board, human_playerx, human_playero) }

  let(:game_5) {Game.new(board5)}

  describe "#initialize" do
    it " has a board attribute with a default value of a 3 x 3 nested array" do
      expect(default_game).to respond_to(:board)
      expect(default_game.board).to be_an_instance_of(Board)
    end
    it " has a player_1 attribute with a default value of a Human instance" do
      expect(default_game).to respond_to(:player_1)
      expect(default_game.player_1).to be_an_instance_of(Human)
    end
    it " has a player_2 attribute with a default value of a Computer instance" do
      expect(default_game).to respond_to(:player_2)
      expect(default_game.player_2).to be_an_instance_of(Computer)
    end
  end

  describe "#current_player" do
    it "returns player_1 if the turn_count is even" do
      expect(default_game.current_player).to eq(default_game.player_1)
    end
    it "returns player_2 if the turn_count is odd" do
      default_game.board.update(0, 0, "X")
      expect(default_game.current_player).to eq(default_game.player_2)
      default_game.board.reset!
    end
  end
  describe "#turn" do
    it "asks the current_user's for input" do
      # need to have these two line for every single test with get's
      expect(default_game.player_1).to receive(:gets).and_return("1")
      expect{default_game.turn}.to output.to_stdout
      default_game.board.reset!
    end
    it "checks to see if the input is valid" do
      input = "1"
      expect(default_game.player_1).to receive(:gets).and_return(input)
      row, position = default_game.board.user_input_to_nested_index(input)
      expect(default_game.board.valid_move?(row, position)).to eq(true)
      expect{default_game.turn}.to output.to_stdout
      default_game.board.reset!
    end
    it "if valid it updates the board with the input" do
      input = "3"
      expect(default_game.player_1).to receive(:gets).and_return(input)
      expect{default_game.turn}.to output.to_stdout
      expect(default_game.board.cells).to eq([[" ", " ", "X"], [" ", " ", " "], [" ", " ", " "]])
      default_game.board.reset!
    end
    it "if valid it updates the board with the input" do
      input = "5"
      expect(default_game.player_1).to receive(:gets).and_return(input)
      expect{default_game.turn}.to output.to_stdout
      expect(default_game.board.cells).to eq([[" ", " ", " "], [" ", "X", " "], [" ", " ", " "]])
      default_game.board.reset!
    end
    it "if not valid it does not update the board" do
      input = "5"
      expect(pvp_game.player_1).to receive(:gets).and_return(input)
      expect{pvp_game.turn}.to output.to_stdout
      expect(pvp_game.board.cells).to eq([[" ", " ", " "], [" ", "X", " "], [" ", " ", " "]])

      invalid_input = "11"
      #basically checking an invalid input and a spot taken
      expect(pvp_game.player_2).to receive(:gets).and_return(invalid_input)
      expect(pvp_game.player_2).to receive(:gets).and_return("5")
      expect(pvp_game.player_2).to receive(:gets).and_return("4")
      expect{pvp_game.turn}.to output.to_stdout
      expect(pvp_game.board.cells).to eq([[" ", " ", " "], ["O", "X", " "], [" ", " ", " "]])

      pvp_game.board.reset!
    end
  end
  describe "#won?" do
    it "checks the current state of the board cell for a desired number of  player tokens in a row and returns the winning token" do
      default_game.board.count = 5
      default_game.board.cells = [[" ", " ", " "], ["X", "X", "X"], [" ", " ", " "]]
      default_game.last_move = [1, 0]
      expect(default_game.won?).to eq("X")
      default_game.board.cells = [[" ", " ", " "], ["X", "X", "X"], [" ", " ", " "]]
      default_game.last_move = [1, 1]
      expect(default_game.won?).to eq("X")
    end
    it "checks the winning combination based upon the win_length of the game" do
      default_game.win_length = 4
      default_game.board.cells = [[" ", " ", " ", " "], ["X", "X", "X", " "], [" ", " ", " ", " "]]
      default_game.last_move = [1, 1]
      expect(default_game.won?).to eq(false)
    end
    it "returns false for a non-winning combination" do
      default_game.last_move = [1, 0]
      expect(default_game.won?).to eq(false)
    end
    it "short circuits and returns false when the count is lower than one minus double the grid_size" do
      default_game.board.count = 1
      default_game.last_move = [1, 1]
      expect(default_game.won?).to eq(false)
    end

  end
end
