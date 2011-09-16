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
      channel.connect(cluster, &blk)
    end

    def connect(cluster, &blk)
      @jchannel.connect(cluster)
      instance_exec(&blk)
      @jchannel.close
    end

    def receiver(&blk)
      @receiver.register_receiver(&blk)
    end

    def send_message(msg, options={})
      message = Message.new(msg, options)
      @jchannel.send(message.jmessage)
    end

  end
end
