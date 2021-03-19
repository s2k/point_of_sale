# frozen_string_literal: true

# The simplest MessageReceiver I can think of,
# prints received messages to STDOUT
#
class MessageReceiver
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
