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
      coords = player.get_move
    rescue InvalidMoveError
      puts "Invalid Input"
      retry
    rescue CheckError
      puts "That move will put you in check!"
      retry
    end
    process(coords)
  end

  def process(coords)
    coords.map! do |coord|
      coord.split('').map do |n|
        CONVERSION[n]
      end
    end

    from, to = coords


  end

  def checkmate?

  end

  def get_move

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
