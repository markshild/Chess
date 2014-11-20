require "./dependencies.rb"

class Piece

  attr_reader :color, :board
  attr_accessor :pos, :moved

  def initialize(pos, color, board, game)
    @pos = pos
    @color = color
    @board = board
    @moved = false
    @game = game
  end

  def move_pool
    raise NotImplementedError
  end

  def special_moves
    []
  end

  def inspect
  end

end
