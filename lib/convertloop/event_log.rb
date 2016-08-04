module ConvertLoop
  class EventLog
    def initialize(client)
      raise RuntimeError, "No client provided" if client.nil?
      @client = client
    end

    def send(args={})
      raise ArgumentError, "No args provided" if args.nil?
      raise ArgumentError, "No event name provided" if args[:name].nil? || args[:name].empty?

      @client.post("/event_logs", args)
    end
  end
end
