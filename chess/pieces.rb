require "dependencies.rb" 

class Piece

  attr_reader :pos, :move_pool

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    move_pool
  end

  def move_pool

  end



end
