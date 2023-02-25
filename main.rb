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
strike_message = {
  1 => "Nice strike!",
  2 => "Double trouble!",
  3 => "Turkey time!",
  4 => "4-bagger!",
  5 => "5-bagger!",
  6 => "6-bagger!",
  7 => "7-bagger!",
  8 => "8-bagger!",
  9 => "9-bagger!",
  10 => "10-bagger!",
  11 => "Everybody be quiet...",
  12 => "PERFECT GAME!",
}
on_spare = false
puts "FRAME 1"
roll = prompt.ask("How many pins did you knock down on your first ball?").to_i
if roll == 10
  puts "Nice strike!"
  on_strike += 1
  frame1 = 10
  # scorecard[0][1] = "X"
else
  # scorecard[0][0] = roll
  roll2 = prompt.ask("How many pins did you knock down on your second ball?").to_i
  if roll + roll2 == 10
    puts "Nice spare!"
    on_spare = true
    frame1 = 10
  else
    frame1 = roll + roll2
  end
end
score_arr << frame1
puts "SCORE: #{score(score_arr)}"
# puts scorecard

puts "FRAME 2"
roll = prompt.ask("How many pins did you knock down on your first ball?").to_i
if roll == 10
  if on_strike > 1
    score_arr[0] += roll
  elsif on_spare
    puts "Nice strike!"
    score_arr[0] += roll
    on_strike += 1
  end
end
puts "SCORE: #{score(score_arr)}"
