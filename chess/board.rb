class Board

  def initialize
    @current_move = :white
    start_board
  end


  def start_board
    @grid = Array.new(8) {Array.new(8){nil}}  
  end

  def [](pos)
    x, y = pos
    @board[x][y]
end
