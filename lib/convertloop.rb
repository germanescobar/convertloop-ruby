require File.expand_path('convertloop/client.rb', File.dirname(__FILE__))

# Ruby client of the ConvertLoop API
module ConvertLoop

  $convertloop_version = "0.1.1"

  class << self
    def configure(options={})
      @client = ConvertLoop::Client.new(options)
    end

    def method_missing(method_name, *args, &block)
      raise RuntimeError, "Please call ConvertLoop.configure(:app_id => '...', :api_key => '...') first" if @client.nil?
      @client.send(method_name, *args, &block)
    end

    def respond_to_missing?(method_name, include_private=false)
      raise RuntimeError, "Please call ConvertLoop.configure(:app_id => '...', :api_key => '...') first" if @client.nil?
      @client.respond_to?(method_name, include_private)
    end

    def reset!
      @client = nil
    end
  end

end
