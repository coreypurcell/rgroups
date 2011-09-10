require 'forwardable'

module RGroups
  class Channel

    extend Forwardable

    def_delegators :@jchannel, :connect, :close

    def initialize(&blk)
      @jchannel = org.jgroups.JChannel.new

      @receiver = Receiver.new
      @receiver.register_receiver(blk)
      @jchannel.setReceiver(@receiver)
    end

    def send(msg, options=nil)
      message = org.jgroups.Message.new(nil,nil,msg)
      @jchannel.send(message)
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
