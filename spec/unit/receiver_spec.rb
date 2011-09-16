require 'java'
require_relative '../../vendor/jgroups-2.12.1.Final.jar'
require_relative "../../lib/rgroups/receiver"
require_relative "../../lib/rgroups/message"

include RGroups
describe Receiver do

  describe :receive do

    it "builds a message from jmessage" do
      receiver = Receiver.new
      @msg = nil
      receiver.register_receiver {|msg| @msg = msg}

      dest = org.jgroups.stack.IpAddress.new("127.0.0.1", 80)
      src = org.jgroups.stack.IpAddress.new("192.168.1.1", 443)
      jmsg = org.jgroups.Message.new(dest, src, "MESSAGE")
      receiver.receive(jmsg)

      @msg.should_not be_nil
      @msg.to_s.should == "MESSAGE"
      @msg.source.to_s.should == "192.168.1.1:443"
      @msg.destination.to_s.should == "127.0.0.1:80"

    end

  end

end
