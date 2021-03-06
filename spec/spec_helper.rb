# frozen_string_literal: true

require 'bundler/setup'
require 'good_ui'
require 'byebug'

require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.expose_dsl_globally = true

  config.before(:each) do |test|
    unless test.metadata[:skip_boot]
      GoodUi.configure do |c|
        c.ui_file = "#{GoodUi.root}/lib/shared/ui.yml"
      end
      GoodUi.boot
    end
  end

  config.after(:each) do |test|
    GoodUi.configuration.ui_file = nil unless test.metadata[:skip_shutdown]
  end
end
