require 'rails'

module DcUi
  # ads helper to the action view
  class Railtie < ::Rails::Railtie
    initializer 'dc_ui.configure_view_controller' do
      ActiveSupport.on_load :action_view do
        include DcUi::Helpers
      end
    end

    railtie_name :dc_ui
    rake_tasks do
      load 'tasks/copy.rake'
    end
  end
end