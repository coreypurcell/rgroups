# Straight port from docs
# http://www.jgroups.org/tutorial/html/ch02.html

require 'rubygems'
require 'ruby-debug'
require 'java'
require 'jgroups-2.12.1.Final.jar'

import org.jgroups.JChannel

class SimpleChat < org.jgroups.ReceiverAdapter
  def initialize
    @channel = ''
    @user_name = ENV['USER']
    @state = "" 
  end

  def start
    @channel = JChannel.new
    @channel.setReceiver(self)
    @channel.connect('ChatCluster')
    @channel.getState(nil, 10000)
    eventLoop
    @channel.close
  end

  def eventLoop
    loop do
      begin
        print "> "
        input = gets
        if input =~ /^quit|^exit/
          break
        end
        input = "[#{@user_name}]" + input
        puts "-- input:  #{input}"
        msg = org.jgroups.Message.new(nil,nil,input)
        @channel.send(msg)
      rescue Exception => e
        puts e.message
        puts e.backtrace
      end
    end
  end

  def getState
    begin
      @state.to_java_bytes
    rescue Exception => e
      puts e.message
      puts e.backtrace
      nil
    end
  end

  def setState(new_state)
    begin
      list = String.from_java_bytes new_state
      @state = list
      puts "received state (#{list.split("\n").size} messages in chat history):"
      puts list
    rescue Exception => e
      puts e.message
      puts "------------"
      puts e.backtrace
    end
  end

  def viewAccepted(new_view)
    puts "** view: #{new_view}"
  end

  def receive(msg)
    line = "#{msg.getSrc}: #{msg.getObject}"
    puts line
    @state << line
  end
end



SimpleChat.new.start
