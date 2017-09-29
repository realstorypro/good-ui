module DcUi
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
  end
end
