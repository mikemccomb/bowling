# class Ball
#   def initialize
#   end
# end

def update_mark(roll) # Need to reset to 0 on spare/open
  # 10 down on ball 1 = X
  # 10 down by ball 2 = /
  # If X; on_strike = 1, roll applies to previous frame (1-9)
  # If XX; on_strike = 2, roll applies to previous 2 frames (1-9)
  # on_strike > 0 && on_spare = true DNE
  # If /; on_spare = true, score applies to previous frame
  if @frame == 10
    if @ball == 1
      if roll == 10
        if @on_strike == 2
          @on_strike = 1
          # 8F math done; 10F2B still applies to 9th
        elsif @on_strike == 1
          # Nothing changes; ball 2 applies to 9th
        elsif @on_spare
          @on_strike = 1 # Needed to trigger ball 3
          @on_spare = false
        end
      else # roll < 10
        if @on_strike == 2
          @on_strike -= 1
        elsif @on_strike == 1
          # Nothing changes; ball 2 still applies to 9th
        elsif @on_spare
          @on_spare = false
        end
      end
    elsif @ball == 2
      if @on_strike == 2
        # DNE; B1 reduces to S1
      elsif @on_strike == 1
        @on_strike -= 1
        # Reduce to 0 so ball three does not count toward 9th
      elsif @on_spare
        # DNE
      end
    elsif @ball == 3
      if @on_strike == 2
        # DNE
      elsif @on_strike == 1
        # DNE
      elsif @on_spare
        # DNE
      end
    end
  else
    if @ball == 1
      if @on_strike == 2
      elsif @on_strike == 1
      elsif @on_spare
      end
    elsif @ball == 2
      if @on_strike == 2
      elsif @on_strike == 1
      elsif @on_spare
      end
    elsif @ball == 3
      if @on_strike == 2
      elsif @on_strike == 1
      elsif @on_spare
      end
    end
  else
  if @ball == 1
    if @strike == 2
    elsif @strike == 1
    elsif @on_spare
    end
  elsif @ball == 2
    if @strike == 2
    elsif @strike == 1
    elsif @on_spare
    end
  elsif @ball == 3
    if @strike == 2
    elsif @strike == 1
    elsif @on_spare
    end
  else
    if @ball == 1
      if @strike == 2
      elsif @strike == 1
      elsif @on_spare
      end
    elsif @ball == 2
      if @strike == 2
      elsif @strike == 1
      elsif @on_spare
      end
    elsif @ball == 3
      if @strike == 2
      elsif @strike == 1
      elsif @on_spare
      end
    end
  end
end
