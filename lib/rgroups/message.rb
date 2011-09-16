# jgroups.Messages get passed through the cluster
# Wrap that in our Message class for convience

module RGroups
  class Message

    attr_reader :jmessage

    def initialize(message=nil, options={})
        @jmessage = org.jgroups.Message.new(options[:destination],
                                            options[:source],
                                            message)
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
