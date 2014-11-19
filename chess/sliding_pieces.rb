require "./dependencies.rb"

class SlidingPiece < Piece

  protected

  def horizontal_move
    move_array = []
    col = pos[1]
    row = pos[0]

    until col > 7 #looks to the right
      if @board[[row,col]].nil? #instead of this, probably generate an array of ALL positions (+/- 8, and just "next" if out of bounds)
        move_array << [row,col]
      else #space not empty
        piece = @board[[row,col]] #This is the piece occupying the space

        move_array << [row,col] if (piece.color != self.color) #An enemy piece
        break if self != piece
      end
      col += 1
    end

    col = pos[1]
    until col < 0 # looks to the left
      if @board[[row,col]].nil?
        move_array << [row,col]
      else
        piece = @board[[row,col]] #This is the piece occupying the space
        move_array << [row,col] if (piece.color != self.color) #An enemy piece
        break if self != piece
      end
      col -= 1
    end

    move_array
  end

  def vertical_move
    move_array = []
    row = pos[0]
    col = pos[1]
    until row > 7 #looks up
      if @board[[row,col]].nil?
        move_array << [row,col]
      else #take over if space is occupied
          piece = @board[[row,col]] #This is the piece occupying the space
          move_array << [row,col] if (piece.color != self.color) #An enemy piece
          break if self != piece
      end
      row += 1
    end

    row = pos[0]
    until row < 0 # looks down
      if @board[[row,col]].nil?
        move_array << [row,col]
      else #take over if space is occupied
        piece = @board[[row,col]] #This is the piece occupying the space
        move_array << [row,col] if (piece.color != self.color) #An enemy piece
        break if self != piece
      end
      row -= 1
    end
    move_array
  end

  def uphill_move
    move_array = []
    row, col = pos
    until row < 0 || col > 7
      if @board[[row,col]].nil?
        move_array << [row,col]
      else #take over if space is occupied
        piece = @board[[row,col]] #This is the piece occupying the space
        move_array << [row,col] if (piece.color != self.color) #An enemy piece
        break if self != piece
      end
      row -= 1
      col += 1
    end

    row, col = pos
    until row > 7 || col < 0

      if @board[[row,col]].nil?
        move_array << [row,col]
      else
        piece = @board[[row,col]] #This is the piece occupying the space
        move_array << [row,col] if (piece.color != self.color) #An enemy piece
        break if self != piece
      end
      row += 1
      col -= 1
    end
    move_array
  end

  def downhill_move
    move_array = []
    row, col = pos
    until row > 7 || col > 7
      if @board[[row,col]].nil?
        move_array << [row,col]
      else
        piece = @board[[row,col]] #This is the piece occupying the space
        move_array << [row,col] if (piece.color != self.color) #An enemy piece
        break if self != piece
      end
      row += 1
      col += 1
    end

      row, col = pos
    until row < 0 || col < 0
        if @board[[row,col]].nil?
          move_array << [row,col]
        else #take over if space is occupied
            piece = @board[[row,col]] #This is the piece occupying the space
            move_array << [row,col] if (piece.color != self.color) #An enemy piece
            break if self != piece
        end
        row -= 1
        col -= 1
      end
      move_array
  end

end

class Queen < SlidingPiece
  def move_pool
    uphill_move.concat(downhill_move) + horizontal_move.concat(vertical_move)
  end
end

class Bishop < SlidingPiece
  def move_pool
    uphill_move.concat(downhill_move)
  end
end

class Rook < SlidingPiece
  def move_pool
    horizontal_move.concat(vertical_move)
  end
end
