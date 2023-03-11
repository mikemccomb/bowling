# class Ball
#   def initialize
#   end
# end

def update_mark(roll) # Need to reset to 0 on spare/open
  if @frame == 10
    if @ball == 1
      if roll == 10
        if @on_strike == 2
          @on_strike = 1
          # 8F math done; 10F2B still applies to 9th
        elsif @on_strike == 1
          # Nothing changes; ball 2 applies to 9th
        elsif @on_spare
          @on_spare = false
        end #No new mark needed for 10th; array value used to determine B3
      else # roll < 10
        if @on_strike == 2
          @on_strike = 1
        elsif @on_strike == 1
          # Nothing changes; ball 2 still applies to 9th
        elsif @on_spare
          @on_spare = false
        end
      end
    elsif @ball == 2
      if @on_strike == 2
        # DNE; B1 reduced to S1
      elsif @on_strike == 1
        @on_strike -= 1
        # Reduce to 0 so ball three does not count toward 9th
      elsif @on_spare
        # DNE
      end
    elsif @ball == 3 # Mark not needed; roll applies to 10F only
      if @on_strike == 2
        # DNE
      elsif @on_strike == 1
        # DNE
      elsif @on_spare
        # DNE
      end
    end
  else # Frames 1-9
    if @ball == 1
      if @on_strike == 2 && (roll < 10)
        @on_strike = 1
      elsif @on_strike == 1
        # If strike, now XX; else B2 would still apply to prev F
        (roll == 10) ? (@on_strike = 2) : (@on_strike = 1)
      elsif @on_spare
        @on_spare = false
        if roll == 10
          @on_strike = 1
        end
      elsif roll == 10
        @on_strike = 1
      end
    elsif @ball == 2
      if @on_strike == 2
        # DNE; if B1 < 10; S = 1
      elsif @on_strike == 1
        # Next frame would be S0
        @on_strike = 0
        # if frame closed, make on_spare true
        if @score_arr[-1] == 10
          @on_spare = true
        end
      elsif @on_spare
        # DNE; on_spare made false in B1
      end
    elsif @ball == 3 # Not needed; B3 only in 10th
      if @on_strike == 2
      elsif @on_strike == 1
      elsif @on_spare
      end
    end
  end
end
