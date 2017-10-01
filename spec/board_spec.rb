
describe "Board" do
  let(:board){Board.new}
  let(:board5){Board.new(5)}
  describe '#grid_size' do
    it "is an attribute that represents the dimension of the array with a default value of 3" do
      expect(board).to respond_to(:grid_size)
      expect(board.grid_size).to eq(3)
      expect(board5.grid_size).to eq(5)
    end
  end
  describe '#cells' do
    it "is an attribute which is a nested array of player values which represent the playing board with the dimensions of #grid_size" do
      expect(board).to respond_to(:cells)
      expect(board.cells).to eq ([[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]])
      expect(board5.cells).to eq([[" ", " ", " ", " ", " "], [" ", " ", " ", " ", " "], [" ", " ", " ", " ", " "], [" ", " ", " ", " ", " "], [" ", " ", " ", " ", " "]])
    end
    it "is has a setter" do
      expect(board).to respond_to(:cells=)

      board.cells = []
      expect(board.cells).to eq([])
    end
  end
  describe '#count' do
    it "is an attribute that persists the number of tokens on a board which initializes with a value of 0" do
      expect(board).to respond_to(:count)
      expect(board.count).to eq(0)
    end
    it "is has a setter" do
      expect(board).to respond_to(:count=)

      board.count += 1
      expect(board.count).to eq(1)
    end
  end
  describe '#update' do
    it "adds a player token to the cells nested array" do
      expect(board).to respond_to(:update)
      expect(board.update(1,1,"X")).to eq([[" ", " ", " "], [" ", "X", " "], [" ", " ", " "]])
    end
    it "increases count each time the board is updated" do
      expect(board.count).to eq(0)
      board.update(1,1,"X")
      expect(board.count).to eq(1)
    end
  end
  describe '#full_board?' do
    it "returns false if the count doesn't equal the gridsize squared" do
      expect(board).to respond_to(:full_board?)
      board.update(0,0, "X")
      expect(board.full_board?).to eq(false)
    end
    it "returns true if the count equals the gridsize squared" do
      expect(board).to respond_to(:full_board?)
      board.count = 9
      expect(board.full_board?).to eq(true)
    end
  end
  describe '#display_board' do
    it "prints the a visual board representation based upon the array" do
      visual_board = "  1 |  2 |  3 \n ---- ---- ----  \n  4 |  5 |  6 \n ---- ---- ----  \n  7 |  8 |  9 \n"
      expect(board).to respond_to(:display_board)
      expect{board.display_board}.to output.to_stdout
      expect{board.display_board}.to output(visual_board).to_stdout
    end
    it "prints updated visual board representation based upon the array" do
      visual_board = "  1 |  X |  3 \n ---- ---- ----  \n  4 |  5 |  6 \n ---- ---- ----  \n  7 |  8 |  9 \n"
      board.update(0, 1, "X")
      expect{board.display_board}.to output.to_stdout
      expect{board.display_board}.to output(visual_board).to_stdout
    end
    it "prints out different sized boards according to the grid_size" do
      visual_board = "  X |  2 |  3 |  4 |  5 \n ---- ---- ---- ---- ----  \n  6 |  7 |  8 |  9 | 10 \n ---- ---- ---- ---- ----  \n 11 | 12 | 13 | 14 | 15 \n ---- ---- ---- ---- ----  \n 16 | 17 | 18 | 19 | 20 \n ---- ---- ---- ---- ----  \n 21 | 22 | 23 | 24 | 25 \n"
      board5.update(0, 0, "X")
      expect{board5.display_board}.to output.to_stdout
      expect{board5.display_board}.to output(visual_board).to_stdout
    end
  end

end
