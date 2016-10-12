require 'net/http'
require 'net/https'

class UrlSource
  # UrlSource.new(url_string).stream_response
  def initialize(source_url)
    @source_url = source_url
  end

  def stream_response()
    response = http_call(@source_url)
    response.code.to_i != 200 ?  {:status => "error" ,:body => "Error getting data at url (response code is #{response.code.to_i.to_s}): & body = #{response.body}"+ @source_url } : {:status => "OK", :body => response.body }
  end

  private
  def http_call(source_url)
    use_ssl = (source_url.downcase.start_with?('https'))
    uri = URI.parse(source_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = use_ssl
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE if use_ssl
    request = Net::HTTP::Get.new("#{uri.path}?#{uri.query}")
    http.start {|http| http.request(request)}
  end
end
