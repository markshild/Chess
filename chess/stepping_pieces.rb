require "pieces.rb"

class SteppingPiece < Piece
  def initialize(pos, color, board)
    @delta = []
    super
  end

  def move_pool
    @move_pool = []

    @delta.each do |(x,y)|
        new_positions << [@pos[0]+x, @pos[1]+y] #row,col pair
    end

    new_positions.select! {|(x,y)| x.between?(0,7) && y.between?(0,7) }
    new_positions.select! {|pos| @board[pos].nil? || @board[pos].color != self.color}

    @move_pool
  end

end

class King < SteppingPiece
  def initialize(pos,color,board)
    super
    @delta = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
    ]
  end

end

class Knight < SteppingPiece
  def initialize(pos,color,board)
    super
    @delta = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
    ]
  end

end
