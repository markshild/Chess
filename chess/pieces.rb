require "./dependencies.rb"

class Piece

  attr_reader :move_pool, :color
  attr_accessor :pos

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def move_pool

  end



end
