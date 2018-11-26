Name: Austin Chen           ID: 46797586

## Proposed Project

For my project, I plan on creating a two-player online Sudoku game. Traditionally, I personally play Sudoku alongside friends, starting a new board at the same time and racing to see who might finish first. Though the competitive spirit is nice, I think a welcome addition would be the option to collaborate on the same board together. The idea thus remains simple--two players will be able to inteface with the Phoenix web application to play one shared sudoku board at the same time. The two players can work together to solve the board quicker, or it could pan out the opposite if their communication isn't up to snuff.


## Outline Structure
For now, I plan on using Phoenix for my web framework. As for the supervision structure, the two players will be maintaining a shared board. A top level supervisor will be supervising the two users that maintain the shared board state, to properly process updates to each user's viewport live.
