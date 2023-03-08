require "tty-prompt"
require "./game.rb"

game = Game.new

10.times do
  game.print
  # FIRST BALL
  roll = game.first_roll
  game.score_roll(roll)
  game.on_mark(roll)
  game.update_mark(roll)
  ball = game.second_ball(roll)
  game.print

  # SECOND BALL
  if ball == 2
    roll = game.second_roll
    game.score_roll(roll)
    game.on_mark(roll)
    game.update_mark(roll)
    game.print
  end

  # THIRD BALL (TENTH FRAME)
  ball = game.third_ball
  if ball == 3
    roll = game.third_roll
    game.score_roll(roll)
    game.on_mark(roll)
  end
end

game.print
