module ConvertLoop
  class Person
    def initialize(client)
      puts "Client: #{client}"
      raise RuntimeError, "No client provided" if client.nil?
      @client = client
    end

    def create_or_update(args={})
      raise ArgumentError, "No args provided" if args.nil?
      if args[:pid].nil? && args[:user_id] && args[:email]
        raise ArgumentError, "You must supply at least one of the following keys: ':pid' (to update), or ':user_id' and/or ':email' (to create or update)"
      end

      @client.post("/people", args)
    end
  end
end
