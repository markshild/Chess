require "./dependencies.rb"


class Game

  def initialize(player1,player2)
    @board = Board.new
    @white = player1
    @black = player2
    @current_move = :white
    @board.start_board
  end

  def check?(board = @board, color = @current_move) #Checks if current_move player's king is in check, maybe should instead take a board parameter
    if color == :white

      board.black_pieces.each do |bp|
        check = bp.move_pool.include?(@board.white_king.pos)
        return true if check
      end

    else

      board.white_pieces.each do |wp|
        check = wp.move_pool.include?(@board.black_king.pos)
        return true if check
      end

    end
    false
  end

  def move
    player = (@current_move == :white ? @white : @black)
    begin
      coords = player.get_move #coords = [[0,1],[1,1]]
      check_move(coords)
    rescue InvalidMoveError
      puts "Invalid Input"
      retry
    rescue CheckError
      puts "That move will put you in check!"
      retry
    end

    process(coords) #handles actual transposition and deletion. Only run if ALL checks pass
  end

  def process(coords,board = @board)
    start, finish = coords

    board[finish] = receiving_space #copies instance of piece to finish space
    board[start] = starting_space
    receiving_space = starting_space

    receiving_space.pos = finish #sets new pos data for moved piece

    starting_space = nil #deletes instance of space
  end

  def checkmate?
    if @current_move = :white
      @board.white_pieces.each do |piece|
        piece.move_pool.each do |move|
          dup = dup_board
          new_move = [piece.pos,move]
          process(new_move, dup)
          return false unless check?(dup)
        end
      end
    else
      @board.black_pieces.each do |piece|
        piece.move_pool.each do |move|
          dup = dup_board
          new_move = [piece.pos,move]
          process(new_move, dup)
          return false unless check?(dup)
        end
      end
    end
    true
  end

  def check_move(pro_move)
    start, finish = pro_move

    #raise InvalidMoveErrpr
    raise InvalidMoveError if pro_move.flatten.any? ({num} num < 0 || 7 < num ) #all moves in board?

    if (!@board[start].nil?) || (@board[start].color != @current_turn)
      raise InvalidMoveError #space is nil or piece is not current players
    end

    possible_moves = @board[start].move_pool

    raise InvalidMoveError if !possible_moves.include?(finish) #finish space is in possible moveset

    dup = dup_board
    process(pro_move, dup)
    raise CheckError if check?(dup)
  end

  def winner

  end

  def draw?
    true if (@board.white_pieces + @board.black_pieces).count == 2
  end

  def display
    display_array = @board.render.map.with_index do |row, rowidx|
      row.unshift(8 - rowidx).join(" ")
    end

    display_array.unshift("  A B C D E F G H")

    puts display_array
  end

  def switch_turn
    @current_turn == :white ? @current_turn = :black : @current_turn = :white
  end

  def play
    until draw?
      @board.render

      if check?
        if checkmate?
          puts "{@current_move.to_s.capitalize} Loses!"
          break
        else
          puts "#{@current_move.to_s.capitalize} is in Check!"
        end
      end

      move
      switch_turn
    end
  end


  def dup_board
    new_board = Board.new
    @board.grid.each_index do |row,rind|
      row.each_index do |col, cind|
        next if @board[[rind,cind]].nil?
        piece = @board[[rind,cind]]
        new_board[rind][cind] = piece.class.new([rind,cind], piece.color, new_board)
      end
    end
    new_board
  end


  end

end
