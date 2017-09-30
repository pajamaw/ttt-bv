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
      grid_size = 3
      expect(comp_playerx).to respond_to(:move)
      expect(comp_playerx.move(grid_size)).to be > 0
      expect(comp_playerx.move(grid_size)).to be < 10
    end
  end
end
