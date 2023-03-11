require "tty-prompt"
require "./game.rb"

game = Game.new

10.times do
  game.print
  # FIRST BALL
  roll = game.first_roll
  game.update_score(roll)
  game.update_mark(roll)
  ball = game.update_ball(roll)
  game.print

  # SECOND BALL
  if ball == 2
    roll = game.second_roll
    game.update_score(roll)
    game.update_mark(roll)
    ball = game.update_ball(roll)
    game.print
  end

  # THIRD BALL (TENTH FRAME)
  if ball == 3
    roll = game.third_roll
    game.update_score(roll)
  end
end

game.print
