class Game
  def initialize
    @score_arr = []
    @score = 0
    @on_strike = 0
    @on_spare = false
    @frame = 1
    @ball = 1
  end

  def score
    return @score
  end
end

test = Game.new
p test.score
