class Human < Player
  def move
    # passing board here as even though it's unnecessary
    # I shouldn't need to be sure of if the player is human or
    # comp so no matter what i should pass board
    gets.chomp
  end
end
