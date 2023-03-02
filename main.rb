require "tty-prompt"
require "./game.rb"

game = Game.new

10.times do
  game.print
  # FIRST BALL
  ball = 1
  roll = game.first_roll # Returns value for 1st roll
  game.score_roll(roll, 1) # Adds roll value to array
  game.on_mark(roll) # TEST: perform strike/spare math
  ball = game.second_ball # Determines if second ball
  game.print
  # SECOND BALL
  if ball == 2
    roll = game.second_roll # Returns value for 2nd roll
    game.score_roll(roll, 2)
    game.print
    # score_arr[-1] += roll
    # Need to add to on_mark logic
    if on_strike == 2
      score_arr[-2] += roll
      if frame < 10 || (frame == 10 && roll < 10)
        on_strike -= 1
      end
    elsif on_strike == 1
      score_arr[-2] += roll
      if frame < 10
        on_strike -= 1
      end
    end
    # SPARE ANY FRAME
    (score_arr[-1] == 10 && ball == 2) ? on_spare = true : on_spare = false
  end

  ball = game.third_ball
  if ball == 3
    game.third_roll # NEED TO BUILD
  end
end

game.print
