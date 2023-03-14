# class Ball
#   def initialize
#   end
# end

if @ball == 1
  # 0: F, -, blank
  # 10: X
  # NE: /, > 10
  # roll
elsif @ball == 2
  # 0: F, -, blank
  # Spare: / (10 - arr[-1]); (roll + arr[-1] == 10)
  # NE: spare math 0 < or > 10 (1F-9F) or > 20 (10F)
  # roll
else # ball == 3
  # 0: F, -, blank
  # If [-1] == 10, mark / (max 20)
  # If [-1] == 20, mark X (max 30)
  # If 10 < [-1] < 20, mark / (max 20)
end

def roll
  # Establish max
  if @ball == 2 && (@score_arr[-1] < 10)
    max = (10 - @score_arr[-1])
  elsif @ball == 3 && (@score_arr[-1] < 20)
    max = (20 - @score_arr[-1])
  else
    max = 10
  end

  prompt = TTY::Prompt.new
  roll = prompt.ask("BALL #{@ball}:")
  # Check roll validation
  if roll > max || roll == ""
    #
    puts "Error. Please re-enter score."
    # Validation: https://github.com/piotrmurach/tty-prompt#215-error-messages
  end

  # If roll valid:
  # Convert to integer, F, -, X, /
  if roll.upcase == "F" || roll == "-"
    roll = 0
  end
  # Else
  if @ball == 1
    max = 10
    # Player enters an incorrect value; see validation
    # if roll.to_i > max || roll == "/" || roll == ""
    #   puts "Error. Please re-enter score."
    # else
    #   ask = false
    # end

    # Alt to player entering 10 for a strike
    if roll == "X" || roll == 10
      puts "Nice strike!"
      @test_arr << "X"
      roll = 10
    else
      roll = roll.to_i
    end
  end

  if @ball == 2
    max = (10 - @score_arr[-1])

    # Acknowledge spare
    if roll == "/" || roll == max
      puts "Nice spare!"
      @test_arr << "/"
      roll = max
    else
      roll = roll.to_i
      @test_arr << "-"
    end

    # Player enters an incorrect value; see validation
    if roll.to_i > max || roll.upcase == "X" || roll == ""
      puts "Error. Please re-enter score."
    else
      ask = false
    end
  end

  if @ball == 3
  end

  return roll
end
