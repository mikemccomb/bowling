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
    system "clear"
    puts "SCORE: #{score(@score_arr)}"
    p @score_arr
    @frame < 11 ? (puts "FRAME #{@frame}") : (puts "GAME OVER")
    puts "STRIKE: #{@on_strike}"
    puts "SPARE: #{@on_spare}"
  end

  def roll(first)
    prompt = TTY::Prompt.new
    ask = true
    while ask
      roll = prompt.ask("BALL #{@ball}:")
      # Alts to player entering 0
      if roll.upcase == "F" || roll == "-"
        return 0
      end
      # Alt to player entering 10 for a strike
      if roll.upcase == "X"
        puts "Nice strike!"
        return 10
      end
      # Alts for player entering a spare
      if @ball == 2 && ((roll.to_i + first == 10) || roll == "/")
        puts "Nice spare!"
        return 10 - first
      end
      # Player enters an incorrect value
      if roll.to_i > 10 || (@ball == 1 && roll == "/") || (@ball == 2 && (roll.to_i + first > 10)) || (@ball == 3 && ((roll.to_i + first) > 30))
        puts "Error. Please re-enter score."
      else
        ask = false
      end
    end

    return roll.to_i
  end
end

# test = Game.new
# @score_arr = [10, 20, 10]
# puts test.print
