# TTT-BV

# How to Play the Game
Clone the repository
`git clone git@github.com:pajamaw/ttt-bv.git`
run `ruby bin/run_game`


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
