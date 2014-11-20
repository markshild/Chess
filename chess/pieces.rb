require "./dependencies.rb"

class Piece

  attr_reader :color, :board
  attr_accessor :pos :moved

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @moved = false
  end

  def move_pool
    raise NotImplementedError
  end



end
