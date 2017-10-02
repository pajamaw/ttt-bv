describe "Computer" do
  let(:human_playerx){Human.new("X")}
  let(:human_playero){Human.new("O")}
  describe '#token' do
    it "inherits the token method from it's parent class player" do
      expect(human_playerx).to respond_to(:token)
      expect(human_playerx).to respond_to(:token=)
      expect(human_playero).to respond_to(:token)
      expect(human_playero).to respond_to(:token=)
    end
  end
  describe '#move' do
    it "asks for user input then returns it" do
      expect(human_playerx).to respond_to(:move)
      expect(human_playerx).to receive(:gets).and_return("1")
      expect(human_playerx.move).to eq("1")
    end
  end
end
