require 'java'
require 'rgroups'

describe RGroups do

  context "when sending messages to the cluster" do

    before(:all) do
      @msg = ""
      RGroups::Channel.connect 'TestCluster' do |ch|
        ch.receiver do |message|
         @msg = message
        end

        ch.send_message("TEST ME")
      end

    end

    it "receives the message's object" do
      @msg.to_s.should == "TEST ME"
    end


    it "receives the message from a source" do
      @msg.source.should_not be_nil
    end

  end
end

