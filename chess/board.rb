require "./dependencies.rb"

class Board

  CHARACTERS = {
    "nil" => "■"  ,
    "white pawn" => "♙" ,
    "black pawn" => "♟" ,
    "white rook" => "♖" ,
    "black rook" => "♜" ,
    "white bishop" => "♗" ,
    "black bishop" => "♝" ,
    "white knight" => "♘" ,
    "black knight" => "♞" ,
    "white queen" => "♕" ,
    "black queen" => "♛" ,
    "white king" => "♔" ,
    "black king" => "♚"
  }

  attr_reader :black_pieces, :white_pieces, :grid
  attr_accessor :black_king, :white_king

  def initialize
    @grid = Array.new(8) {Array.new(8){nil}}
  end

  def black_pieces
    @black_pieces = @grid.flatten.select {|piece| !piece.nil? && piece.color == :black}
  end

  def white_pieces
    @white_pieces = @grid.flatten.select {|piece| !piece.nil? && piece.color == :white}
  end


  def start_board

    @grid[1].map!.with_index {|space,ind| Pawn.new([1,ind],:black,self)}
    @grid[6].map!.with_index {|space,ind| Pawn.new([6,ind],:white,self)}
    [[0,0],[0,7]].each {|pos| self[pos] = Rook.new(pos,:black,self)}
    [[7,0],[7,7]].each {|pos| self[pos] = Rook.new(pos,:white,self)}
    [[0,1],[0,6]].each {|pos| self[pos] = Knight.new(pos,:black,self)}
    [[7,1],[7,6]].each {|pos| self[pos] = Knight.new(pos,:white,self)}
    [[0,2],[0,5]].each {|pos| self[pos] = Bishop.new(pos,:black,self)}
    [[7,2],[7,5]].each {|pos| self[pos] = Bishop.new(pos,:white,self)}
    self[[0,3]] = Queen.new([0,3],:black,self)
    self[[7,3]] = Queen.new([7,3],:white,self)

    @black_king = King.new([0,4],:black,self)
    self[[0,4]] = @black_king

    @white_king = King.new([7,4],:white,self)
    self[[7,4]] = @white_king

  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def render

    rendered_board = @grid.map do |row| #set to variable
      row.map do |space|
        if space.nil?
          CHARACTERS["nil"]
        else
          CHARACTERS["#{space.color.to_s} #{space.class.to_s.downcase}"]
        end
      end
    end

    rendered_board
  end

end
