def roll_value
  # BALL 1
  prompt = TTY::Prompt.new
  ask = true
  # Calculate max value of roll
  max = 10
  # @score_arr[-1] == 10 ? (max = 10) : (max = 10 - @score_arr[-1]) if @ball == 2
  max = (10 - @score_arr[-1]) if (@ball == 2 && (@score_arr[-1] < 10))
  # (@score_arr[-1] == 20) ? (max = 10) : (max = 20 - @score_arr[-1]) if @ball == 3
  max = (20 - @score_arr[-1]) if (@ball == 3 && (@score_arr[-1] < 20))

  while ask
    roll = prompt.ask("BALL #{@ball}:", required: true)

    if roll.upcase == "F" || roll == "-"
      return 0
    end

    if @ball == 1 && (roll.upcase == "X" || roll.to_i == 10)
      @test_arr << "X"
      return 10
    end

    if @ball == 2
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
    end

    if @ball == 3
      # Finesse for all cases
      if roll.upcase == "X"
        @test_arr << "X"
        return max
      elsif roll == "/"
        @test_arr << roll
        return max
      end
    end

    if roll.to_i > max
      puts "Error. Please re-enter score."
    else
      @test_arr << "-" if @ball > 1
      return roll.to_i
    end
  end
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

def first_roll
  prompt = TTY::Prompt.new
  ask = true
  while ask
    roll = prompt.ask("BALL #{@ball}:", required: true)

    if roll.upcase == "F" || roll == "-"
      return 0
    end

    if roll.upcase == "X" || roll.to_i == 10
      @test_arr << "X"
      return 10
    end

    if roll.to_i > 10 || roll == "/"
      puts "Error. Please re-enter score."
    else
      return roll.to_i
    end
  end
end

[[], [], [], [], [], [], [], [], [], []]
