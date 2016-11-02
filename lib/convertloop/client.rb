require File.expand_path('person.rb', File.dirname(__FILE__))
require File.expand_path('event_log.rb', File.dirname(__FILE__))
require 'net/http'
require 'net/https'
require 'json'

module ConvertLoop
  class Client
    def initialize(options={})
      @host = options[:host] || "https://api.convertloop.co"
      @version = options[:version] || "v1"
      @app_id = options[:app_id]
      @api_key = options[:api_key]

      raise ArgumentError, "Missing key ':app_id'" if @app_id.nil? || @app_id.empty?
      raise ArgumentError, "Missing key ':api_key'" if @api_key.nil? || @api_key.empty?
    end

    def people
      puts "Self: #{self}"
      ConvertLoop::Person.new(self)
    end

    def event_logs
      ConvertLoop::EventLog.new(self)
    end

    def post(resource, body)
      uri = URI.parse("#{url}#{resource}")
      http = get_http(uri)

      request = Net::HTTP::Post.new(uri.path)
      request.basic_auth @app_id, @api_key
      request['Content-Type'] = 'application/json'
      request['Accept'] = 'application/json'
      request['X-API-Source'] = "ruby-#$convertloop_version"
      request.body = body.to_json

      response = http.request(request)
      parse_json_response(response)
    end

    def url
      "#{@host}/#{@version}"
    end

    def get_http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme == 'https'
        http.use_ssl = true
      end

      return http
    end

    def parse_json_response(response)
      case response
        when Net::HTTPSuccess
          JSON.parse(response.body)
        else
          response.error!
      end
    end
  end
end
