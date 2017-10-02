# TTT-BV

# How to Play the Game
Clone the repository
`git clone git@github.com:pajamaw/ttt-bv.git`
run `ruby bin/run_game`

# How the win algorithm works
- o(1) space
- worst case it's done in about O(a+b) time where a and b are the winlength and grid_size
 - The algorithm relies upon two main things
  1. the length of elements in a row required to win (win_length)
  1. the most recent move (last_move)
  - The basics of it is that it selects elements around it's position in the 4 major directions
  1. Up/Down
  1. Left/Right
  1. LeftDesc/RightAsc Diagonal
  1. LeftAsc/RightDesc Diagonal
  - The alg set's a counter to begin at a negative value of the win_length -1
    - this is in taking the assumption that the most recent element could be at the end of this line
  - The alg then iteratively checks the four directional conditions
    - if the last moves token is found - it adds one to the count
    - if that count reaches the win_length a short circuit occurs and the token is returned
    - if the last_moves token is not found - the count for the direction restarts to 0
  - Also noted that before each condition the x, y +/- the counter variable needs to be checked to ensure that there's no negative number
    - as a negative number would flip position to the other side of the array and allow for possibilities where a combination wins that isn't connected in the middle
  - if the winner is not found once the counter reaches the length of the board size it returns false


# Rough overview
- include examples of
  - **inheritance**
  - **polymorphism**
  - **dynamic win**
  - CLI
- outline program structure
  - classes
    - **game**
    - **board**
    - **player**
      - computer
        - unbeatable
          - on three at least
      - **human**
  - rules
    - **should i say that you must win according to game size?**
    - **or that it's always just three?
      - could do both i guess since the first is already implemented
  - cli
    - outline game
      - **PvP, PvC, CvC?**
        - **choose who's what token
      - Decide on size of board
      - **random first player**
      - **play game
        - winner is declared
      - **recursive to go through steps again**
    - **write test -> add code**
    - **add additional features**
      - **make it adjustable**
        - **change the rules?**
      - **random first**
      - make it a downloadable gem (next time)
