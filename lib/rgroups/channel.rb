# Channel uses JChannel to connect to the cluster and send messages
#

module RGroups
  class Channel

    def initialize
      @jchannel = org.jgroups.JChannel.new
      @receiver = Receiver.new
      @jchannel.set_receiver(@receiver)
    end

    def self.connect(cluster, &blk)
      channel = Channel.new
      channel.connect_and_close(cluster, &blk)
    end

    def self.bind(cluster, &blk)
      channel = Channel.new
      channel.connect(cluster, &blk)
    end

    def connect(cluster, &blk)
      @jchannel.connect(cluster)
      yield self
      self
    end

    def connect_and_close(cluster, &blk)
      @jchannel.connect(cluster)
      yield self
      close
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
