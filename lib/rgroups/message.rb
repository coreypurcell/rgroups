module RGroups
  class Message

    attr_accessor :jmessage

    def initialize(message=nil, options={})
      if message
        @jmessage = org.jgroups.Message.new(options[:destination],
                                            options[:source],
                                            message)
      else
        @jmessage = nil
      end
    end

    def source
      @jmessage.get_src
    end

    def destination
      @jmessage.get_dest
    end

    def data
      @jmessage.get_object
    end

    def to_s
      @jmessage.get_object.to_s
    end

  end
end
