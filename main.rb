require "tty-prompt"
require "./game.rb"

game = Game.new

while game.frame < 11
  game.print
  roll = game.first_roll if game.ball == 1
  roll = game.second_roll if game.ball == 2
  roll = game.third_roll if game.ball == 3
  # roll = game.first_roll
  # roll = game.roll_value
  game.update_score(roll)
  game.update_mark(roll)
  ball = game.update_ball(roll)
  game.print

  # # SECOND BALL
  # if ball == 2
  #   # roll = game.second_roll
  #   roll = game.roll_value
  #   game.update_score(roll)
  #   game.update_mark(roll)
  #   ball = game.update_ball(roll)
  #   game.print
  # end

  # # THIRD BALL (TENTH FRAME)
  # if ball == 3
  #   # roll = game.third_roll
  #   roll = game.roll_value
  #   game.update_score(roll)
  # end
end

game.print
