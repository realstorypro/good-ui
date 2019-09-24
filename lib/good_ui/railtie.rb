# frozen_string_literal: true

require 'rails'

module GoodUi
  # ads helper to the action view
  class Railtie < ::Rails::Railtie
    initializer 'good_ui.configure_view_controller' do
      ActiveSupport.on_load :action_view do
        include GoodUi::Helpers
      end
    end

    railtie_name :good_ui
    rake_tasks do
      load 'tasks/setup.rake'
    end
  end
end
