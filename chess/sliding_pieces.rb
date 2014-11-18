require "pieces.rb"

class SlidingPiece < Pieece
  
  protected

  def horizontal_move
    move_array = []
    current_col = @pos[1]
    until current_col > 7 #looks to the right
      if @board[@pos[0],current_col].nil?
        move_array << [@pos[0],current_col]
      else
        piece = @board[pos[0], current_col]
        if piece.color == self.color
          break
        else
          move_array << [@pos[0],current_col]
          break
        end
      end
      current_col += 1
    end
    current_col = @pos[1]
    until current_col < 0 # looks to the left
      if @board[@pos[0],current_col].nil?
        move_array << [@pos[0],current_col]
      else
        piece = @board[pos[0], current_col]
        if piece.color == self.color
          break
        else
          move_array << [@pos[0],current_col]
          break
        end
      end
      current_col -= 1
    end
    move_array
  end

  def vertical_move
    move_array = []
    current_row = @pos[0]
    until current_row > 7 #looks up
      if @board[current_row,@pos[1]].nil?
        move_array << [current_row,@pos[1]]
      else
        piece = @board[current_row,@pos[1]]
        if piece.color == self.color
          break
        else
          move_array << [current_row,@pos[1]]
          break
        end
      end
      current_col += 1
    end
    current_row = @pos[0]
    until current_row < 0 # looks down
      if @board[current_row,@pos[1]].nil?
        move_array << [current_row,@pos[1]]
      else
        piece = @board[current_row,@pos[1]]
        if piece.color == self.color
          break
        else
          move_array << [current_row,@pos[1]]
          break
        end
      end
      current_col -= 1
    end
    move_array
  end

  def uphill_move
    move_array = []
    row, col = @pos
    until row < 0 || col > 7
      if @board[row,col].nil?
        move_array << [row,col]
      else
        piece = @board[row,col]
        if piece.color == self.color
          break
        else
          move_array << [row,col]
          break
        end
      end
      row -= 1
      col += 1
    end
    row, col = @pos
    until row > 7 || col < 0
      if @board[row,col].nil?
        move_array << [row,col]
      else
        piece = @board[row,col]
        if piece.color == self.color
          break
        else
          move_array << [row,col]
          break
        end
      end
      row += 1
      col -= 1
    end
    move_array
  end

  def downhill_move
    move_array = []
    row, col = @pos
    until row > 7 || col > 7
      if @board[row,col].nil?
        move_array << [row,col]
      else
        piece = @board[row,col]
        if piece.color == self.color
          break
        else
          move_array << [row,col]
          break
        end
      end
      row += 1
      col += 1
    end

      row, col = @pos
    until row < 0 || col < 0
        if @board[row,col].nil?
          move_array << [row,col]
        else
          piece = @board[row,col]
          if piece.color == self.color
            break
          else
            move_array << [row,col]
            break
          end
        end
        row -= 1
        col -= 1
      end
      move_array
  end

end