require 'hashie'

require 'dc_ui/version'
require 'dc_ui/configuration'

module DcUi
  def self.root
    File.expand_path '../..', __FILE__
  end
end
