require 'forwardable'

module RGroups
  class Channel

    alias_method :old_send, :send

    def initialize
      @jchannel = org.jgroups.JChannel.new
      @receiver = Receiver.new
      @jchannel.set_receiver(@receiver)
    end

    def connect(cluster, &blk)
      @jchannel.connect(cluster)
      @receiver.register_receiver(blk)
    end

    def send(msg, options={})
      message = Message.new(msg, options)
      @jchannel.send(message.jmessage)
    end

    def close
      @jchannel.close
    end

  end
end
