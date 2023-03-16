def roll_value
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
    max = 10
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

def third_roll # Simplify; roll only adds to 10F
  print
  prompt = TTY::Prompt.new
  ask = true
  while ask
    roll = prompt.ask("BALL #{@ball}:", required: true)
    if roll.to_i == 10 || roll.upcase == "X"
      if @on_strike == 2 # DNE; on_strike = 0
        @test_arr << "X"
        return 10
        # X-/ on_strike = 1; roll = 10
        # X-- on_strike = 1; roll < 10
        # 10 + roll2 + roll3; max 20
      elsif @on_strike == 1 || @on_spare
        if (@score_arr[-1] + roll.to_i) <= 20
          return roll.to_i
        end
      end
    end
    # Alts to player entering 0
    if roll.upcase == "F" || roll == "-"
      return 0
    end
    if roll == "/" || (roll.to_i + @score_arr[-1] == 10)
      puts "Nice spare!"
      @test_arr << "/"
      return roll.to_i
    end
    # Player enters an incorrect value
    if (roll.to_i > 10)
      puts "Error. Please re-enter score."
    else
      ask = false
      @test_arr << "-"
    end
  end

  return roll.to_i
end

def third_roll
  print
  prompt = TTY::Prompt.new
  ask = true
  (@score_arr[-1] == 20) ? (max = 10) : (max = 20 - @score_arr[-1])

  while ask
    roll = prompt.ask("BALL #{@ball}:", required: true)

    if roll.upcase == "F" || roll == "-"
      return 0
    end

    if roll.upcase == "X" || roll == "/"
      @test_arr << roll
      return max
    end

    if (roll.to_i > max)
      puts "Error. Please re-enter score."
    else
      @test_arr << "-"
      return roll.to_i
    end
  end
end

def second_roll # Wonky
  prompt = TTY::Prompt.new
  ask = true

  @score_arr[-1] == 10 ? (max = 10) : (max = 10 - @score_arr[-1])

  while ask
    roll = prompt.ask("BALL #{@ball}:", required: true)

    if roll.upcase == "F" || roll == "-"
      return 0
    end

    if roll.upcase == "X"
      if frame == 10 && @on_strike > 0
        @test_arr << "X"
        return 10
      else
        @test_arr << "/"
        return max
      end
    end

    if roll == "/" || (roll.to_i == max)
      @test_arr << "/"
      return max
    end

    if (roll.to_i > max)
      puts "Error. Please re-enter score."
    else
      @test_arr << "-"
      return roll.to_i
    end
  end
end
