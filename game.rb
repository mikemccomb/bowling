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

  def score(arr) # Not mathing correctly
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
      return 2
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
      return 3
    end
  end

  def third_roll #Build logic
    print
    @score_arr[@frame - 1] = roll(@score_arr[@frame - 1])
  end

  def score_roll(roll, ball)
    if ball == 1
      @score_arr << roll
    else
      @score_arr[-1] += roll
    end

    return @score_arr
  end

  def on_mark(roll) # Might need ball as param
    if @on_strike > 0 || @on_spare
      @score_arr[-2] += roll
      if @on_strike == 2
        @score_arr[-3] += roll
      end
    end
  end

  def update_mark(ball, roll) # Watch out for frame 10
    if ball == 1
      if roll == 10 && @on_strike < 2
        @on_strike += 1
      elsif @on_strike > 0 && roll < 10
        @on_strike -= 1
      end
    end

    if ball == 2 && @score_arr[-1] == 10
      @on_spare = true
    end
  end
end
