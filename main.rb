require "tty-prompt"
require "./game.rb"

game = Game.new

10.times do
  game.print
  # FIRST BALL
  ball = 1
  roll = game.first_roll
  game.score_roll(roll)
  game.on_mark(roll) # TEST: perform strike/spare math
  game.update_mark(ball, roll)
  ball = game.second_ball(roll) # Determines if second ball
  game.print

  # SECOND BALL
  if ball == 2
    roll = game.second_roll # Returns value for 2nd roll
    game.score_roll(roll)
    game.on_mark(roll)
    game.print
  end

  # THIRD BALL (TENTH FRAME)
  ball = game.third_ball
  # if ball == 3
  #   game.third_roll # NEED TO BUILD
  # end
end

game.print
