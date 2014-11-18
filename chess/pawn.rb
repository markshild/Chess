require "pieces.rb"

class Pawn < Piece


  def pawn_moves
    moves = []
    if self.color = :black && (@pos[0]+1 <= 7)
      moves << [@pos[0]+1,@pos[1]] if @Board[@pos[0]+1,@pos[1]].nil?
      [[@pos[0]+1,@pos[1]-1], [@pos[0]+1,@pos[1]+1]].each do |move|
        next if @board[move].nil?
        moves << move if @board[move].color == :white
      end
    elsif (@pos[0]-1 >= 0)
      moves << [@pos[0]-1,@pos[1]] if @Board[@pos[0]-1,@pos[1]].nil?
      [[@pos[0]-1,@pos[1]-1], [@pos[0]-1,@pos[1]+1]].each do |move|
        next if @board[move].nil?
        moves << move if @board[move].color == :black
      end
    end

    moves
  end


end
