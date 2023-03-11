# class Ball
#   def initialize
#   end
# end

if @ball == 1 && ((roll < 10) || @frame == 10)
  @ball = 2
elsif @ball == 2
  unless @frame == 10 && @score_arr[-1] >= 10
    @frame += 1
    @ball = 1
  else
    @ball = 3
  end
  return @ball
end
