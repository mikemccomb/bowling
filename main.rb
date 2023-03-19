require "tty-prompt"
require "./display.rb"

# display = Display.new
# display.player

play = true

while play
  game = Game.new
  while game.frame < 11
    game.print
    # display.print
    roll = game.roll_value
    game.update_score(roll)
    game.update_mark(roll)
    # display.update_mark(roll)
    ball = game.update_ball(roll)
    # ball = display.update_ball(roll)
    game.print
    # display.print
  end
  play = game.play_again
end
