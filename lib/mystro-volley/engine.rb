module MystroVolley
  class Engine < ::Rails::Engine
    isolate_namespace MystroVolley

    initializer "volley.autoload.paths" do |app|
      app.config.autoload_paths += Dir[root.join('app','models','{**}')]
    end
  end
end
