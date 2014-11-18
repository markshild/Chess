require "pieces.rb"

class SteppingPiecese < Piece
  def initialize(pos, color, board)
    delta = []
    super
  end

  def stepping_move
    new_positions = []

    delta.each do |(x,y)|
        new_positions << [@pos[0]+x, @pos[1]+y] #row,col pair
    end

    new_positions.select! {|(x,y)| x.between?(0,7) && y.between?(0,7) }
    new_positions.select! {|pos| @board[pos].nil? || @board[pos].color != self.color}

    new_positions
  end

end
