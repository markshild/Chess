require "./dependencies.rb"

class Pawn < Piece


  def move_pool
    @move_pool = []
    if (self.color == :black) && (@pos[0]+1 <= 7)
      @move_pool << [ @pos[0]+1 , @pos[1] ] if @board[ [ @pos[0]+1,@pos[1] ] ].nil?
      [ [@pos[0]+1,@pos[1]-1] , [ @pos[0]+1,@pos[1]+1] ].each do |move|
        next if @board[move].nil?
        @move_pool << move if @board[move].color == :white
      end
    elsif (@pos[0]-1 >= 0)
      @move_pool << [ @pos[0]-1,@pos[1] ] if @board[ [ @pos[0]-1,@pos[1] ] ].nil?
      [ [ @pos[0]-1, @pos[1]-1 ], [@pos[0]-1, @pos[1]+1 ] ].each do |move|
        next if @board[move].nil?
        @move_pool << move if @board[move].color == :black
      end
    end

    @move_pool
  end


end
