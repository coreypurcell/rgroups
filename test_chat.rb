# Straight port from docs
# http://www.jgroups.org/tutorial/html/ch02.html

require 'java'
require 'jgroups-2.12.1.Final.jar'

import org.jgroups.JChannel

class SimpleChat < org.jgroups.ReceiverAdapter
  def initialize
    @@channel = ''
    @@user_name = ENV['USER']
  end

  def start
    @@channel = JChannel.new
    @@channel.setReceiver(self)
    @@channel.connect('ChatCluster')
    eventLoop
    @@channel.close
  end

  def eventLoop
    loop do
      begin
        print "> "
        input = gets
        if input =~ /^quit|^exit/
          break
        end
        input = "[#{@@user_name}]" + input
        puts "-- input:  #{input}"
        msg = org.jgroups.Message.new(nil,nil,input)
        @@channel.send(msg)
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end
    end
  end

  def viewAccepted(new_view)
    puts "** view: #{new_view}"
  end

  def receive(msg)
    puts "#{msg.getSrc}: #{msg.getObject}"
  end
end



SimpleChat.new.start
