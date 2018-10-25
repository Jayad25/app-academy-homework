class Ghost
  attr_accessor :fragment
  attr_reader :players, :current_player

  def initialize(dictionary, *players)
    @fragment = ""
    @dictionary = dictionary
    @players = players
    @current_player = players[0]
  end

  def valid_play?
    @dictionary.any? do |word|
      word.index(@fragment) == 0
    end
  end

  def add_letter(letter)
    @fragment += letter
  end

  def next_player!
    players.each_index do |i|
    end
  end

  def lost?
    @dictionary.include?(@fragment)
  end

  def play_round
    i = 0
    until players.length == 1
    # (@players.length).times do |i|
      @current_player = @players[i % @players.length]

      latest_letter = @current_player.move
      add_letter(latest_letter)
      p @fragment
      if lost? || !valid_play?
        puts "#{@current_player.name} lost the game"
        @current_player.score[@current_player.name] += 1
        p @current_player.score
        players.delete(@current_player) if @current_player.score[@current_player.name] == 3
        @fragment = ""
        # end
      end
      i += 1
    end
  end
end

class Player
  attr_reader :name
  attr_accessor :score

  def initialize(name)
    @name = name
    @score = Hash.new(0)
  end

  def move
    puts "Guess one letter:#{name}"
    move = gets.chomp
    alphabet = ('a'..'z').to_a
    until alphabet.include?(move)
      puts "Not a valid letter, enter a new letter:"
      move = gets.chomp
    end
    move
  end
end

if __FILE__ == $PROGRAM_NAME

  player1 = Player.new("Albert")
  player2 = Player.new("Ben")
  player3 = Player.new("Carol")
  dictionary = File.readlines("dictionary.txt").map(&:chomp)
  # puts "How many players? Enter number greater or equal to 2"
  # players = gets.chomp.to_i
  ghost = Ghost.new(dictionary, player1, player2, player3)
  puts "First to 3 loses the game."
  ghost.play_round
end
