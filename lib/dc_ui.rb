# frozen_string_literal: true

require 'hashie'
require 'singleton'

require 'dc_ui/version'
require 'dc_ui/configuration'
require 'dc_ui/utilities'
require 'dc_ui/component'

require 'dc_ui/railtie'

module DcUi
  def self.root
    File.expand_path '../..', __FILE__
  end
end
