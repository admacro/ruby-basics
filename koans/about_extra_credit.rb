# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.

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
  [p, np]
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
    puts "#{@name} rolled #{ds}, scored #{s[0]} points."
    args.size > 0 ? s[0] : s
  end
  
  def in_game?
    @in_game
  end

  def accumulates(points)
    @points += points
    puts "#{@name} has #{@points} points now."
  end

  def want_to_roll?
    #    return true
    loop do
      print "#{@name}, you have #{@dice_count} dice. Do you want to roll? (y/n) : "
      a = gets.chomp.downcase
      if a == "y" || a == "n"
        return (a == "y")
      end
    end
  end
  
end


class Game
  Dice_Count = 5
  attr_accessor :players, :final

  def initialize(player_names)
    puts "Greed game starts now!"
    @players = player_names.split(",").map { |name|
      Player.new(name, Dice_Count)
    }
  end
  
  def start
    loop do # 1
      @players.each do |player|
        @final = end_game(player)
        unless player.in_game?
          # not in game yet, try to get in
          get_in_game(player)
        else
          # in game
          turn_points = 0
          loop do # 2
            if player.want_to_roll?
              s = player.roll
              if s[0] > 0
                turn_points += s[0]
                if s[1] > 0 && player.dice_count == Dice_Count
                  player.dice_count = s[1]
                end
                if s[1] == 0 && player.dice_count < Dice_Count
                  player.dice_count = Dice_Count
                end
                break if @final # exit loop 2
              else
                turn_points = 0
                break
              end
            else
              break # exit loop 2
            end
          end
          player.accumulates(turn_points)
        end
        
        break if @final # exit each 
      end

      break if @final # exit loop 1
    end

    winner = @players.max {|a, b| a.points <=> b.points }
    puts "Game is over now! The winner is #{winner.name}!"
    puts "@{winner.name} has scored #{winner.points} points!"
    puts "Congratulations, #{winner.name}!"
  end

  def get_in_game(player)
    puts "#{player.name} is trying to get into the game."
    p = player.roll(Dice_Count)
    if p >= 300
      player.in_game = true
      player.accumulates(p)
      puts "#{player.name} is in the game now."
    end
  end

  def end_game(player)
    @final = (player.points >= 3000)
    puts "#{player.name} has reached 3000 points. Final round starts now." if @final
    @final
  end
  

end

Game.new("James,Russell,Tom").start
