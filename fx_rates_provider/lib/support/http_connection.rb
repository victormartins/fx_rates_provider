# Adds an http_connection to consumer class.
module HTTPConnection
  require 'net/http'

  def http_get(url)
    response = Net::HTTP.get_response(url)

    handle_http_error unless response.is_a? Net::HTTPSuccess
    response.body
  end

  private

  def handle_http_error
    raise 'Failure to connect.'
  end
end
