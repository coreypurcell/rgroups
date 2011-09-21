require 'java'
require_relative '../vendor/jgroups-2.12.1.Final.jar'
require_relative "rgroups/channel"
require_relative "rgroups/message"
require_relative "rgroups/receiver"

require 'logger'

module RGroups
  class << self
    def logger
      @logger ||= Logger.new(STDOUT)
    end

    attr_writer :logger
  end
end
