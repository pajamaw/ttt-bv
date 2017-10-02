describe "Computer" do
  let(:comp_playerx){Computer.new("X")}
  let(:comp_playero){Computer.new("O")}
  let(:game){Game.new}
  let(:game5){Game.new(Board.new(5))}

  describe '#token' do
    it "inherits the token method from it's parent class player" do
      expect(comp_playerx).to respond_to(:token)
      expect(comp_playerx).to respond_to(:token=)
      expect(comp_playero).to respond_to(:token)
      expect(comp_playero).to respond_to(:token=)
    end
  end
  describe '#move' do
    it "randomly selects an integer between 1 and the size of the grid squared" do
      expect(comp_playerx).to respond_to(:move)
      game = Game.new
      comp_playerx.game = game
      expect(comp_playerx.move).to be_an_instance_of(Array)
    end
  end
  describe '#scan_previous_position' do
    it "checks the elements around the given coordinates and returns a position if two are found in a row" do
      expect(comp_playerx).to respond_to(:move)
      game = Game.new
      comp_playerx.game = game
      game.board.cells = [["O", " ", " "], [" ", "X", "X"], [" ", " ", " "]]
      expect(comp_playerx.scan_previous_position(1, 1)).to eq([1, 0])
    end
    it "checks the elements around the given coordinates and returns a position if a win_length amount are found in a row" do
      expect(comp_playerx).to respond_to(:scan_previous_position)
      game = Game.new
      comp_playerx.game = game
      game.board.cells = [["O", " ", " "], [" ", " ", " "], [" ", "X", "X"]]
      expect(comp_playerx.scan_previous_position(2, 1)).to eq([2, 0])
    end
    it "checks the elements around the given coordinates and returns a position if win_length are found in a row" do
      expect(comp_playerx).to respond_to(:scan_previous_position)
      game = Game.new
      comp_playerx.game = game
      game.board.cells = [["X", "X", " "], [" ", " ", " "], [" ", "O", "O"]]
      expect(comp_playerx.scan_previous_position(2, 1)).to eq([2, 0])
    end
    it "checks the elements around the given coordinates and returns a position if win_length amount are found in a row even with variable sizes of combo and grid " do
      expect(comp_playerx).to respond_to(:scan_previous_position)
      game = Game.new
      comp_playerx.game = game
      game.board.cells = [["X", " ", " ", " "], [" ", " ", " ", " "], [" ", "O", "O", " "], [" ", " ", " ", " "]]
      expect(comp_playerx.scan_previous_position(2, 1)).to eq([2, 0])
    end
  end
end
