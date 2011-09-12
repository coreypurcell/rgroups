$LOAD_PATH.unshift './lib'
require 'rgroups.rb'

class SimpleChat

  def initialize
    @channel = ''
    @user_name = ENV['USER']
  end

  def start
    begin
      @channel = RGroups::Channel.new 
      @channel.connect('ChatCluster') do |message|
        line = "#{message.source}: #{message}"
        puts line
      end
      
      eventLoop
    ensure
      puts "closing channel"
      @channel.close
    end
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

      rescue Exception => e
        puts e.message
        puts e.backtrace
      end
    end
  end


end



SimpleChat.new.start
