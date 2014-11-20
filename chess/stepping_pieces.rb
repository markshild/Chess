require "./dependencies.rb"

class SteppingPiece < Piece
  def initialize(pos, color, board, game)
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
  def initialize(pos,color,board, game)
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


  def spec_helper?(side)

    if side.all? { |delt| @board[delt].nil? }
      if side.none? do |delt|
          dup = @board.dup_board
          process([self.pos,delt], dup)
          @game.check?(dup)
        end
      end
    end
  end



  def special_moves
    poss = []
    left = [[pos[0], pos[1] - 1],[pos[0], pos[1] - 2], [pos[0], pos[1] - 3]]
    right = [[pos[0], pos[0] + 1],[pos[0], pos[1] + 2]]

    if !moved && !@game.check?
      if spec_helper?(left)
        if @board[[pos[0], pos[1] - 4]].is_a?(Rook) && !@board[[pos[0], pos[1] - 4]].moved
          poss << left[1]
        end
      end
      if spec_helper?(right)
        if @board[[pos[0], pos[1] + 3]].is_a?(Rook) && !@board[[pos[0], pos[1] + 3]].moved
          poss << right[1]
        end
      end
    end
    poss
  end

  def perform_special_move(fin)

    if fin[1] = 2
      start = [fin[0],0]
      finish = [fin[0],3]
    else
      start = [fin[0],7]
      finish = [fin[0],5]
    end


    @board[finish] = @board[start] #move piece to new position


    @board[finish].pos = finish #sets new pos data for moved piece

    @board[finish].moved = true #helper for castling

    @board[start] = nil

  end


end




class Knight < SteppingPiece
  def initialize(pos,color,board, game)
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
