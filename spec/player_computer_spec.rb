describe "Computer" do
  let(:comp_playerx){Computer.new("X")}
  let(:comp_playero){Computer.new("O")}
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
      board = Board.new
      expect(comp_playerx).to respond_to(:move)
      expect(comp_playerx.move(board, [])).to be_an_instance_of(Array)
      expect(comp_playerx.move(board, [])).to be_an_instance_of(Array)
    end
  end
end
