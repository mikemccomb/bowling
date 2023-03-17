require "tty-prompt"
require "./display.rb"

game = Game.new
display = Display.new

while game.frame < 11
  game.print
  roll = game.roll_value
  game.update_score(roll)
  game.update_mark(roll)
  ball = game.update_ball(roll)
  game.print
end
