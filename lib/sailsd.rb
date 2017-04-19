require 'socket'

class Sailsd
  def initialize()
    @socket = nil
  end

  def connect()
    @socket = TCPSocket.open('localhost', 3333)
  end

  def send_bytes(msg)
    @socket.puts(msg)
  end
end
