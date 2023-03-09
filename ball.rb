# class Ball
#   def initialize
#   end
# end

# def score_roll(roll)
#   if @ball == 1
#     @score_arr << roll
#   else
#     @score_arr[-1] += roll
#   end

#   return @score_arr
# end

# def on_mark(roll) # FIX - 10F B2 and B3 add twice
#   if @on_strike == 2
#     if @frame == 10 && @ball == 2
#       @score_arr[-2] += roll
#     else
#       @score_arr[-2] += roll
#       @score_arr[-3] += roll
#     end
#   elsif @on_strike == 1 || @on_spare
#     if @frame == 10 && @ball > 1
#       @score_arr[-1] += roll
#     else
#       @score_arr[-2] += roll
#     end
#   end
# end

def update_score(roll)
  # if @ball == 1
  #   @score_arr << roll
  # else
  #   @score_arr[-1] += roll
  # end

  (@ball == 1) ? (@score_arr << roll) : (@score_arr[-1] += roll)

  if @frame == 10
    if @on_strike == 2
      if @ball == 1
        @score_arr[-2] += roll # Add to 9f
        @score_arr[-3] += roll # Add to 8f
      elsif @ball == 2
        @score_arr[-2] += roll # Add to 9f
      end
    elsif (@on_strike == 1 || @on_spare) && @ball == 1
      @score_arr[-2] += roll # Add to 9f
      @on_spare = false
    end
  else
    if @on_strike == 2
      @score_arr[-2] += roll
      @score_arr[-3] += roll
    elsif @on_strike == 1 || @on_spare
      @score_arr[-2] += roll
      @on_spare = false
    end
  end
end
