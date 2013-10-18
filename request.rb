class Request
  REQUEST_SEPARATOR = "\r\n\r\n"
  HEADER_SEPARATOR = "\r\n"
  def self.parse(request)
    headers, body = request.split(REQUEST_SEPARATOR, 2)
    request = new
    request.headers = Hash[headers.split(HEADER_SEPARATOR, 2).map{ |header| header.split(' ', 2) }]
    request.body = body
    request
  end

  attr_accessor :body, :headers

  def to_s
    "#{headers.map{ |k, v| "#{k} #{v}" }.join(HEADER_SEPARATOR)}#{REQUEST_SEPARATOR}#{body}"
  end
end
