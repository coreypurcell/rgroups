require 'java'
require_relative '../../vendor/jgroups-2.12.1.Final.jar'
require "rgroups/receiver"
require "rgroups/message"

include RGroups
describe Receiver do

  describe :receive do
    let(:receiver){ Receiver.new }

    before do
      @msg = nil
      receiver.register_receiver {|msg| @msg = msg}

      dest = org.jgroups.stack.IpAddress.new("127.0.0.1", 80)
      src = org.jgroups.stack.IpAddress.new("192.168.1.1", 443)
      jmsg = org.jgroups.Message.new(dest, src, "MESSAGE")
      receiver.receive(jmsg)
    end

    subject { @msg }

    it { should_not be_nil }
    its(:to_s) { should == "MESSAGE" }
    its("source.to_s") { should == "192.168.1.1:443" }
    its("destination.to_s") { should == "127.0.0.1:80" }

  end

end
