class Board

  CHARACTERS {
    "nil" =>
  }

  attr_reader :black_pieces, :white_pieces, :black_king, :white_king

  def initialize
    start_board
  end

  def black_pieces
    @black_pieces = @grid.flatten.select {|piece| !piece.nil? && piece.color == :black}
  end

  def white_pieces
    @white_pieces = @grid.flatten.select {|piece| !piece.nil? && piece.color == :white}
  end


  def start_board
    @grid = Array.new(8) {Array.new(8){nil}}
    @grid[1].map!.with_index {|space,ind| Pawn.new([1,ind],:black,self)}
    @grid[6].map!.with_index {|space,ind| Pawn.new([6,ind],:white,self)}
    [[0,0],[0,7].each {|pos| @board[pos] = Rook.new(pos,:black,self)}
    [[7,0],[7,7].each {|pos| @board[pos] = Rook.new(pos,:white,self)}
    [[0,1],[0,6].each {|pos| @board[pos] = Knight.new(pos,:black,self)}
    [[7,1],[7,6].each {|pos| @board[pos] = Knight.new(pos,:white,self)}
    [[0,2],[0,5].each {|pos| @board[pos] = Bishop.new(pos,:black,self)}
    [[7,2],[7,5].each {|pos| @board[pos] = Bishop.new(pos,:white,self)}
    @board[0,3] = Queen.new(pos,:black,self)
    @board[7,3] = Queen.new(pos,:white,self)

    @black_king = King.new(pos,:black,self)
    @board[0,4] = @black_king

    @white_king = King.new(pos,:white,self)
    @board[7,4] = @white_king

  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def render

    @grid.map do |row| #set to variable
      row.map do |space|
        case space.class
        when Pawn
          CHARACTERS["Pawn"].colorize(COLORS[space.color])
        when Rook
          CHARACTERS["Rook"].colorize(COLORS[space.color])
        when Knight
          CHARACTERS["Knight"].colorize(COLORS[space.color])
        when Bishop
          CHARACTERS["Bishop"].colorize(COLORS[space.color])
        when Queen
          CHARACTERS["Queen"].colorize(COLORS[space.color])
        when King
          CHARACTERS["King"].colorize(COLORS[space.color])
        else
          CHARACTERS["nil"].colorize(:red)
        end

      end
    end

  end

end
