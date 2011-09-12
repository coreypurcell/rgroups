module RGroups
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

    def setState(new_state)

    end

    def getState

    end

  end
end
