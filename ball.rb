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
