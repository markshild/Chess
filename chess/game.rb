class Game

  def initialize(player1,player2)
    @board = Board.new
    @white = player1
    @black = player2
    @current_move = :white
  end

  def check?
    if @current_move == :white

      @board.black_pieces.each do |bp|
        check = bp.move_pool.include?(@board.white_king.pos)
        return true if check
      end

    else

      @board.white_pieces.each do |wp|
        check = wp.move_pool.include?(@board.black_king.pos)
        return true if check
      end
      
    end
    false
  end

  def move
    @current_move
  end

  def checkmate?

  end

  def get_move

  end

  def winner

  end





end
