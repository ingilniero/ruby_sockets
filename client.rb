require 'socket'      # Sockets are in standard library

hostname = 'localhost'
port = 2000

loop do
  message = gets
  request = Request.new.tap do |r|
    r.headers = { 'LAST-CHAT-TIME' => Time.now }
    r.body = message
  end
  s = TCPSocket.open(hostname, port)
  s.puts request.to_s
  while line= s.gets   # Read lines from the socket
    puts line.chop      # And print with platform line terminator
  end
  s.close               # Close the socket when done
end
