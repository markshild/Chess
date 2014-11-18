require "./dependencies.rb"


class Game

  def initialize(player1,player2)
    @board = Board.new
    @white = player1
    @black = player2
    @current_move = :white
  end

  def check?
    if @current_move == :white

      @board.black_pieces.each do |bp|
        check = bp.move_pool.include?(@board.white_king.pos)
        return true if check
      end

    else

      @board.white_pieces.each do |wp|
        check = wp.move_pool.include?(@board.black_king.pos)
        return true if check
      end

    end
    false
  end

  def move
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

    process(coords) #handles actual transposition and deletion
  end

  def process(coords)

  end

  def checkmate?

  end

  def check_move(pro_move)
    start, finish = pro_move

    #raise InvalidMoveErrpr
    if p({num} num.between?() )



    if (!@board[start].nil?) || (@board[start].color != turn)
      raise InvalidMoveError


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


  # def play
  #   until checkmate? || draw?
  #     @board.render
  #     get_move(@current_move)
  #     check?
  #
  #     move(#receives from get_move)
  #     switch_turn
  #
  #   end
  # end


end
