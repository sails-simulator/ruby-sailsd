require 'json'
require 'socket'

class Sailsd
  attr_reader :latitude
  attr_reader :longitude
  attr_reader :heading
  attr_reader :rudder_angle
  attr_reader :sail_angle
  attr_reader :speed

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

  def update()
    connect()

    r = send_hash({
      :request => [
        'latitude',
        'longitude',
        'heading',
        'rudder-angle',
        'sail-angle',
        'speed'
      ]
    })

    @latitude = r['latitude']
    @longitude = r['longitude']
    @heading = r['heading']
    @rudder_angle = r['rudder-angle']
    @sail_angle = r['sail-angle']
    @speed = r['speed']
  end
end
