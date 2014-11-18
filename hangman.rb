class InputError < StandardError
end


class Game
  MAX_GUESSES = 10

  attr_reader :guessed

  def initialize(p1,p2)
    @checker = p1
    @guesser = p2
  end

  def play
    length = @checker.pick_secret_word
    partial = Array.new(length) {'_'}
    @guessed = []
    turn = 0
    won = false

    @guesser.receive_secret_length(length)

    until turn >= MAX_GUESSES
        puts partial.join

        begin
          guess = @guesser.guess_letter(guessed)
        rescue InputError
          puts "Invalid guess"
          retry
        rescue GuessError
          puts "Already guessed"
          retry
        end

        guessed << guess
        response = @checker.check_guess(guess)
        response.each { |i| partial[i] = guess }

        if partial.none?{ |letter| letter == '_' }
          won = true
          break
        end

        @guesser.handle_guess_response(response)

        turn += 1
    end

    if won
      puts "Got it!"
    else
      puts @checker.get_word
    end

  end
end

class HumanPlayer
  #Checker Methods

  def pick_secret_word
    puts "How long is your word?"
    Integer(gets.chomp)
  end

  def check_guess(guess)
      puts guess
      puts "Give the positions of this letter (if any)"

      #assume input "1,2,3"
      gets.chomp.split(",").map(&:to_i)
  end

  #Guesser Methods

  def guess_letter(guessed_letters)
    print guessed_letters
    puts "Guess a letter"
    guess_letter = gets.chomp

    raise InputError unless guess_letter.match(/\A[a-z]\z/)

  end

  def handle_guess_response(response)
  end

  def receive_secret_length(length)
  end

  def get_word
    puts "Huh. What was your word?"
    gets.chomp
  end

end

class ComputerPlayer
  #Checker Methods
  attr_accessor :guessing_dictionary, :comp_guess

  def initialize
    @guessing_dictionary = []
  end

  def pick_secret_word
      @secret_word = File.readlines("Dictionary.txt").sample.chomp
      @secret_word.length
  end

  #Guesser Methods
  def check_guess(guess)
    response = []

    @secret_word.split('').each_with_index do |letter,i|
      response << i if letter == guess
    end

    response
  end

  def handle_guess_response(response)

    if response.empty?
      @guessing_dictionary.reject! do |word|
        word.split('').include?(@comp_guess)
      end
    else
      @guessing_dictionary.select! do |word| #dictionary
        response.all? {|i| word.split('')[i] == @comp_guess} #selects dic word only if
      end
    end

  end

  def receive_secret_length(s_word_length)
    @guessing_dictionary = File.readlines("Dictionary.txt").map(&:chomp)
    puts @guessing_dictionary.length
    @guessing_dictionary.select! {|word| word.length == s_word_length}
  end

  def guess_letter(guessed_letters)
    letters = guessing_dictionary.map{|word| word.split('')}.flatten
    letters = letters - guessed_letters

    k = Hash.new(0)
    letters.each{ |letter| k[letter] += 1 }
    @comp_guess = k.max_by{ |key| k[key] }[0]
  end

  def get_word
    @secret_word
  end

end
