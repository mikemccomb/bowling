require "tty-prompt"

prompt = TTY::Prompt.new
score_arr = []
score = 0

def score(arr)
  score = 0
  arr.each do |frame|
    score += frame
  end
  return score
end

on_strike = 0
on_spare = false
frame = 1
frame_score = 0

while frame < 10
  system "clear"
  puts "SCORE: #{score(score_arr)}"
  p score_arr
  puts "STRIKE: #{on_strike}" # Remove after testing
  puts "SPARE: #{on_spare}" # Remove after testing
  puts "FRAME #{frame}" #Remove after testing
  roll = prompt.ask("How many pins did you knock down on your first ball?").to_i
  if roll == 10
    score_arr[frame - 1] = roll # STRIKE
    if on_strike == 2
      score_arr[frame - 3] += roll # Turkey (XXX)
      score_arr[frame - 2] += roll # Add to previous frame's X
    elsif on_strike == 1
      score_arr[frame - 2] += roll # Add to previous frame's X
      on_strike += 1
    elsif on_spare
      score_arr[frame - 2] += roll # Add to previous frame's spare
      on_strike += 1
      on_spare = false
    else
      on_strike += 1
    end
  else # Roll < 10
    if on_strike == 2
      score_arr[frame - 3] += roll # XX + roll
      on_strike -= 1 # Set up logic for roll2
    elsif on_spare
      score_arr[frame - 2] += roll # Add to previous frame's spare; simplify with line 36
      on_spare = false
    end
    roll2 = prompt.ask("How many pins did you knock down on your second ball?").to_i
    frame_score = roll + roll2
    if on_strike == 1 # Finish previous X math
      on_strike -= 1
      score_arr[frame - 2] += frame_score
      score_arr[frame - 1] = frame_score
      if frame_score == 10 # Spare
        on_spare = true
      end
    else # Spare or open frame
      score_arr[frame - 1] = frame_score
      if frame_score == 10 # Spare
        on_spare = true
      end
    end
  end
  frame += 1
end

system "clear"
puts "SCORE: #{score(score_arr)}"
p score_arr
puts "STRIKE: #{on_strike}"
puts "SPARE: #{on_spare}"
puts "FRAME #{frame}" #FRAME 10
roll = prompt.ask("How many pins did you knock down on your first ball?").to_i
if roll == 10 # STRIKE ON BALL 1
  score_arr[frame - 1] = roll
  if on_strike == 2 # Close out first X math
    score_arr[frame - 3] += roll
    score_arr[frame - 2] += roll
  elsif on_strike == 1 # Double
    score_arr[frame - 2] += roll
    on_strike += 1
  elsif on_spare # Close out spare math
    score_arr[frame - 2] += roll
    on_strike += 1
    on_spare = false
  else
    on_strike += 1
  end
  roll2 = prompt.ask("How many pins did you knock down on your second ball?").to_i
  score_arr[frame - 1] += roll2 # Adding in 10th
  if on_strike == 2
    score_arr[frame - 2] += roll2 # Close out X in 9th
  end
  roll3 = prompt.ask("How many pins did you knock down on your third ball?").to_i
  score_arr[frame - 1] += roll3 # Final ball
else # Roll < 10
  if on_strike == 2
    score_arr[frame - 3] += roll # Close out X in 8th
    on_strike -= 1
  elsif on_spare # Close out spare math
    score_arr[frame - 2] += roll
    on_spare = false
  end
  roll2 = prompt.ask("How many pins did you knock down on your second ball?").to_i
  frame_score = roll + roll2
  if on_strike == 1 # Close out X in 9th
    score_arr[frame - 2] += frame_score
    score_arr[frame - 1] = frame_score
    on_strike -= 1
  else # Spare or open frame
    score_arr[frame - 1] = frame_score
  end
  if frame_score == 10 # Spare
    roll3 = prompt.ask("How many pins did you knock down on your third ball?").to_i
    score_arr[frame - 1] += roll3 # Final ball
  end
end

puts "SCORE: #{score(score_arr)}"
p score_arr
puts "STRIKE: #{on_strike}"
puts "SPARE: #{on_spare}"
