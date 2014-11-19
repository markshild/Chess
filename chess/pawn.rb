require "./dependencies.rb"

class Pawn < Piece


  def move_pool
    pool = []
    row = pos[0]
    col = pos[1]
    if (self.color == :black) && (row+1 <= 7)
      pool << [ row+1 , col ] if @board[ [ row+1,col ] ].nil? #space ahead is nil

      [ [row+1,col - 1] , [ row + 1, col + 1] ].each do |move| #only diagonal if can capture
        next if @board[move].nil?
        pool << move if @board[move].color == :white
      end
    elsif (row - 1 >= 0)
      pool << [ row-1, col ] if @board[ [ row-1,col ] ].nil?

      [ [ row - 1, col-1 ], [row-1, col+1 ] ].each do |move|
        next if @board[move].nil?
        pool << move if @board[move].color == :black
      end
    end
    if color == :white && row == 6

      if [@board[[row - 2, col]], @board[[row - 1, col]]].all? {|item| item.nil?}
        pool << [row - 2, col]
      end

    elsif color == :black && row == 1

      if [@board[[row + 2, col]], @board[[row + 1, col]]].all? {|item| item.nil?}
        pool << [row + 2, col]
      end
    end
    pool
  end


end
