module RGroups

  class << self
    attr_accessor :logger
  end

  @logger = Logger.new(STDOUT)

end
