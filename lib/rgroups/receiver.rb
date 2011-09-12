module RGroups
  class Receiver < org.jgroups.ReceiverAdapter

    def initialize
      @blk = nil
      @state = nil
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

    def register_state(blk)
      @state_blk = blk
    end

    def setState(new_state)
      @state = String.from_java_bytes new_state
      @state_blk.call(new_state)
    end

    def getState
      @state.to_java_bytes
    end

  end
end
