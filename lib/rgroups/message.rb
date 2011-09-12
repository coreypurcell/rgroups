module RGroups
  class Message < org.jgroups.Message

    alias_method :source, :get_src
    alias_method :destination, :get_dest
    alias_method :data, :get_object

    def initialize(dest, src, msg)
    end

    def to_s
      get_object.to_s
    end

  end
end
