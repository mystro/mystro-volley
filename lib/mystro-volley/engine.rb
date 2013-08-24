module MystroVolley
  class Engine < ::Rails::Engine
    isolate_namespace MystroVolley

    config.to_prepare do
      ApplicationController.helper(ApplicationHelper)
    end

    initializer "volley.autoload.paths" do |app|
      app.config.autoload_paths += Dir[root.join('app','models','{**}')]
    end
  end
end
