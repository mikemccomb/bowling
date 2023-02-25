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

puts "FRAME 1"
roll = prompt.ask("How many pins did you knock down on your first ball?").to_i
if roll == 10
  puts "Nice strike!"
  on_strike += 1
  frame1 = 10
  score_arr[0] = frame1
else
  roll2 = prompt.ask("How many pins did you knock down on your second ball?").to_i
  frame1 = roll + roll2
  if frame1 == 10
    on_spare = true
  end
  score_arr[0] = frame1
end
puts "SCORE: #{score(score_arr)}"
p score_arr
p on_strike
p on_spare

puts "FRAME 2"
roll = prompt.ask("How many pins did you knock down on your first ball?").to_i
if roll == 10 # STRIKE
  if on_strike == 1
    score_arr[0] += roll
    score_arr[1] = roll
  elsif on_spare
    score_arr[0] += roll
    score_arr[1] = roll
    on_spare = false
  else
    score_arr[1] = roll
  end
  on_strike += 1
else # Roll < 10
  if on_spare
    score_arr[0] += roll
    on_spare = false
  end
  roll2 = prompt.ask("How many pins did you knock down on your second ball?").to_i
  frame2 = roll + roll2
  if on_strike == 1 # Finish previous X math
    on_strike = 0
    score_arr[0] += frame2
    score_arr[1] = frame2
    if frame2 == 10 # Spare
      on_spare = true
    end
  else # Spare or open frame
    score_arr[1] = frame2
    if frame2 == 10 # Spare
      on_spare = true
    end
  end
end
puts "SCORE: #{score(score_arr)}"
p score_arr
p on_strike
p on_spare

puts "FRAME 3"
roll = prompt.ask("How many pins did you knock down on your first ball?").to_i
if roll == 10 # STRIKE
  if on_strike == 2 # Close out first X math
    score_arr[0] += roll
    score_arr[1] += roll
    score_arr[2] = roll
  elsif on_strike == 1 # Double
    score_arr[1] += roll
    score_arr[2] = roll
    on_strike += 1
  elsif on_spare # Close out spare math
    score_arr[1] += roll
    score_arr[2] = roll
    on_strike += 1
    on_spare = false
  else
    score_arr[2] = roll # First strike
    on_strike += 1
  end
else # Roll < 10
  if on_strike == 2
    score_arr[0] += roll # Close out first X
    on_strike -= 1
  elsif on_spare # Close out spare math
    score_arr[1] += roll
    on_spare = false
  end
  roll2 = prompt.ask("How many pins did you knock down on your second ball?").to_i
  frame3 = roll + roll2
  if on_strike == 1 # Finish previous X math
    on_strike -= 1
    score_arr[1] += frame3
    score_arr[2] = frame3
    if frame3 == 10 # Spare
      on_spare = true
    end
  else # Spare or open frame
    score_arr[2] = frame3
    if frame3 == 10 # Spare
      on_spare = true
    end
  end
end
puts "SCORE: #{score(score_arr)}"
p score_arr
puts "STRIKE: #{on_strike}"
puts "SPARE: #{on_spare}"

puts "FRAME 4"
roll = prompt.ask("How many pins did you knock down on your first ball?").to_i
if roll == 10 # STRIKE
  if on_strike == 2 # Close out first X math
    score_arr[1] += roll
    score_arr[2] += roll
    score_arr[3] = roll
  elsif on_strike == 1 # Double
    score_arr[2] += roll
    score_arr[3] = roll
    on_strike += 1
  elsif on_spare # Close out spare math
    score_arr[2] += roll
    score_arr[3] = roll
    on_strike += 1
    on_spare = false
  else
    score_arr[3] = roll # First strike
    on_strike += 1
  end
else # Roll < 10
  if on_strike == 2
    score_arr[1] += roll # Close out first X
    on_strike -= 1
  elsif on_spare # Close out spare math
    score_arr[2] += roll
    on_spare = false
  end
  roll2 = prompt.ask("How many pins did you knock down on your second ball?").to_i
  frame4 = roll + roll2
  if on_strike == 1 # Finish previous X math
    on_strike -= 1
    score_arr[2] += frame4
    score_arr[3] = frame4
    if frame4 == 10 # Spare
      on_spare = true
    end
  else # Spare or open frame
    score_arr[3] = frame4
    if frame4 == 10 # Spare
      on_spare = true
    end
  end
end
puts "SCORE: #{score(score_arr)}"
p score_arr
puts "STRIKE: #{on_strike}"
puts "SPARE: #{on_spare}"
