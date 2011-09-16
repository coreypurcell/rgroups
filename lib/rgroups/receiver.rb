# ReceiverAdapters are what actually receive messages from the cluster
#

module RGroups
  class Receiver < org.jgroups.ReceiverAdapter

    def initialize
      @blk = lambda do |msg|
        RGroups.logger.warn "** No Receive Callback was registered **" 
      end
    end

    def register_receiver(&blk)
      @blk = blk
    end

    def receive(jmessage)
      msg = Message.new(jmessage.get_object, {:source => jmessage.get_src,
                         :destination => jmessage.get_dest})
      @blk.call(msg)
    end

    # seems I need camel case here to override superclass
    def viewAccepted(new_view)
      RGroups.logger.info "** view: #{new_view}"
    end

  end
end
