$LOAD_PATH.unshift './lib'
require 'rgroups'
begin
  require 'ffi-ncurses'
  require 'highline/import'
rescue LoadError
  puts "Please load the highline and ffi-ncurses gems"
  puts " ** jruby -S gem install ffi-ncurses highline"
  exit
end

class SimpleChat

  def self.start
    RGroups::Channel.connect('ChatCluster') do |ch|
      ch.receiver do |message|
        line = "#{message.source}: #{message}"
        puts line
      end

      say("Welcome to SimpleChat")

      loop do
        msg = ask("Message >")
        if msg =~ /^quit|^exit/
          break
        end
        msg = "[#{ENV['USER']}] #{msg}"
        ch.send_message(msg)
      end
    end
  end

end



SimpleChat.start
