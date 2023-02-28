require "tty-prompt"

prompt = TTY::Prompt.new
score_arr = []
score = 0
on_strike = 0
on_spare = false
frame = 1
frame_score = 0

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

while frame < 10
  print(score_arr, on_strike, on_spare, frame)
  roll = prompt.ask("FIRST BALL:").to_i
  score_arr[frame - 1] = roll
  if roll == 10
    if on_strike == 2
      score_arr[frame - 3] += roll # Turkey (XXX)
      score_arr[frame - 2] += roll # Add to previous frame's X
    elsif on_strike == 1 || on_spare
      score_arr[frame - 2] += roll # Add to previous frame's X or /
      on_strike += 1
      on_spare = false
    else
      on_strike += 1
    end
  else # Roll < 10
    if on_strike == 2
      score_arr[frame - 3] += roll # XX + roll
      score_arr[frame - 2] += roll
      on_strike -= 1 # Set up logic for roll2
    elsif on_strike == 1 || on_spare
      score_arr[frame - 2] += roll # Add to previous frame's spare; simplify with line 36
      on_spare = false
    end
    # Second ball in frame
    roll2 = prompt.ask("SECOND BALL:").to_i
    score_arr[frame - 1] += roll2
    if on_strike == 1 # Finish previous X math
      score_arr[frame - 2] += roll2
      on_strike -= 1
    end
    if roll + roll2 == 10 # Spare
      on_spare = true
    end
  end
  frame += 1
end

# TENTH FRAME
print(score_arr, on_strike, on_spare, frame)
roll = prompt.ask("FIRST BALL:").to_i
score_arr[frame - 1] = roll
if roll == 10 # STRIKE ON BALL 1
  if on_strike == 2 # Close out first X math
    score_arr[frame - 3] += roll
    score_arr[frame - 2] += roll
  elsif on_strike == 1 || on_spare
    score_arr[frame - 2] += roll
    on_strike += 1
    on_spare = false
  else
    on_strike += 1
  end
  roll2 = prompt.ask("SECOND BALL:").to_i
  score_arr[frame - 1] += roll2 # Adding in 10th
  if on_strike == 2
    score_arr[frame - 2] += roll2 # Close out X in 9th
  end
  roll3 = prompt.ask("THIRD BALL:").to_i
  score_arr[frame - 1] += roll3 # Final ball
else # Roll < 10
  if on_strike == 2
    score_arr[frame - 3] += roll # Close out X in 8th
    on_strike -= 1
  elsif on_spare # Close out spare math
    score_arr[frame - 2] += roll
    on_spare = false
  end
  roll2 = prompt.ask("SECOND BALL:").to_i
  # frame_score = roll + roll2
  score_arr[frame - 1] += roll2
  if on_strike == 1 # Close out X in 9th
    score_arr[frame - 2] += roll2
    on_strike -= 1 # Might be able to remove; keep when testing new game
  end
  if roll + roll2 == 10 # Spare
    roll3 = prompt.ask("THIRD BALL:").to_i
    score_arr[frame - 1] += roll3 # Final ball
  end
end

print(score_arr, on_strike, on_spare, frame)
