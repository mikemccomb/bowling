require "tty-prompt"

class Game
  attr_accessor :score_arr, :score, :on_strike, :on_spare, :frame, :ball

  def initialize
    @score_arr = []
    @score = 0
    @on_strike = 0
    @on_spare = false
    @frame = 1
    @ball = 1
  end

  def score(arr)
    arr.each do |frame|
      @score += frame
    end
    return @score
  end

  def print
    # system "clear"
    puts "SCORE: #{score(@score_arr)}"
    p @score_arr
    puts "BALL: #{@ball}"
    @frame < 11 ? (puts "FRAME #{@frame}") : (puts "GAME OVER")
    puts "STRIKE: #{@on_strike}"
    puts "SPARE: #{@on_spare}"
  end

  def first_roll
    prompt = TTY::Prompt.new
    ask = true
    while ask
      roll = prompt.ask("BALL #{@ball}:")
      # Alts to player entering 0
      if roll.upcase == "F" || roll == "-"
        return 0
      end
      # Alt to player entering 10 for a strike
      if roll.upcase == "X" || roll.to_i == 10
        puts "Nice strike!"
        return 10
      end
      # Player enters an incorrect value
      if roll.to_i > 10 || roll == "/"
        puts "Error. Please re-enter score."
      else
        ask = false
      end
    end

    return roll.to_i
  end

  def second_ball
    if (@score_arr[-1] < 10) || @frame == 10
      @ball = 2
    end

    return @ball
  end

  def second_roll
    prompt = TTY::Prompt.new
    ask = true
    while ask
      roll = prompt.ask("BALL #{@ball}:")
      # Alts to player entering 0
      if roll.upcase == "F" || roll == "-"
        return 0
      end
      # Acknowledge spare
      if roll == "/" || (roll.to_i + @score_arr[-1] == 10)
        puts "Nice spare!"
        return roll.to_i
      end
      # Player enters an incorrect value
      if ((roll.to_i + @score_arr[-1]) > 10) || roll == "X"
        puts "Error. Please re-enter score."
      else
        ask = false
      end
    end

    return roll.to_i
  end

  def third_ball
    if @frame == 10 && (@on_spare || @on_strike)
      @ball == 3
    end
    return @ball
  end

  def third_roll
    print
    @score_arr[@frame - 1] = roll(@score_arr[@frame - 1])
  end

  def score_roll(roll)
    if @ball == 1
      @score_arr << roll
    else
      @score_arr[-1] += roll
    end

    return @score_arr
  end

  def on_mark(roll)
    if @on_strike == 2
      @score_arr[-3] += roll
      @score_arr[-2] += roll
      if roll < 10
        @on_strike -= 1
      end
    elsif @on_strike == 1 || @on_spare
      @score_arr[-2] += roll
      @on_spare = false
    end

    if roll == 10 && @on_strike < 2
      @on_strike += 1
    end
  end

  # if on_strike == 2
  #   score_arr[frame - 3] += roll
  #   score_arr[frame - 2] += roll
  #   if roll < 10
  #     on_strike -= 1
  #   end
  # elsif on_strike == 1 || on_spare
  #   score_arr[frame - 2] += roll
  #   on_spare = false
  # end
  # IF STRIKE
  # if roll == 10 && on_strike < 2
  #   on_strike += 1
  # end
  # if roll < 10 || frame == 10
  #   ball = 2
  #   frame_score = roll
  # end
end

# test = Game.new
# @frame = 1
# @ball = 2
# @score_arr = [7]
# roll = 2
# puts test.score_roll(roll, @score_arr)
# test.print

#Second Roll
# # Alts for player entering a spare
# if @ball == 2 && ((roll.to_i + first == 10) || roll == "/")
#   puts "Nice spare!"
#   return 10 - first
# end

# # Player enters an incorrect value
# if roll.to_i > 10 || (@ball == 1 && roll == "/") || (@ball == 2 && (roll.to_i + first > 10)) || (@ball == 3 && ((roll.to_i + first) > 30))
#   puts "Error. Please re-enter score."
