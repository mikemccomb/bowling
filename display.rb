require "./game.rb"
require "tty-table"
require "tty-prompt"

class Display < Game
  attr_accessor :player_name

  def initialize
    super
  end

  def player_name
    prompt = TTY::Prompt.new
    prompt.ask("What is your name?") do |q|
      q.required true
      q.validate /\A\w+\Z/
      q.modify :capitalize
    end
  end

  def number_players
    prompt = TTY::Prompt.new
    prompt.ask("How many players?") do |q|
      q.in "1-6"
      q.messages[:range?] = "Please enter a number (maximum 6)"
    end
  end
end
