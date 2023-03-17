require "./game.rb"

class Display < Game
  attr_accessor :score_arr, :on_strike, :on_spare, :frame, :ball

  def initialize
    super
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
end
