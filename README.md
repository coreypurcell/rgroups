## A JRuby wrapper to the JGroups toolkit

[JGroups](http://www.jgroups.org) is toolkit that allows reliable
multicast communication.

This wrapper will be attempt to expose some of the basic but hopefully
useful parts of the API in a ruby fashion. Starting with the ability to
send messages to the cluster. 

Watch out for network configuration errors. If you see errors stating
that the network is down, then you likely don't have multicasting 
setup correctly on network, or you are on a WIFI network. See the
[JGroups site](http://www.jgroups.org/tutorial/html/ch01.html#d0e142)
for information on how to run without a network.

Let's see some code:
    
    # make a channel object and connect to the cluster
    channel = RGroups::Channel.new

    # connect to the multicast cluster
    # pass a block that will be called when a new message arrives
    channel.connect('MyCluster') do |message|
      puts "#{message.source}: #{message}"
    end

    # sending a message
    channel.send('Howdy')
    channel.send('Hi', {:source => '192.168.1.1', 
                        :destination => '192.168.1.100')

    # you can actually send any java object
    channel.send([1,2,3].to_java)
    # handle it on receive
    message.data.to_a 
     

    # close the channel
    channel.close
  
  

Check the examples to see an application using the library
 
    # run an example
    jruby --1.9 examples/rchat_test.rb


Features I'd like to add:

  * More examples
  * use JGroups shared state facilities

