# frozen_string_literal: true

# handles loading and serving of the configuration files
module DcUi
  # contains the configuration itself
  class Configuration
    attr_accessor :ui_file
    def initialize
      @ui_file = nil
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  def self.boot
    raise 'No ui file provided!' if configuration.ui_file.nil?
    # Parse the configuration file into Hashie
    configuration.ui_file = Hashie::Mash.load(configuration.ui_file)
  end
end
