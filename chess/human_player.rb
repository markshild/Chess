class HumanPlayer

CONVERSION = {

  'a' => 0 ,
  'b' => 1 ,
  'c' => 2 ,
  'd' => 3 ,
  'e' => 4 ,
  'f' => 5 ,
  'g' => 6 ,
  'h' => 7 ,
  '8' => 0 ,
  '7' => 1 ,
  '6' => 2 ,
  '5' => 3 ,
  '4' => 4 ,
  '3' => 5 ,
  '2' => 6 ,
  '1' => 7

  }

  def initialize(name)
    @name = name
  end

  def get_move
    gets.comp
  end

  def translate(coords)
    coords.map! do |coord|
      coord.split('').map do |n|
        CONVERSION[n]
      end
    end

  end


end
