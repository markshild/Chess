class Board

  def initialize
    @current_move = :white
    start_board
  end


  def start_board
    @grid = Array.new(8) {Array.new(8){nil}}
    @grid[1].map!.with_index {|space,ind| Pawn.new([1,ind],:black,self)}
    @grid[6].map!.with_index {|space,ind| Pawn.new([6,ind],:white,self)}
    [[0,0],[0,7].each {|pos| @board[pos] = Rook.new(pos,:black,self)}
    [[7,0],[7,7].each {|pos| @board[pos] = Rook.new(pos,:white,self)}
    [[0,1],[0,6].each {|pos| @board[pos] = Knight.new(pos,:black,self)}
    [[7,1],[7,6].each {|pos| @board[pos] = Knight.new(pos,:white,self)}
    [[0,2],[0,5].each {|pos| @board[pos] = Bishop.new(pos,:black,self)}
    [[7,2],[7,5].each {|pos| @board[pos] = Bishop.new(pos,:white,self)}
    @board[0,3] = Queen.new(pos,:black,self)
    @board[7,3] = Queen.new(pos,:white,self)
    @board[0,4] = King.new(pos,:black,self)
    @board[7,4] = King.new(pos,:white,self)
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

end
