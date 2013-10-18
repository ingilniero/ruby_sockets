require 'socket'               # Get sockets from stdlib
require 'pry'

server = TCPServer.open(2000)  # Socket to listen on port 2000
messages = []
loop {                         # Servers run forever
  client = server.accept       # Wait for a client to connect
  request = Request.parse(client.gets)
  messages.push({
    message: request.body,
    created_at: Time.now
  })
  client.puts messages.select{|m| m.created_at > request.headers['LAST-CHAT-TIME']}.join
  client.close                 # Disconnect from the client
}
