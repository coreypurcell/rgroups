$LOAD_PATH.unshift './lib'
require 'rgroups.rb'

class SimpleChat
  def initialize
    @channel = ''
    @user_name = ENV['USER']
    @state = "" 
  end

  def start
    @channel = RGroups::Channel.new 
    @channel.connect('ChatCluster') do |message|
      line = "#{message.get_src}: #{message}"
      puts line
    end
    @channel.bind do |state|
      puts "state: #{state}"
    end
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
        @channel.send(input)
        @channel.state = @channel.state + input
      rescue Exception => e
        puts e.message
        puts e.backtrace
      end
    end
  end


end



SimpleChat.new.start
