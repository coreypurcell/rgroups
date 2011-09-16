require_relative '../../lib/rgroups'
describe RGroups do
  
  before(:all) do
    @msg = ""
    RGroups::Channel.connect 'TestCluster' do |ch|
      ch.receiver do |message|
       @msg = message
      end

      ch.send_message "TEST ME"
    end

  end
  
  it "receives a send message" do
    @msg.to_s.should == "TEST ME"
  end

  it "sets the source for the message" do
    @msg.source.should_not be_nil
  end
end

