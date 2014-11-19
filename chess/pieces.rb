require "./dependencies.rb"

class Piece

  attr_reader :color, :board
  attr_accessor :pos

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def move_pool
    raise NotImplementedError
  end



end
