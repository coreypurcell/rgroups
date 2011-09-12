## A JRuby wrapper to the JGroups toolkit

[JGroups](http://www.jgroups.org) is toolkit that allows reliable
multicast communication.

This wrapper will be attempt to expose some of the basic but hopefully
useful parts of the API in a ruby fashion. Starting with the ability to
send messages to the cluster. 

Let's see some code:

    gem install rgroups
    
    require 'rgroups'
    
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

