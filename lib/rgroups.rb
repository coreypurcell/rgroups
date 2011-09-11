module RGroups
  class Channel < org.jgroups.JChannel

    alias_method :old_send, :send

    def initialize
      super
      # if options
      #   @jchannel = org.jgroups.JChannel.new(options)
      # else
      #   @jchannel = org.jgroups.JChannel.new
      # end

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

  end

  class Message < org.jgroups.Message

    alias_method :source, :get_src
    alias_method :destination, :get_dest
    alias_method :data, :get_object

    def initialize(dest, src, msg)
    end

    def to_s
      data.to_s
    end

  end

  class Receiver < org.jgroups.ReceiverAdapter

    def initialize
      @blk = nil
    end

    def register_receiver(blk)
      @blk = blk
    end

    def receive(msg)
      @blk.call(msg)
    end

    def viewAccepted(new_view)
      puts "** view: #{new_view}"
    end

  end
end
