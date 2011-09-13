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

    def view_accepted(new_view)
      RGroups.logger.info "** view: #{new_view}"
    end

  end
end
