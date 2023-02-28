require "tty-prompt"

prompt = TTY::Prompt.new
score_arr = []
score = 0
on_strike = 0
on_spare = false
frame = 1

def score(arr)
  score = 0
  arr.each do |frame|
    score += frame
  end
  return score
end

def print(score_arr, on_strike, on_spare, frame)
  system "clear"
  puts "SCORE: #{score(score_arr)}"
  p score_arr
  puts "STRIKE: #{on_strike}"
  puts "SPARE: #{on_spare}"
  puts "FRAME #{frame}"
end

10.times do
  print(score_arr, on_strike, on_spare, frame)
  # FIRST BALL
  roll = prompt.ask("FIRST BALL:").to_i
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
  print(score_arr, on_strike, on_spare, frame)
  # SECOND BALL
  if roll < 10 || frame == 10
    roll2 = prompt.ask("SECOND BALL:").to_i
    score_arr[frame - 1] += roll2
    if on_strike == 2
      score_arr[frame - 2] += roll2 # Close out X in 9th
      if frame < 10
        on_strike -= 1
      end
    end
    if on_strike == 1
      score_arr[frame - 2] += roll2
      on_strike -= 1
    end
    # SPARE ANY FRAME
    if roll + roll2 == 10 # Spare
      on_spare = true
    end
  end

  if frame == 10 && (on_spare || on_strike > 0)
    roll3 = prompt.ask("THIRD BALL:").to_i
    score_arr[frame - 1] += roll3 # Final ball
  end

  if frame < 10
    frame += 1
  end
end

print(score_arr, on_strike, on_spare, frame)
