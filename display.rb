require "./game.rb"
require "tty-table"
require "tty-prompt"

class Display < Game
  attr_accessor :player_name

  def initialize
    super
    @player_name = ""
  end

  def player
    prompt = TTY::Prompt.new
    @player_name = prompt.ask("Player 1 Name:", required: true)
  end
end
