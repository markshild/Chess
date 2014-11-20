require "./dependencies.rb"

class SteppingPiece < Piece
  def initialize(pos, color, board)
    @delta = []
    super
  end

  def move_pool
    pool = []

    @delta.each do |(x,y)|
        pool << [pos[0]+x, pos[1]+y] #row,col pair
    end

    pool.select! {|(x,y)| x.between?(0,7) && y.between?(0,7) }
    pool.select! {|pos| @board[pos].nil? || @board[pos].color != self.color}

    pool
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


  def move_pool
    super + special_moves
  end


  def special_moves
    poss = []
    if if !moved && !@board.check?
      left = [[pos[0], pos[1] - 1],[pos[0], pos[1] - 2]]
      right = [[pos[0]], pos[0] + 1],[pos[0], pos[1] + 2]]
      if left.all? { |delt| @board[delt].nil? }
        if left.none? do |delt|
            dup = @board.dup_board
            process([self.pos,delt], dup)
            check?(dup)
          end
          if color == :white
          poss << left[1]
        end
      elsif right.all? { |delt| @board[delt].nil? }
        if right.none? do |delt|
            dup = @board.dup_board
            process([self.pos,delt], dup)
            check?(dup)
          end
          poss << right[1]
        end
      end
      poss
    end


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
