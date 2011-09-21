require_relative '../lib/rgroups'

# Using this style will automatically close the channel
# when it reaches the end of the connect block
RGroups::Channel.connect 'ObjectCluster' do |ch|
  ch.receiver do |message|
    puts message.data.to_a.inspect
  end

  # send any old java object through
  ch.send_message([1,2,3].to_java)

  # closed channel automatically
end

puts "***************************"
puts "***************************"

# Bind an instance of the channel to use later
channel = RGroups::Channel.bind 'ObjectCluster2' do |ch|
  ch.receiver do |message|
    puts message
  end
end

#send messages from outside the block
channel.send_message("Outside the block")
#don't forget to close the channel with this style
channel.close



