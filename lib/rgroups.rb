require 'java'
require 'jgroups-2.12.1.Final.jar'
require "rgroups/version"
require "rgroups/channel"
require "rgroups/message"
require "rgroups/receiver"

autoload :Logger, 'logger'

module RGroups

  @logger = Logger.new(STDOUT)

  def self.logger
    @logger
  end

  def self.logger=(logger)
    @logger = logger
  end

end
