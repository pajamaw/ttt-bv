describe "Player" do
  let(:playerx){Player.new("X")}
  let(:playero){Player.new("O")}
  describe '#token' do
    it "is an attribute that represents the element that will be placed on the board" do
      expect(playerx).to respond_to(:token)
      expect(playerx).to respond_to(:token=)
      expect(playero).to respond_to(:token)
      expect(playero).to respond_to(:token=)
    end
  end
end
