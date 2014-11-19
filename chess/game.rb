require "./dependencies.rb"

  class CheckError < StandardError
  end

  class InvalidMoveError < StandardError
  end


class Game

  attr_reader :board

  def initialize(player1,player2)
    @board = Board.new
    @white = player1
    @black = player2
    @current_move = :white
    @board.start_board
    play
  end

  def play
    until draw?
      display

      if check?
        if checkmate?
          puts "#{@current_move.to_s.capitalize} Loses!"
          break
        else
          puts "#{@current_move.to_s.capitalize} is in Check!"
        end
      end

      move
      promote if last_pawns?
      switch_turn
    end
  end

  def draw?
    true if (@board.white_pieces + @board.black_pieces).count == 2
  end

  def display #protect
    display_array = @board.render.map.with_index do |row, rowidx|
      row.unshift(8 - rowidx).join(" ")
    end

    display_array.unshift("  A B C D E F G H")

    puts display_array
  end

  def switch_turn
    @current_move == :white ? @current_move = :black : @current_move = :white
  end

  def move
    player = (@current_move == :white ? @white : @black)
    begin
      coords = player.get_move #coords = [[0,1],[1,1]]
      check_move(coords)
    rescue InvalidMoveError => e
      puts e.message
      retry
    rescue CheckError
      puts "That move will put you in check!"
      retry
    end

    process(coords) #handles actual transposition and deletion. Only run if ALL checks pass
  end

  def check_move(pro_move)
    start, finish = pro_move

    raise InvalidMoveError.new "Out of Range" if pro_move.flatten.any? {|num| (num < 0) || (7 < num )} #all moves in board?

    if @board[start].nil?
      raise InvalidMoveError.new "There is nothing there to move"
    elsif (@board[start].color != @current_move)
       raise InvalidMoveError.new "That is not your piece" #space is nil or piece is not current players
    end

    possible_moves = @board[start].move_pool

    raise InvalidMoveError.new "That piece can't move there" if !possible_moves.include?(finish) #finish space is in possible moveset

    dup = dup_board
    process(pro_move, dup)
    raise CheckError if check?(dup)
  end

  def process(coords,board = @board)
    start, finish = coords

    board[finish] = board[start] #move piece to new position


    board[finish].pos = finish #sets new pos data for moved piece

    board[start] = nil #deletes instance of space
  end

  def check?(current_board = @board, color = @current_move) #Checks if current_move player's king is in check, maybe should instead take a board parameter
    if color == :white
    
      current_board.black_pieces.each do |bp|

        check = bp.move_pool.include?(current_board.white_king.pos)
        return true if check
      end

    else
      current_board.white_pieces.each do |wp|
        check = wp.move_pool.include?(current_board.black_king.pos)
        return true if check
      end

    end
    false
  end

  def checkmate?
    if @current_move == :white


      @board.white_pieces.each do |piece|
        piece.move_pool.each do |move|
          dup = dup_board
          new_move = [piece.pos, move]
          process(new_move, dup)
          return false if !check?(dup)
        end
      end

    else

      @board.black_pieces.each do |piece|
        piece.move_pool.each do |move|
          dup = dup_board
          new_move = [piece.pos,move]
          process(new_move, dup)
          return false if !check?(dup)
        end
      end

    end

    true
  end

  def dup_board
    new_board = Board.new
    @board.grid.each_with_index do |row, rind|
      row.each_index do |cind|

        next if @board[[rind,cind]].nil?
        piece = @board[[rind,cind]]
        new_board[[rind, cind]] = piece.class.new([rind,cind], piece.color, new_board)

        if piece.class == King
          if piece.color == :white
            new_board.white_king = new_board[[rind, cind]]

          else
            new_board.black_king = new_board[[rind, cind]]
          end
        end

      end
    end
    new_board
  end

  #special cases
  def last_pawns?
    last_rows = @board.grid[0].flatten + @board.grid[7].flatten
    last_rows.any? {|space| space.class == Pawn}
  end

  def promote
    player = (@current_move == :white ? @white : @black)
    promote_piece = player.promote_prompt

    last_rows = @board.grid[0].flatten + @board.grid[7].flatten
    last_rows.select! {|space| space.class == Pawn}
    pawn = last_rows[0]

    case promote_piece
    when "q"
      @board[pawn.pos] = Queen.new(pawn.pos,pawn.color,@board)
    when "k"
      @board[pawn.pos] = Knight.new(pawn.pos,pawn.color,@board)
    when "b"
      @board[pawn.pos] = Bishop.new(pawn.pos,pawn.color,@board)
    when "r"
      @board[pawn.pos] = Rook.new(pawn.pos,pawn.color,@board)
    else
    end
  end
end
