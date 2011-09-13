# ReceiverAdapters are what actually receive messages from the cluster
#

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

    # seems I need camel case here to override superclass
    def viewAccepted(new_view)
      RGroups.logger.info "** view: #{new_view}"
    end

  end
end
