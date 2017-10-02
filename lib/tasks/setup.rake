namespace :dc_ui do
  desc 'Copies ui.yml & initializer to application'
  task :setup do
    dcui_copy 'ui.yml', 'config/ui.yml', 'coping ui.yml'
    dcui_copy 'initializer.rb', 'config/initializers/dc_ui.rb', 'copying initializer'
  end
end

def dcui_copy(file, to, message)
  puts message
  source = File.join File.dirname(__FILE__), "../shared/#{file}"
  destination = Rails.root.join(to).to_s
  FileUtils.cp_r source.to_s, destination
end
