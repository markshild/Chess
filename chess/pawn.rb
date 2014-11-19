require "./dependencies.rb"

class Pawn < Piece


  def move_pool
    pool = []
    if (self.color == :black) && (pos[0]+1 <= 7)
      pool << [ pos[0]+1 , pos[1] ] if @board[ [ pos[0]+1,pos[1] ] ].nil?

      [ [pos[0]+1,pos[1] - 1] , [ pos[0] + 1, pos[1] + 1] ].each do |move|
        next if @board[move].nil?
        pool << move if @board[move].color == :white
      end
    elsif (pos[0] - 1 >= 0)
      pool << [ pos[0]-1, pos[1] ] if @board[ [ pos[0]-1,pos[1] ] ].nil?

      [ [ pos[0] - 1, pos[1]-1 ], [pos[0]-1, pos[1]+1 ] ].each do |move|
        next if @board[move].nil?
        pool << move if @board[move].color == :black
      end
    end
    if color == :white && pos[0] == 6

      if [@board[[pos[0] - 2, pos[1]]], @board[[pos[0] - 1, pos[1]]]].all? {|item| item.nil?}
        pool << [pos[0] - 2, pos[1]]
      end

    elsif color == :black && pos[0] == 1

      if [@board[[pos[0] + 2, pos[1]]], @board[[pos[0] + 1, pos[1]]]].all? {|item| item.nil?}
        pool << [pos[0] + 2, pos[1]]
      end
    end
    pool
  end


end
