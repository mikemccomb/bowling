require "tty-prompt"

class Game
  attr_accessor :score_arr, :on_strike, :on_spare, :frame, :ball

  def initialize
    @score_arr = []
    @test_arr = [] # Remove after scorecard build
    @on_strike = 0
    @on_spare = false
    @frame = 1
    @ball = 1
  end

  def print
    system "clear"
    puts "SCORE: #{@score_arr.sum}"
    p @score_arr
    p @test_arr
    puts "BALL: #{@ball}"
    @frame < 11 ? (puts "FRAME #{@frame}") : (puts "GAME OVER")
    puts "STRIKE: #{@on_strike}"
    puts "SPARE: #{@on_spare}"
  end

  def first_roll
    prompt = TTY::Prompt.new
    ask = true
    @ball = 1
    while ask
      roll = prompt.ask("BALL #{@ball}:")
      # Alts to player entering 0
      if roll.upcase == "F" || roll == "-"
        return 0
      end
      # Alt to player entering 10 for a strike
      if roll.upcase == "X" || roll.to_i == 10
        puts "Nice strike!"
        @test_arr << "X"
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

  def second_ball(roll) # Consolidate with third_ball
    if (roll < 10) || @frame == 10
      @ball = 2
    end
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
      # Tenth frame 2nd strike
      if @frame == 10 && @on_strike > 0 && (roll.upcase == "X" || roll.to_i == 10)
        @test_arr << "X"
        return 10
      end
      # Acknowledge spare
      if roll == "/" || (roll.to_i + @score_arr[-1] == 10)
        puts "Nice spare!"
        @test_arr << "/"
        return roll.to_i
      end
      # Player enters an incorrect value
      if ((roll.to_i + @score_arr[-1]) > 10) || roll == "X"
        puts "Error. Please re-enter score."
      else
        ask = false
        @test_arr << "-"
      end
    end

    return roll.to_i
  end

  def third_ball
    if @frame == 10 && (@on_spare || @on_strike)
      @ball = 3
    else
      @ball = 1
      @frame += 1
    end

    return @ball
  end

  def third_roll # ID cases and rebuild
    print
    prompt = TTY::Prompt.new
    ask = true
    while ask
      roll = prompt.ask("BALL #{@ball}:")
      if roll.to_i == 10 || roll.upcase == "X"
        if @on_stike == 2
          @test_arr << "X"
          return 10
          # X-/ on_strike = 1; roll = 10
          # X-- on_strike = 1; roll < 10
          # 10 + roll2 + roll3; max 20
        elsif @on_strike == 1 || @on_spare
          if (@score_arr[-1] + roll.to_i) <= 20
            return roll.to_i
          end
        end
      end
      # Alts to player entering 0
      if roll.upcase == "F" || roll == "-"
        return 0
      end
      if roll == "/" || (roll.to_i + @score_arr[-1] == 10)
        puts "Nice spare!"
        @test_arr << "/"
        return roll.to_i
      end
      # Player enters an incorrect value
      if (roll.to_i > 10)
        puts "Error. Please re-enter score."
      else
        ask = false
        @test_arr << "-"
      end
    end

    return roll.to_i
  end

  def score_roll(roll)
    if @ball == 1
      @score_arr << roll
    else
      @score_arr[-1] += roll
    end

    return @score_arr
  end

  def on_mark(roll) # FIX
    if @on_strike > 0 || @on_spare
      @score_arr[-2] += roll
    end

    if @on_strike == 2 # Need to fix for 10th; 8th = 40
      @score_arr[-3] += roll
    end
  end

  def update_mark(roll) # Need to reset to 0 on spare/open
    if @ball == 1
      if roll == 10 && @on_strike < 2
        @on_strike += 1
      elsif @on_strike > 0 && roll < 10
        @on_strike -= 1
      end
    end

    if @ball == 2 && @score_arr[-1] == 10
      @on_spare = true
    else
      @on_spare = false
    end
  end
end
