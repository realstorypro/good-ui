# frozen_string_literal: true

require 'hashie'
require 'singleton'

require 'good_ui/version'
require 'good_ui/configuration'
require 'good_ui/utilities'
require 'good_ui/component'

require 'good_ui/helpers'
require 'good_ui/railtie'

module GoodUi
  def self.root
    File.expand_path '../..', __FILE__
  end
end
