# Channel uses JChannel to connect to the cluster and send messages
#

module RGroups
  class Channel

    def initialize
      @jchannel = org.jgroups.JChannel.new
      @receiver = Receiver.new
      @jchannel.set_receiver(@receiver)
    end

    def self.bind(cluster, &blk)
      channel = Channel.new
      channel.connect(cluster, &blk)
      channel
    end

    def self.connect(cluster, &blk)
      channel = self.bind(cluster, &blk)
      channel.close
    end

    def connect(cluster)
      @jchannel.connect(cluster)
      yield self
    end

    def receiver(&blk)
      @receiver.register_receiver(&blk)
    end

    def send_message(msg, options={})
      message = Message.new(msg, options)
      @jchannel.send(message.jmessage)
    end

    def close
      @jchannel.close
    end

  end
end
