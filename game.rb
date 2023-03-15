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
    # puts "FRAME #{@frame}"
    (@frame == 11) ? (puts "GAME OVER") : (puts "FRAME #{@frame}")
    puts "STRIKE: #{@on_strike}"
    puts "SPARE: #{@on_spare}"
  end

  def first_roll
    prompt = TTY::Prompt.new
    ask = true
    while ask
      roll = prompt.ask("BALL #{@ball}:", required: true)
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
      if roll.to_i > 10 || roll == "/" || roll == ""
        puts "Error. Please re-enter score."
      else
        ask = false
      end
    end

    return roll.to_i
  end

  def update_ball(roll) # Consolidate with third_ball
    if @ball == 1 && ((roll < 10) || @frame == 10)
      @ball = 2
    else
      unless @frame == 10 && @score_arr[-1] >= 10 && @ball < 3
        @frame += 1
        @ball = 1
      else
        @ball = 3
      end
      return @ball
    end
  end

  def second_roll # Wonky
    prompt = TTY::Prompt.new
    ask = true
    while ask
      roll = prompt.ask("BALL #{@ball}:", required: true)
      # Alts to player entering 0
      if roll.upcase == "F" || roll == "-"
        return 0
      end
      # Tenth frame 2nd strike - SIMPLIFY
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

  def third_roll
    print
    prompt = TTY::Prompt.new
    ask = true
    (@score_arr[-1] == 20) ? (max = 10) : (max = 20 - @score_arr[-1])

    while ask
      roll = prompt.ask("BALL #{@ball}:", required: true)

      if roll.upcase == "F" || roll == "-"
        return 0
      end

      if roll.upcase == "X" || roll == "/"
        @test_arr << roll.upcase
        return max
      end

      if (roll.to_i > max)
        puts "Error. Please re-enter score."
      else
        @test_arr << "-"
        return roll.to_i
      end
    end
  end

  def update_score(roll)
    (@ball == 1) ? (@score_arr << roll) : (@score_arr[-1] += roll)
    (@score_arr[-2] += roll) if (@on_strike > 0 || @on_spare)
    (@score_arr[-3] += roll) if (@on_strike == 2)
  end

  def update_mark(roll)
    if @frame == 10
      if @ball == 1
        @on_strike = 1 if (@on_strike > 0)
        @on_spare = false
      else
        @on_strike = 0
      end
    else # Frames 1-9
      if @ball == 1
        @on_strike += 1 if (roll == 10 && @on_strike < 2)
        @on_spare = false
      else
        @on_strike = 0
        @on_spare = true if (@score_arr[-1] == 10)
      end
    end
  end
end
