$LOAD_PATH.unshift './lib'
require 'rgroups'

channel = RGroups::Channel.new

begin
  channel.connect('ObjectCluster') do |msg|
    puts msg.data.to_a.inspect
  end

  # send any old java object through
  channel.send([1,2,3].to_java)
ensure
  channel.close
end
