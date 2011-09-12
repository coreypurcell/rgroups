module RGroups
  class Receiver < org.jgroups.ReceiverAdapter

    def initialize
      @blk = nil
    end

    def register_receiver(blk)
      @blk = blk
    end

    def receive(jmessage)
      msg =  Message.new
      msg.jmessage = jmessage
      @blk.call(msg)
    end

    def viewAccepted(new_view)
      RGroups.logger.info "** view: #{new_view}"
    end

  end
end
