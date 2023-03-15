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
  max = 10

  if @ball == 2 && (@score_arr[-1] < 10)
    max = (10 - @score_arr[-1])
  elsif @ball == 3 && (@score_arr[-1] < 20)
    max = (20 - @score_arr[-1])
  end

  prompt = TTY::Prompt.new
  roll = prompt.ask("BALL #{@ball}:", required: true)
  # Convert to integer, F, -, X, /
  roll = 0 if (roll.upcase == "F" || roll == "-")
  roll = 10 if roll.upcase == "X"
  # Check roll validation
  (puts "Error. Please re-enter score.") if roll.to_i > max

  # If roll valid:

  if @ball == 1
    # Alt to player entering 10 for a strike
    if roll == 10
      puts "Nice strike!"
      @test_arr << "X"
      roll = 10
    else
      roll = roll.to_i
    end
  end

  if @ball == 2
    # Acknowledge spare
    if roll == "/" || roll == max
      puts "Nice spare!"
      @test_arr << "/"
      roll = max
    else
      roll = roll.to_i
      @test_arr << "-"
    end
  end

  if @ball == 3
    if max == 10 # B3 Strike attempt
      if roll == "X" || roll == 10
        puts "Nice strike!"
        @test_arr << "X"
        roll = 10
      else
        roll = roll.to_i
        @test_arr << "-"
      end
    else # B3 spare attempt
      if roll == "/" || roll == max
        puts "Nice spare!"
        @test_arr << "/"
        roll = max
      else
        roll = roll.to_i
        @test_arr << "-"
      end
    end
  end

  return roll
end
