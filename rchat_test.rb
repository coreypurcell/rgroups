require 'java'
require 'jgroups-2.12.1.Final.jar'
require 'lib/rgroups.rb'

class SimpleChat
  def initialize
    @channel = ''
    @user_name = ENV['USER']
    @state = "" 
  end

  def start
    @channel = RGroups::Channel.new do |message|
      line = "#{message.getSrc}: #{message.getObject}"
      puts line
    end
    @channel.connect('ChatCluster')
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
        @channel.send(input)
      rescue Exception => e
        puts e.message
        puts e.backtrace
      end
    end
  end


end



SimpleChat.new.start
