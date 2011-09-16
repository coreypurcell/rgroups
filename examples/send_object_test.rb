$LOAD_PATH.unshift './lib'
require 'rgroups'


RGroups::Channel.connect 'ObjectCluster' do
  receiver do |message|
    puts message.data.to_a.inspect
  end

  # send any old java object through
  send_message([1,2,3].to_java)
end
