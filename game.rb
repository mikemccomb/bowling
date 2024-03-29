require "tty-prompt"
require "./display.rb"

class Game
  attr_accessor :score_arr, :on_strike, :on_spare, :frame, :ball, :player_name

  def initialize
    @score_arr = []
    @test_arr = []
    @scorecard = [[], [], [], [], [], [], [], [], [], []]
    # @running_total = [[], [], [], [], [], [], [], [], [], []]
    @on_strike = 0
    @on_spare = false
    @frame = 1
    @ball = 1
  end

  def print
    system "clear"
    puts "SCORE: #{@score_arr.sum}"
    p @scorecard
    p @score_arr
    # p @test_arr
    puts "BALL: #{@ball}"
    (@frame == 11) ? (puts "GAME OVER") : (puts "FRAME #{@frame}")
    puts "STRIKE: #{@on_strike} | SPARE: #{@on_spare}"
  end

  def roll_value
    prompt = TTY::Prompt.new
    ask = true
    # Calculate max value of roll
    max = 10
    max = (10 - @score_arr[-1]) if (@ball == 2 && (@score_arr[-1] < 10))
    max = (20 - @score_arr[-1]) if (@ball == 3 && (@score_arr[-1] < 20))

    while ask
      roll = prompt.ask("ROLL #{@ball}:", required: true)

      if roll.upcase == "F" || roll == "-"
        @scorecard[@frame - 1] << roll
        @test_arr << "-" if @ball > 1
        return 0
      end

      if @ball == 1 && (roll.upcase == "X" || roll.to_i == 10)
        @test_arr << "X"
        @scorecard[@frame - 1] << "X"
        return 10
      end

      if @ball == 2
        if roll.upcase == "X" # solve for X | 9/
          if frame == 10 && @on_strike > 0
            @test_arr << "X"
            @scorecard[@frame - 1] << "X"
            return 10
          else
            @test_arr << "/"
            @scorecard[@frame - 1] << "/"
            return max
          end
        end

        if roll == "/" || (roll.to_i == max)
          @test_arr << "/"
          @scorecard[@frame - 1] << "/"
          return max
        end
      end

      if @ball == 3
        # Finesse for all cases
        if roll.upcase == "X"
          @test_arr << "X"
          @scorecard[@frame - 1] << "X"
          return max
        elsif roll == "/"
          @test_arr << roll
          @scorecard[@frame - 1] << "/"
          return max
        end
      end

      if roll.to_i > max
        puts "Error. Please re-enter score."
      else
        @test_arr << "-" if @ball > 1
        @scorecard[@frame - 1] << roll.to_i
        return roll.to_i
      end
    end
  end

  def update_ball(roll) # Tidy up?
    if @ball == 1 && ((roll < 10) || @frame == 10)
      @ball = 2
    else
      unless @frame == 10 && @score_arr[-1] >= 10 && @ball < 3
        @frame += 1
        @ball = 1
      else
        @ball = 3
      end
    end
  end

  def update_score(roll)
    (@ball == 1) ? (@score_arr << roll) : (@score_arr[-1] += roll)
    (@score_arr[-2] += roll) if (@on_strike > 0 || @on_spare)
    (@score_arr[-3] += roll) if (@on_strike == 2)
  end

  def update_mark(roll)
    @on_spare = false
    if @frame == 10
      (@ball == 1 && @on_strike > 0) ? (@on_strike = 1) : (@on_strike = 0)
    else # Frames 1-9
      if @ball == 1
        @on_strike += 1 if (roll == 10 && @on_strike < 2)
      else
        @on_strike = 0
      end
      @on_spare = true if (@ball == 2 && @score_arr[-1] == 10)
    end
  end

  def play_again
    prompt = TTY::Prompt.new
    prompt.yes?("Would you like to play again?")
  end
end
