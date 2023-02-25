require "tty-prompt"

prompt = TTY::Prompt.new
# scorecard = [["-", "-"], [" ", " "], [" ", " "], [" ", " "], [" ", " "], [" ", " "], [" ", " "], [" ", " "], [" ", " "], [" ", " ", " "]]
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
  # scorecard[0][1] = "X"
else
  # scorecard[0][0] = roll
  roll2 = prompt.ask("How many pins did you knock down on your second ball?").to_i
  frame1 = roll + roll2
  if frame1 == 10
    on_spare = true
  end
  score_arr[0] = frame1
end
puts "SCORE: #{score(score_arr)}"
# puts scorecard

puts "FRAME 2"
roll = prompt.ask("How many pins did you knock down on your first ball?").to_i
if roll == 10 # STRIKE
  if on_strike == 1
    score_arr[0] += roll
    score_arr[1] = roll
  elsif on_spare
    score_arr[0] += roll
    score_arr[1] = roll
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
