
  dictionary=[]
  File.readlines("dictionary.txt").each do |line|
    line.strip!
    dictionary.push(line) if line.length > 5 && line.length<12
  end


class Hangman
  attr_accessor :array, :choice, :guess, :strikes, :win
  def initialize(array)
    @array=array
    @choice=choose_word
    @strikes=[] #push incorrect guesses
    game_loop
  end

  def game_loop
    until strikes.include? "end"  do
      opening
      puts choice
      puts "The word to find has #{choice.length} letters"
      puts "#Strikes:#{strikes}"
      spaces
      display
      player_guess
      check_guess
      if strikes.length==5
        strikes.push("end")
      end
    end
    win=false if strikes.length>5
  end_game
  end

  def opening
    puts "="*55
    puts  "Hangman is a game of deduction where the player is tasked with guessing the correct word letter by letter. If you guess the correct letter it will appear on the board if you guess an incorrect letter you will earn a strike. You have 5 strikes before you lose the game."
    puts "="*55
    puts"\n"
  end

  def randnum
    Random.rand(array.length)
  end


  def choose_word
   array[randnum]
  end


  def player_guess
    puts "Make your guess(letters or the word)"
    @guess=gets.chomp.upcase
  end

  def check_guess
    if choice.upcase.include? guess
      if guess.length>1
        if guess.upcase==choice.upcase
          @win=true
        else
          puts "That is incorrect"
          strikes.push("+")
        end
      else
        display
      end
    else
      strikes.push(guess)
    end
  end

  def display
    @@counter=0
    base=choice.upcase.split(//)
    nu=[]
    if win==false
      nu.insert(@@counter,guess)
      @@counter+=1
    end
    p nu
    p base
    puts "\n"
    @win=true if nu.join("").upcase==choice.upcase
  end

  def end_game
    if win==true
      puts "-"*55
      puts "\n"+"You guessed the word!"+"\n"
      strikes.push("end")
    else
      puts "-"*55
      puts "\n"+"Better luck next time!"+"\n"
      # puts "Another game? (y/n)"
      # print "> "
      # 5.times do; strikes.delete_at(0); end
      # false unless gets.chomp.upcase == "Y"
    end
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
  end

end

Hangman.new(dictionary)
