require "tty-prompt"

prompt = TTY::Prompt.new
score_arr = []
score = 0
on_strike = 0
on_spare = false
frame = 1
ball = 1

def score(arr)
  score = 0
  arr.each do |frame|
    score += frame
  end
  return score
end

# def input_correct(ball, roll)
#   if ball == 1
#     # If roll > 10, retry
#     # If roll = 10, "nice strike"
#     # If roll = X, "nice strike"; mark it 10
#     # If roll = F or -, MARK IT ZERO!
#   end

#   if ball == 2
#     # If roll + roll2 > 10, retry
#     # If roll + roll2 = 10, "nice spare"
#     # If roll + roll2 = /, "nice spare"; roll2 = 10 - roll
#     # If roll = F or -, MARK IT ZERO!
#   end

#   if ball == 3
#     # If roll3 > 10, retry
#     # If on_strike = 1, roll2 + roll3 <= 10
#   end
# end

def print(score_arr, on_strike, on_spare, frame)
  system "clear"
  puts "SCORE: #{score(score_arr)}"
  p score_arr
  puts "FRAME #{frame}"
  # Hide below when done testing
  puts "STRIKE: #{on_strike}"
  puts "SPARE: #{on_spare}"
end

10.times do
  print(score_arr, on_strike, on_spare, frame)
  # FIRST BALL
  roll = prompt.ask("BALL #{ball}:").to_i
  score_arr[frame - 1] = roll
  if on_strike == 2
    score_arr[frame - 3] += roll
    score_arr[frame - 2] += roll
    if roll < 10
      on_strike -= 1
    end
  elsif on_strike == 1 || on_spare
    score_arr[frame - 2] += roll
    on_spare = false
  end
  # IF STRIKE
  if roll == 10 && on_strike < 2
    on_strike += 1
  end

  if roll < 10 || frame == 10
    ball = 2
  end
  print(score_arr, on_strike, on_spare, frame)
  # SECOND BALL
  if roll < 10 || frame == 10
    roll2 = prompt.ask("BALL #{ball}:").to_i
    score_arr[frame - 1] += roll2
    if on_strike == 2
      score_arr[frame - 2] += roll2 # Close out X in 9th
      if frame < 10 || (frame == 10 && roll2 < 10)
        on_strike -= 1
      end
    elsif on_strike == 1
      score_arr[frame - 2] += roll2
      if frame < 10
        on_strike -= 1
      end
    end
    # SPARE ANY FRAME
    if roll + roll2 == 10 # Spare
      on_spare = true
    end
  end

  ball = 1

  if frame == 10 && (on_spare || on_strike > 0)
    ball = 3
    print(score_arr, on_strike, on_spare, frame)
    roll3 = prompt.ask("BALL #{ball}:").to_i
    score_arr[frame - 1] += roll3 # Final ball
  end

  if frame < 10
    frame += 1
  end
end

print(score_arr, on_strike, on_spare, frame)
