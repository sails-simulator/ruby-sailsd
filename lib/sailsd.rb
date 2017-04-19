require 'json'
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
    return @socket.gets
  end

  def send_hash(hash)
	  bytes = JSON.generate(hash)
    ret = send_bytes(bytes)
    return JSON.parse(ret)
  end
end
