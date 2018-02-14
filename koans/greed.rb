# EXTRA CREDIT:
#
# Rules for the game are in GREED_RULES.TXT.

def score(dice)
  p = 0 # total points
  np = 0 # number of non-scoring dice
  ch = Hash.new(0)
  dice.each { |n| ch[n.to_s.to_sym] += 1 }
  ch.each { |key, v|
    k = key.to_s.to_i
    if v >= 3
      if k == 1
        p += (1000 + 100 * (v - 3))
      elsif k == 5
        p += (k * 100 + 50 * (v - 3))
      else
        p += k * 100
        np += (v - 3) 
      end
    else
      if k == 1
        p += (v * 100)
      elsif k == 5
        p += (v * 50)
      else
        np += v
      end
    end
  }
  {points: p, non_scoring_dice_count: np}
end


class DiceSet
  def roll(size)
    @values = Array.new(size, 0).map! {|n| rand(1..6)}
  end

  def values
    @values
  end
end


class Player
  attr_accessor :name, :points, :in_game, :dice_count

  def initialize(name, dice_count)
    @name = name
    @points = 0
    @in_game = false
    @dice_count = dice_count
    puts "#{@name} joined the game."
  end

  def roll(*args)
    size = args.size > 0 ? args[0] : @dice_count
    ds = DiceSet.new.roll(size)
    s = score(ds)
    points = s[:points]
    puts "#{@name} rolled #{ds}, scored #{points} points."
    args.size > 0 ? points : s
  end
  
  def in_game?
    @in_game
  end

  def accumulates(points)
    @points += points
    puts "#{@name} has #{@points} points now."
  end

  def want_to_roll?
    loop do
      print "#{@name}, you have #{@dice_count} dice. Do you want to roll? (y/n) : "
      a = gets.chomp.downcase
      if a == "y" || a == "n"
        return (a == "y")
      end
    end
  end
  
end


class Greed
  Dice_Count = 5
  Final_Threshold = 3000
  In_Game_Threshold = 300
  
  attr_accessor :players, :final

  def initialize
    graceful_exit
    welcome
  end

  def welcome
    puts "\n>>>>>>>>>> Welcome to Greed! <<<<<<<<<<"
    names = []
    loop do
      puts "Enter players' names, separate by comma. (Minimum 2 players)"
      names = gets.chomp.split(',')
      break if names.size >= 2
    end
    @players = names.map { |name|
      Player.new(name.strip, Dice_Count)
    }
  end
  
  def start
    puts "\n>>>>>>>>>> Game starts now! <<<<<<<<<<"
    
    until @final

      @players.each do |player|
        puts "\n>>>>>>> #{player.name}'s turn <<<<<<<"
        unless player.in_game?
          get_in_game(player) # not in game yet, try to get in
        else # in game
          turn_points = play_turn(player)
          player.accumulates(turn_points)
        end

        @final = finalize_game(player)
        break if @final # exit each 
      end

    end

    # final round, each remaining player has one more chance to roll 
    remaining_players = @players.select {|p| p != @winner}
    remaining_players.each {|p| p.accumulates(p.roll[:points])}

    # end game and show score board
    end_game
  end

  def get_in_game(player)
    puts "\n>>> #{player.name} is trying to get into the game."
    p = player.roll(Dice_Count)
    if p >= In_Game_Threshold
      player.in_game = true
      player.accumulates(p)
      puts "\n>>> ALERT <<<"
      puts "#{player.name} is in the game now."
    else
      puts "#{player.name} failed to get in the game."
    end
  end

  def play_turn(player)
    turn_points = 0
    while player.want_to_roll? 
      s = player.roll
      points = s[:points]
      nsdc = s[:non_scoring_dice_count]
      if points > 0
        turn_points += s[:points]
        if nsdc > 0 && player.dice_count == Dice_Count
          player.dice_count = nsdc
        end
        if nsdc == 0 && player.dice_count < Dice_Count
          player.dice_count = Dice_Count
        end
      else
        puts "#{player.name}, you lost this turn and #{turn_points} points."
        turn_points = 0
        break
      end
    end
    puts "#{player.name}, you scored #{turn_points} for this turn."
    turn_points
  end

  def finalize_game(player)
    @final = (player.points >= Final_Threshold)
    if @final
      @winner = player
      puts "\n>>>>>>> WARNING <<<<<<<"
      puts "#{player.name} has reached #{Final_Threshold} points. Final round starts now."
    end
    @final
  end

  def end_game
    @winner = @players.max {|a, b| a.points <=> b.points }
    puts "\n>>>>>>>>>> Game Over <<<<<<<<<<"
    puts "The winner is #{@winner.name}!"
    puts "#{@winner.name} has scored #{@winner.points} points!"
    puts "Congratulations, #{@winner.name}!"
    puts "Thank You! Goodbye!"
    puts ">>>>>>>>>> Game Over <<<<<<<<<<\n"
  end
  
  # respond to Ctrl-C
  def graceful_exit
    Signal.trap("INT") {
      puts "\nExiting Greed game..."
      exit
    }
  end

end

Greed.new.start
