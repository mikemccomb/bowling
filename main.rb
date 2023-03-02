require "tty-prompt"
require "./game.rb"

game = Game.new
# score_arr = []
# score = 0
# on_strike = 0
# on_spare = false
# frame = 1
# ball = 1

# def roll(ball, first)
#   prompt = TTY::Prompt.new
#   ask = true
#   while ask
#     roll = prompt.ask("BALL #{ball}:")
#     # Alts to player entering 0
#     if roll.upcase == "F" || roll == "-"
#       return roll = 0
#     end
#     # Alt to player entering 10 for a strike
#     if roll.upcase == "X"
#       puts "Nice strike!"
#       return roll = 10
#     end
#     # Alts for player entering a spare
#     if ball == 2 && ((roll.to_i + first == 10) || roll == "/")
#       puts "Nice spare!"
#       return roll = 10 - first
#     end
#     # Player enters an incorrect value
#     if roll.to_i > 10 || (ball == 1 && roll == "/") || (ball == 2 && (roll.to_i + first > 10)) || (ball == 3 && ((roll.to_i + first) > 30))
#       puts "Error. Please re-enter score."
#     else
#       ask = false
#     end
#   end

#   return roll = roll.to_i
# end

10.times do
  game.print
  # FIRST BALL
  ball = 1
  roll = game.first_roll
  game.score_roll(roll)
  game.on_mark(roll)
  # if on_strike == 2
  #   score_arr[frame - 3] += roll
  #   score_arr[frame - 2] += roll
  #   if roll < 10
  #     on_strike -= 1
  #   end
  # elsif on_strike == 1 || on_spare
  #   score_arr[frame - 2] += roll
  #   on_spare = false
  # end
  # IF STRIKE
  # if roll == 10 && on_strike < 2
  #   on_strike += 1
  # end
  # if roll < 10 || frame == 10
  #   ball = 2
  #   frame_score = roll
  # end
  ball = game.second_ball
  game.print
  # SECOND BALL
  if ball == 2
    roll = game.roll(frame_score)
    score_arr[frame - 1] += roll
    if on_strike == 2
      score_arr[frame - 2] += roll
      if frame < 10 || (frame == 10 && roll < 10)
        on_strike -= 1
      end
    elsif on_strike == 1
      score_arr[frame - 2] += roll
      if frame < 10
        on_strike -= 1
      end
    end
    # SPARE ANY FRAME
    (score_arr[frame - 1] == 10 && ball == 2) ? on_spare = true : on_spare = false
  end

  ball = 1
  game.third_ball
  # if frame == 10 && (on_spare || on_strike > 0)
  #   ball = 3
  #   game.print
  #   roll = game.roll(score_arr[frame - 1])
  #   score_arr[frame - 1] += roll # Final ball
  # end
  # @frame += 1
end

game.print
