module RGroups
  class Channel < org.jgroups.JChannel

    alias_method :old_send, :send

    def initialize
      super
      @receiver = Receiver.new
      set_receiver(@receiver)
    end

    def connect(cluster, &blk)
      # calling super(cluster) produces an error in the CodeGenUtils java class
      # -- so hacking around it
      # oddly just renaming my method to rconnect and calling the super's connect
      # method works just fine 
      org.jgroups.JChannel.instance_method(:connect).bind(self).call(cluster)
      @receiver.register_receiver(blk)
    end

    def send(msg, options={})
      destination = options[:destination]
      source = options[:source]
      message = Message.new(destination,source,msg)
      super(message)
    end

    # def bind(state, &blk)
    #   @receiver
    # end

  end
end
