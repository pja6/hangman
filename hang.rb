
  dictionary=[]
  File.readlines("dictionary.rtf").each do |line|
    dictionary.push(line) if line.length > 5 && line.length<12
  end


class Hangman
  attr_accessor :array, :choice, :guess, :strikes
  def initialize(array)
    @array=array
    @choice=choose_word
    @guess=""
    @strikes=[] #push incorrect guesses
    over=false
    until over==true do
      opening
      red=choice.slice(/\w+/)
      puts red
      puts "The word to find has #{choice.length} letters"
      puts "#Strikes:#{strikes}"
      spaces
      player_guess
      check_guess
      if strikes.length==5
        over=true if gg
      end
    end
  end
  def opening
    puts "="*55
    puts  "Hangman is a game of deduction where the player is tasked with guessing the correct word letter by letter. If you guess the correct letter it will appear on the board if you guess an incorrect letter you will earn a strike. You have 5 strikes before you lose the game."
    puts "="*55
    puts"\n"
  end

  def choose_word
   array[randnum]
  end

  def randnum
    Random.rand(array.length)
  end

  def spaces
    puts "
           ______
          |      |
          |
          |
          |
       ___|___
    "
    puts "_ "*choice.length
  end

  def player_guess

    puts "Make your guess(letters only)"
    guess=gets.chomp.upcase[0...1]
    @guess=guess
  end

  def check_guess
    if choice.include? "#{guess}"
      puts guess
    else
      strikes.push(guess)
    end
  end

  def gg
    puts "Close but no cigar!"
    puts "Another game? (y/n)"
    print "> "
    5.times do; strikes.delete_at(0); end
    false unless gets.chomp.upcase == "Y"
  end

end

Hangman.new(dictionary)
