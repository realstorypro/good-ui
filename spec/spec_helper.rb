# frozen_string_literal: true

require 'bundler/setup'
require 'dc_ui'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.expose_dsl_globally = true

  config.before(:each, boot: true) do
    DcUi.configure do |c|
      c.ui_file = "#{DcUi.root}/lib/shared/ui.yml"
    end
    DcUi.boot
  end
end
