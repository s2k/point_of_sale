# frozen_string_literal: true

# The simplest Display I can think of.
# * Uses STDOUT uf nothing else is provided
# * Reacts to updates that include a message _name_ and arguments
#
class Display
  def initialize(io = STDOUT)
    @io = io
  end

  def update(received_message)
    io.puts "#{self.class} says:"
    io.puts received_message
    io.puts
  end

  private
  attr_reader :io
end
