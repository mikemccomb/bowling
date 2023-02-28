class Ball
  def initialize
  end

  def first_ball
    roll = prompt.ask("FIRST BALL:").to_i
    score_arr[frame - 1] = roll
    if on_strike == 2
      score_arr[frame - 3] += roll # Turkey (XXX)
      score_arr[frame - 2] += roll # Add to previous frame's X
    elsif on_strike == 1 || on_spare
      score_arr[frame - 2] += roll # Add to previous frame's X or /
      on_strike += 1
      on_spare = false
    else
      on_strike += 1
    end
  end
end
