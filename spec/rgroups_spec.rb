require 'rgroups'
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
  
  subject { @msg }

  its(:to_s) { should == "TEST ME" }

  its(:source) { should_not be_nil }
end

